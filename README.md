# DSCI-310-Project-Group-1

## Predicting Fatalities from Tornado Data 

- Authors: Erika Delorme, Marcela Flaherty, Riddha Tuladhar, Edwin Yeung

## About 

In our project, we attempt to build a multiple linear regression model that will predict the number of fatalities from tornadoes using the features width (yards) and length (miles) of the tornado. We tested our multilinear regression model with and without outliers and compared differences in coefficients and RMSPE scores. Both models had low positive coefficients, suggesting a minimal yet positive impact on the prediction of tornado fatalities, and both had low RMSPE scores, suggesting a low amount of error in its predictions. The model without outliers had a lower RMSPE score, which is partly explained by the lack of outliers and thus making predictions on a smaller range, which reduces the error. Despite the limitations of our model, we believe that it can still have some utility in predicting tornado fatalities with little error. However, the model should be improved in the future before being deployed to improve the size of the coefficients and its predictive power. In the future, we may consider exploring other features in predicting fatalities, predicting the number of injuries from the same features, or even predicting the number of casualties (injuries and fatalities) from the same and additional features. 

The data set that was used in this project is from the US NOAA's National Weather Service Storm Prediction Center Severe Weather Maps, Graphics, and Data Page. It was tidied and sourced from TidyTuesday and can be found [here](https://github.com/rfordatascience/tidytuesday/tree/master/data/2023/2023-05-16). Each row represents a tornado, along with various features, including width, length, date, time, state in the US, magnitude, financial losses, number of fatalities, number of injuries, etc. 

## Report 

The final report can be found [here](https://github.com/DSCI-310-2024/DSCI-310-Group-1-Predict-Fatalities-From-Tornado-Data/blob/main/src/tornado_fatalities_predictor.ipynb). 

## Dependencies
[Docker](https://www.docker.com/) is a container solution used to manage software dependencies for this project. The docker image in this project is based on the `quay.io/jupyter/r-notebook:r-4.3.2` image. Additional dependencies can be found in the [`Dockerfile`](Dockerfile).

## Usage

#### Setup
1. [Install](https://www.docker.com/get-started/) Docker and launch it on your local machine.

2. Clone this Github repository to your local machine.

#### Running the analysis
1. Ensure your local machine's current working directory is located at the root of this project repository. Run the following in the terminal to remove all files generated by previous runs of the analysis and reset the project to a clean state:

```
docker compose run --rm analysis-env make clean
```

2. To run the entire analysis, ensure your working directory is at the project root and enter the following in the terminal:

```
docker compose run --rm analysis-env make all
```

#### Working with the project in the container using JupyterLab, the terminal, or VSCode
1. To work with the project in JupyterLab, navigate to the root of this project using the terminal and enter the following:

```
docker compose up
```
Afterwards, look in the terminal for a URL that starts with `http://127.0.0.1:8888/lab?token=`. Copy and paste that URL to your browser, and the JupyterLab IDE will load.

**NOTE**: DO NOT close the terminal while in use, otherwise you will lose your current session.

To clean up, first type `Ctrl` + `c` in the terminal. Afterwards, enter `docker compose rm` in the terminal to remove the container.

**NOTE**: If you closed the terminal by accident, you can also stop and remove the container by going to Docker Desktop and deleting the container of use under the "Containers" tab on the top left.

2. To work with the project using just the terminal, simply navigate to the root of this project and enter the following:

```
docker compose run --rm analysis-env bash
```
To check if the directory/pathways are correct, you can enter `ls` to see the list of files in the current directory. To exit the container and clean up, enter `exit` in the terminal.

3. To work in VSCode, open VSCode and launch a terminal from there. Navigate to the root of this project in the terminal, then enter the same input as above:

```
docker compose run --rm analysis-env bash
```
To exit the container and clean up, enter `exit` in the terminal.


## License 

The tornado fatalities predictor report is under the Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) License. See the license file for more information. The software code contained within this repository is licensed under the MIT license. See the license file for more information. 

## References 

Angerer, P., Kluyver, T., Schulz, J., abielr, Sa, D. F. de, Hester, J., karldw, Foster, D., & Sievert, C. (2023, January 26). *repr (1.1.6): Serializable Representations*. https://cran.r-project.org/package=repr

Chinchar, A. (2022, November 28). *Here’s Why the US has More Tornadoes than Any Other Country. CNN*. https://www.cnn.com/2022/11/28/weather/us-leads-tornado-numbers-tornado-alley-xpn/index.html

Hadley Wickham, & RStudio. (2017). *tidyverse (2.0.0): Easily Install and Load the “Tidyverse.”* https://cran.r-project.org/package=tidyverse

Kuhn , M., Wickham, H., Software, P., & PBC. (2023, August 24). *tidymodels (1.1.0): Easily Install and Load the “Tidymodels” Packages*. https://cran.r-project.org/package=tidymodels

R Core Team. (2022). *R (4.3.2): A Language and Environment for Statistical Computing*. R Foundation for Statistical Computing. https://www.r-project.org/

Revelle, W. (2019). *psych (2.3.3): Procedures for Psychological, Psychometric, and Personality Research*. https://cran.r-project.org/package=psych

Schloerke, B., Cook, D., Larmarange, J., Briatte, F., Marbach, M., Thoen, E., Elberg, A., Toomet, O., Crowley, J., Hofmann, H., & Wickham, H. (2020, June 6). *GGally (2.1.2): Extension to “ggplot2.”* https://cran.r-project.org/package=GGally

Storm Prediction Center. (2023, February 19). *F5 and EF5 tornadoes of the United States - 1950-present (SPC)*. Noaa.gov; NOAA’s National Weather Service. https://www.spc.noaa.gov/faq/tornado/f5torns.html 

*tidytuesday/data/2023/2023-05-16 at master · rfordatascience/tidytuesday*. (n.d.). GitHub. https://github.com/rfordatascience/tidytuesday/tree/master/data/2023/2023-05-16
