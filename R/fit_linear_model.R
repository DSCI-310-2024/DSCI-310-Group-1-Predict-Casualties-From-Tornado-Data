#' Fit Linear Model
#'
#' Creates and fits a linear model to the training data with linear regression.
#'
#' @param formula The model formula. 
#' 
#' @param data The training data.
#' 
#' @return A fitted model workflow object.
#' 
#' @export
#' 
#' @examples
#' fit_linear_model(fatalities ~ width + length, train_data)
fit_linear_model <- function(formula, data) {
  lm_spec <- parsnip::linear_reg() %>%
    parsnip::set_engine("lm") %>%
    parsnip::set_mode("regression")

  lm_recipe <- recipes::recipe(formula, data = data)

  lm_fit <- workflows::workflow() %>%
    workflows::add_recipe(lm_recipe) %>%
    workflows::add_model(lm_spec) %>%
    parsnip::fit(data = data)

  return(lm_fit)
}