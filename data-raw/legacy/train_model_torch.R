# train and save the model into the package folder

library(tidyverse)

library(future.callr)
plan(callr, workers = 22)

Rcpp::sourceCpp("data-raw/char_split.cpp")

voter_df <- fs::dir_ls("~/Downloads/florida_voter/20170207_VoterDetail", glob = "*.txt") %>%
  as.character() %>%
  furrr::future_map_dfr(~read_tsv(.x, col_names = c("county_code", "voter_id", "name_last", "name_suffix", "name_first",
                                      "name_middle", "exemption", "residence_line1", "residence_line2",
                                      "residence_city", "residence_state", "residence_zipcode",
                                      "mailing_address_line1", "mailing_address_line2", "mailing_address_line3",
                                      "mailing_address_city", "mailing_address_state", "mailing_address_zipcode",
                                      "mailing_address_country", "gender", "race", "birth_date", "registration_date",
                                      "party_affiliation", "precinct", "precinct_group", "precinct_split",
                                      "precinct_suffix", "voter_status", "congressional_district", "house_district",
                                      "senate_district", "county_commission_district", "school_board_district",
                                      "daytime_area_code", "daytime_phone_number", "daytime_phone_extension",
                                      "email_address"),
                    col_types = cols(.default = "c")))

voter_names <- voter_df %>%
  select(name_first, name_middle, name_last, race, gender)

# write_rds(voter_names, "data/voter_names_race.rds", compress = "gz")
voter_names <- read_rds("data/voter_names_race.rds")
# write_csv(voter_names, "data/voter_names_race.csv")
# voter_names %>%
#   filter(race == 9)

############################################################################
# create two count dataset for later documentation purpose
############################################################################

voter_names <- voter_names %>%
  filter(race %in% 1:5) %>%
  filter(name_first != "*" & name_last != "*" & nchar(name_last) > 1)

voter_racecount_before <- voter_names %>%
  count(race)

set.seed(0)
voter_names_undersample <- voter_names %>%
  group_by(race) %>%
  slice_sample(n = min(voter_racecount_before$n)) %>%
  ungroup()

voter_racecount_after <- voter_names_undersample %>%
  count(race)

voter_rebalance <- bind_cols(
  voter_racecount_before %>%
    select(race, n_before = n),
  voter_racecount_after %>%
    select(-race, n_after = n)
)

# save the group count dataframe
write_rds(voter_rebalance, "data-raw/voter_rebalance.rds")

final_name <- voter_names_undersample %>%
  select(-name_middle, -gender) %>%
  mutate(name_first = str_to_title(name_first), name_last = str_to_title(name_last))

# write_csv(final_name, "data-raw/final_names.csv")

# final_name %>%
#   slice_sample(n = 10)

# TODO: next create bi-char groups, (why not tri-char? etc) and use them as input, race is outcome
# TODO: then check vocabulary distribution and see if we need to filter the most/lesat frequent ones

library(torch)

max_len <- 10

last_names <- pull(final_name, name_last)
races <- as.integer(final_name %>% pull(race))

chars <- purrr::map(last_names, ~char_split(.x))

chars_len <- purrr::map_int(chars, ~length(.x))
inputs <- chars[chars_len <= max_len]
outputs <- races[chars_len <= max_len]

# TODO: create a mapping between unique chars and create identifiers
# TODO: TF-IDF + logistic regression could be easier and better?
input_unique <- unlist(inputs) %>% unique()
id2token <- hash::hash()
token2id <- hash::hash()
walk2(
  1:length(input_unique), 
  input_unique, 
  function(x, y) {
    id2token[[as.character(x)]] <- y
    token2id[[y]] <- x
  })

chars_to_id <- function(chars) map_int(chars, function(x) {token2id[[x]]})
# chars_to_id(chars[[1]])

input_ids <- map(inputs, chars_to_id)
input_ids <- nn_utils_rnn_pad_sequence(input_ids, padding_value = 1)#$to(torch_double())
output_ids <- outputs


# remove char seq with len more than 10

# sum(chars_len >= 10)/length(chars_len)
# 
# quantile(chars_len, c(0, .1, .25, .5, .75, .9, 1))
# quantile(chars_len, seq(0.9, 1, 0.01))
# 
# chars_df <- tibble(char = unlist(chars)) %>%
#   count(char) %>%
#   arrange(desc(n))
# 
# quantile(chars_df$n, c(0, .1, .25, .5, .75, .9, 1))
# 
# # x <- last_names[1]
# # c++ solution
# 
# char_split(x)
# # R solution
# substring(x, 1:(nchar(x)-1), 2:(nchar(x)))
# 
# bench::mark(
#   substring(x, 1:(nchar(x)-1), 2:(nchar(x))),
#   char_split(x)
# )


# torch_is_installed()
# cuda_device_count()

# a <- matrix(rnorm(4000000), ncol = 2000)
# b <- torch_tensor(a)
# c <- torch_tensor(a, requires_grad = FALSE)
#
# microbenchmark::microbenchmark(
#   a * a,
#   b * b,
#   c * c
# )

# need to encode and pan the input before anything?

name_dataset <- dataset(
  name = "name_dataset",

  initialize = function(x, y) {
    # self$maxlen <- maxlen
    assertthat::assert_that(dim(x)[2] == length(y), msg = "input and output not having equal size")
    self$length <- length(x)
    self$x <- x
    self$y <- y
    
  },

  .getitem = function(i) {
    if (i < self$x$size()[2]) {
      list(
        x = self$x[, i+1],
        y = self$y[i+1]
      )
    } else {
      list(
        x = self$x[, self$x$size()[2]],
        y = self$y[self$x$size()[2]]
      )
    }
  },

  .length = function() {
    self$length
  }
)

eval_ratio <- 0.2
test_ratio <- 0.3

# shuffle data
set.seed(0)
train_ids <- sample(1:dim(input_ids)[2], floor(dim(input_ids)[2]*(1-eval_ratio-test_ratio)))
eval_ids <- sample(
  setdiff(1:dim(input_ids)[2], train_ids),
  floor(dim(input_ids)[2]*eval_ratio)
)
test_ids <- setdiff(1:dim(input_ids)[2], train_ids) %>% 
  setdiff(eval_ids)

x_train <- input_ids[, train_ids]
y_train <- output_ids[train_ids]

x_eval <- input_ids[, eval_ids]
y_eval <- output_ids[eval_ids]

x_test <- input_ids[, test_ids]
y_test <- output_ids[test_ids]

# scale the input before moving on
# m = x_train$mean(dim  = 1, keepdim = TRUE)
# s = x_train$std(dim = 1, unbiased = FALSE, keepdim = TRUE)
# x_max <- x_train$max() %>% as_array()
# x_min <- x_train$min() %>% as_array()
# 
# x_train <- (x_train - x_min)/x_max
# x_eval <- (x_eval - x_min)/x_max
# x_test <- (x_test - x_min)/x_max

batch_size <- 512

train_ds <- name_dataset(x_train, y_train)
train_dl <- train_ds %>% 
  dataloader(batch_size = batch_size, shuffle = FALSE)

eval_ds <- name_dataset(x_eval, y_eval)
eval_dl <- eval_ds %>% 
  dataloader(batch_size = batch_size, shuffle = FALSE)

test_dl <- name_dataset(x_test, y_test) %>% 
  dataloader(batch_size = batch_size, shuffle = FALSE)


model <- nn_module(
  
  initialize = function(input_size, hidden_size, vocab_size, embd_size, num_layers = 1, dropout = 0) {
    self$num_layers <- num_layers
    
    self$embd <- nn_embedding(vocab_size, embd_size)
    
    self$lstm <- nn_lstm(
      input_size = embd_size,
      hidden_size = hidden_size,
      num_layers = num_layers,
      dropout = dropout,
      batch_first = TRUE
    )
    
    self$linear <- nn_linear(hidden_size, 5)
    # self$output <- nn_softmax(5)
  },
  
  forward = function(x) {
    embd <- self$embd(x)
    x <- self$lstm(embd)[[1]]
    x <- x[ , dim(x)[2], ]
    self$linear(x)
    # x %>% self$output()
  }
)

device <- torch_device(if (cuda_is_available()) "cuda" else "cpu")
# device <- "cpu"
net <- model(10, 20, length(input_unique)+1, 30, num_layers = 2, dropout = 0.3)
net <- net$to(device = device)

optimizer <- optim_adam(net$parameters, lr = 0.01)
num_epochs <- 10

train_batch <- function(b) {
  optimizer$zero_grad()
  output <- net(b$x$to(device = device))
  target <- b$y$to(device = device)
  
  loss <- nnf_cross_entropy(output, target)
  loss$backward()
  optimizer$step()
  
  loss$item()
}

valid_batch <- function(b) {
  
  output <- net(b$x$to(device = device))
  target <- b$y$to(device = device)
  loss <- nnf_cross_entropy(output, target)
  loss$item()
}


# b <- train_dl %>%
#   dataloader_make_iter() %>%
#   dataloader_next()
# 
# train_batch(b)

train_losses <- c()
eval_losses <- c()

for (epoch in 1:num_epochs) {
  net$train()
  train_loss <- c()
  
  coro::loop(for (b in train_dl) {
    loss <- train_batch(b)
    train_loss <- c(train_loss, loss)
  })
  
  train_losses <- c(train_losses, mean(train_loss))
  # cat(sprintf("\nEpoch %d, training: loss: %3.5f \n", epoch, mean(train_loss)))
  net$eval()
  valid_loss <- c()
  
  coro::loop(for (b in eval_dl) {
    loss <- valid_batch(b)
    valid_loss <- c(valid_loss, loss)
  })
  eval_losses <- c(eval_losses, mean(valid_loss))
  # cat(sprintf("\nEpoch %d, validation: loss: %3.5f \n", epoch, mean(valid_loss)))
  
  cat(sprintf("\nEpoch %d: train loss: %3.5f, val loss: %3.5f \n", epoch, mean(train_loss), mean(valid_loss)))
  
}


# test the result
b <- test_dl %>%
  dataloader_make_iter() %>%
  dataloader_next()

net$eval()
output <- net(b$x$to(device = device))

output$size()
output_sm <- nnf_softmax(output, dim = 2)
preds <- output_sm$argmax(dim = 2)
b$y

preds <- c()

coro::loop(for (b in test_dl) {
  output <- net(b$x$to(device = device))
  preds <- c(preds, )
})


