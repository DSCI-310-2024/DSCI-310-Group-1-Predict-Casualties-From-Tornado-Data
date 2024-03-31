#' Creates a scatter plot 
#'
#' Creates a scatter plot from the provided data comparing the accuracy of
#' a regression model to the actual observations
#'
#' @param predictions a dataframe containing predictions from a linear model fit
#' @param pred_var an unquoted column name
#'
#' @return A scatter plot of two numerical features 
#' @export
#'
#' @examples
#' accuracy_plot(fatal_predictions, fatalities) + 
#' labs(x = "Actual Number of Fatalities", y = "Predicted Number of Fatalities")

accuracy_plot <- function(predictions, pred_var) {
    if (!is.data.frame(predictions)) {
        stop("`data` should be a data frame or a tibble")
        }
    if (nrow(predictions) == 0) {
        stop("The data frame should not be empty")
        }

    options(repr.plot.width = 7, repr.plot.height = 7)

    ggplot2::ggplot(predictions, ggplot2::aes(x = {{ pred_var }},  y = .pred)) + 
        ggplot2::geom_point(alpha = 0.6) +
        ggplot2::geom_abline(intercept = 0, slope = 1, color = "red", linetype = "dashed", linewidth = 2)+
        ggplot2::scale_x_continuous(trans = "log10") +
        ggplot2::theme(text = element_text(size = 14), plot.title = element_text(hjust = 0.5))
}
