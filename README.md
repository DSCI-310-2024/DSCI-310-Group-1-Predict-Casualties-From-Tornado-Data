# DSCI-310-Project-Group-1

## Predicting Fatalities from Tornado Data 

- Authors: Erika Delorme, Marcela Flaherty, Riddha Tuladhar, Edwin Yeung

## About 

In our project, we attempt to build a linear regression model that will predict the number of fatalities from tornados using the width (yards) and length (miles) of the tornado. 

The data set that was used in this project is from the US NOAA's National Weather Service Storm Prediction Center Severe Weather Maps, Graphics, and Data Page. It was tidied and sourced from TidyTuesday and can be found here: https://github.com/rfordatascience/tidytuesday/tree/master/data/2023/2023-05-16. 

Each row represents a tornado, along with various features, including width, length, date, time, state in the US, magnitude, financial losses, number of fatalities, number of injuries, etc. 

## Report 

The final report can be found here:

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

## References 

