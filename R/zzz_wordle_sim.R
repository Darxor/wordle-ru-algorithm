wordle_play <- function(words = dict$words_ru,
                        target_word = dict$words_winning_ru[[1]],
                        .dfm = wordle_dfm,
                        word_weights = dict$word_freq,
                        quiet = TRUE) {
  wordle_game <-
    WordleGame$new(words = words,
                   target_word = target_word,
                   dark_mode = TRUE)
  
  wordle_helper <- WordleHelper$new(nchar = 5,
                                    words = wordle_game$words)
  
  while (!wordle_game$is_solved()) {
    attempt_word <- names(rank_words(
      wordle_helper$words,
      .dfm = .dfm,
      word_freq = word_weights
    ))[1]
    
    attempt_result <-
      wordle_game$try(word = attempt_word, quiet = quiet)
    wordle_helper$update(word = attempt_word, response = attempt_result)
  }
  
  length(wordle_game$attempts)
  
}

wordle_sim <- function(words = dict$words_ru,
                       target_words = dict$words_winning_ru,
                       .dfm = wordle_dfm, word_weights = dict$word_freq) {
  p <- progressr::progressor(along = target_words)
  sims <- furrr::future_map_dbl(
    target_words,
    function(x) {
      p(x)
      wordle_play(x, words = words)
    },
    .options = furrr::furrr_options(seed = TRUE)
  )
}
