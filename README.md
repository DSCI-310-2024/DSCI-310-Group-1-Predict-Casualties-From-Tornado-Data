# DSCI-310-Project-Group-1

## Predicting Fatalities from Tornado Data 

- Authors: Erika Delorme, Marcela Flaherty, Riddha Tuladhar, Edwin Yeung

## About 

In our project, we attempt to build a multiple linear regression model that will predict the number of fatalities from tornadoes using the features width (yards) and length (miles) of the tornado. We tested our multilinear regression model with and without outliers and compared differences in coefficients and RMSPE scores. Both models had low positive coefficients, suggesting a minimal yet positive impact on the prediction of tornado fatalities, and both had low RMSPE scores, suggesting a low amount of error in its predictions. The model without outliers had a lower RMSPE score, which is partly explained by the lack of outliers and thus making predictions on a smaller range, which reduces the error. Despite the limitations of our model, we believe that it can still have some utility in predicting tornado fatalities with little error. However, the model should be improved in the future before being deployed to improve the size of the coefficients and its predictive power. In the future, we may consider exploring other features in predicting fatalities, predicting the number of injuries from the same features, or even predicting the number of casualties (injuries and fatalities) from the same and additional features. 

The data set that was used in this project is from the US NOAA's National Weather Service Storm Prediction Center Severe Weather Maps, Graphics, and Data Page. It was tidied and sourced from TidyTuesday and can be found [here](https://github.com/rfordatascience/tidytuesday/tree/master/data/2023/2023-05-16). Each row represents a tornado, along with various features, including width, length, date, time, state in the US, magnitude, financial losses, number of fatalities, number of injuries, etc. 

## Report 

The final report can be found [here](https://github.com/DSCI-310-2024/DSCI-310-Group-1-Predict-Fatalities-From-Tornado-Data/blob/main/src/tornado_fatalities_predictor.ipynb). 

## Usage 
Clone this Github repository to your local machine. Whenever you want to run the data analysis, ensure your machine's current working directory is at the root of this repository.

When you run the project for the **first** time, ensure your current working directory is at the root of this repository and enter the following in the terminal:
``` bash
conda env create --file environment.yml
```

Now whenever you want to run the analysis, ensure you are on this newly created environment by running:
``` bash
conda activate tornado_fatalities_predictor
```

Afterwards, open Jupyterlab by running:
```bash
jupyter lab
```

Once you are on Jupyter Lab, navigate to the `src` folder and open the `tornado_predictor.ipynb` file. 

After you open the file, click on `Change Kernel...` under the `Kernel` tab, and select `R [conda env:tornado_fatalities_predictor]`. Restart the kernel and run all cells.

## Dependencies 
- `conda` (version 24.1.2 or higher)

Remaining dependencies are listed in [`environment.yml`](environment.yml). Nonetheless, they will also be listed below:
- `r-base` (version 4.1.3)
- `jupyterlab` (version 4.1.2)
- `nb_conda_kernels` (version 2.3.1)
- `r-irkernel` (version 1.3.2)
- `r-tidyverse` (version 2.0.0)
- `r-tidymodels` (version 1.1.0)
- `r-psych` (version 2.3.3)
- `r-ggally` (version 2.1.2)

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
