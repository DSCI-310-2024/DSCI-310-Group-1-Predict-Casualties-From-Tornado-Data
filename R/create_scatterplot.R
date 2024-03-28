#' Creates a scatter plot 
#'
#' Creates a scatter plot from the provided data and specified two numerical 
#' columns
#'
#' @param data data frame or tibble 
#' @param x_col unquoted column name to plot on the x-axis from data 
#' @param y_col unquoted column name to plot on the y-axis from data
#'
#' @return A scatter plot of two numerical features 
#' @export
#'
#' @examples
#' create_scatterplot(tornado_train_data, width, fatalities) + 
#' labs(x = "Width of tornadoes (yards)", y = "Fatalities", 
#' title = "Figure 2: Scatterplot of width (yards) of tornado and fatalities")
create_scatterplot <- function(data, x_col, y_col) {
  
  if (!is.data.frame(data)) {
    stop("`data` should be a data frame or a tibble")}
  
  if (nrow(data) == 0) {
    stop("The data frame should not be empty")}
  
  options(repr.plot.width = 7, repr.plot.height = 7)

  ggplot2::ggplot(data = data, 
                  ggplot2::aes(x = {{ x_col }}, y = {{ y_col }})) +
    ggplot2::geom_point(alpha = 0.4) +
    ggplot2::theme(text = ggplot2::element_text(size = 14), plot.title = ggplot2::element_text(hjust = 0.5)) 
}