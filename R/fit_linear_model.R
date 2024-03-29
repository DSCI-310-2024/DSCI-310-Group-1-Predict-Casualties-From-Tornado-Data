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
  lm_spec <- linear_reg() %>%
    set_engine("lm") %>%
    set_mode("regression")
  
  lm_recipe <- recipe(formula, data = data)
  
  lm_fit <- workflow() %>%
    add_recipe(lm_recipe) %>%
    add_model(lm_spec) %>%
    fit(data = data)
  
  return(lm_fit)
}
