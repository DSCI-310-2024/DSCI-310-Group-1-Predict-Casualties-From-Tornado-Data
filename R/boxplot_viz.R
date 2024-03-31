#' Boxplot Viz
#'
#' Creates a boxplot visualization from a specified column.
#'
#' @param data_frame a data frame or data frame extension 
#' 
#' @param col an unquoted column name from the data frame
#' 
#' @return A boxplot of single variable of interest
#' 
#' @export
#' 
#' @examples
#' boxplot_viz(test_data, fatalities)

boxplot_viz <- function(data_frame, col) {
    if (!is.data.frame(data_frame)) {
        stop("`data_frame` should be a data frame or a data frame extension")
    }

    if (nrow(data_frame) == 0) {
        stop("'data_frame' should not be empty")
    }

    if (!(deparse(substitute(col)) %in% colnames(data_frame))) {
      stop("'col' should be a column name in the data frame")
    }

    options(repr.plot.width = 7, repr.plot.height = 7)

    ggplot2::ggplot(data = data_frame, ggplot2::aes(y = {{ col }})) +
        ggplot2::geom_boxplot() +
        ggplot2::theme(text = ggplot2::element_text(size = 14))
}
