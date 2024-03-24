#' Creates a scatter plot 
#'
#' Creates a scatter plot from the provided data and specified two numerical 
#' columns
#'
#' @param data A data frame 
#' @param xcol The column name from data frame for the x-axis
#' @param ycol The column name from data frame for the y-axis
#' @param xlabel The label (str) for the x-axis in the scatter plot
#' @param ylabel The label (str) for the y-axis in the scatter plot 
#' @param title The title (str) of the scatter plot
#'
#' @return A scatter plot of two numerical features 
#' @export
#'
#' @examples
#' create_scatterplot(data, data$width, data$fatalities, "Width (yards) of 
#' tornadoes", "Fatalities", "Figure 2: Scatterplot of width (yards) of 
#' tornado and fatalities")
create_scatterplot <- function(data, xcol, ycol, xlabel, ylabel, title) {
  
  options(repr.plot.width = 7, repr.plot.height = 7)

  fatalities_width_scatterplot = ggplot(data, aes(x = xcol, y = ycol)) +
    geom_point(alpha = 0.4) +
    xlab(xlabel) +
    ylab(ylabel) +
    theme(text = element_text(size = 14), plot.title = element_text(hjust = 0.5)) + 
    ggtitle(title)
}