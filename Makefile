# Tornado Fatalities Predictor pipeline 

# create whole analysis and report 
all: report/tornado_fatalities_report.html

# data 
data: data/raw/raw_tornado_data.csv \
	data/processed/01_clean_tornado_data.csv data/processed/02_tornado_train_data.csv data/processed/03_tornado_test_data.csv

# download data
data/raw/raw_tornado_data.csv: src/01_read.R
	Rscript src/01_read.R \
	--out_type=csv \
	--url= https://raw.githubusercontent.com/rfordatascience/tidytuesday/a9e277dd77331e9091e151bb5adb584742064b3e/data/2023/2023-05-16/tornados.csv \
	--out_file=data/raw/raw_tornado_data

# pre-process data (e.g., scale and split into train & test)
data/processed/01_clean_tornado_data.csv data/processed/02_tornado_train_data.csv data/processed/03_tornado_test_data.csv: src/02_clean_data.R data/raw/raw_tornado_data.csv
	Rscript src/02_clean_data.R \
	--input=data/raw/raw_tornado_data.csv \
	--out_file=data/processed/01_clean_tornado_data.csv data/processed/02_tornado_train_data.csv data/processed/03_tornado_test_data.csv

# results 
results: results/eda_01_numeric_features_summary_table.csv results/eda_02_correlation_plot.png results/eda_03_width_vs_fatalities_scatterplot.png results/eda_04_length_vs_fatalities_scatterplot.png \
	results/01_training_linear_model_results_table.csv results/01_linear_model.rds \
	results/02_linear_model_test_scores_table.csv results/03_actual_vs_predicted_fatalities_plot.png results/04_fatalities_vs_width_plot.png results/05_fatalities_vs_length_plot.png results/06_boxplots_for_outliers.png results/07_linear_model_test_scores_without_outliers.csv results/08_actual_vs_predicted_fatalities_no_outliers.png results/09_fatalities_vs_width_plot_no_outliers.png results/10_fatalities_vs_length_plot_no_outliers.png

# exploratory data analysis - visualizations and tables
results/eda_01_numeric_features_summary_table.csv results/eda_02_correlation_plot.png results/eda_03_width_vs_fatalities_scatterplot.png results/eda_04_length_vs_fatalities_scatterplot.png: src/03_eda.R data/processed/02_tornado_train_data.csv
	Rscript src/03_eda.R \
	--train=data/processed/02_tornado_train_data.csv \
	--out_file=results/eda_01_numeric_features_summary_table.csv results/eda_02_correlation_plot.png results/eda_03_width_vs_fatalities_scatterplot.png results/eda_04_length_vs_fatalities_scatterplot.png

# create linear model
results/01_training_linear_model_results_table.csv results/01_linear_model.rds: src/04_linear_model_construction data/processed/02_tornado_train_data.csv
	Rscript src/04_linear_model_construction.R \
	--train=data/processed/02_tornado_train_data.csv \
	--out_file=results/01_training_linear_model_results_table.csv results/01_linear_model.rds

# test model on unseen data and create visualizations and tables 
results/02_linear_model_test_scores_table.csv results/03_actual_vs_predicted_fatalities_plot.png results/04_fatalities_vs_width_plot.png results/05_fatalities_vs_length_plot.png results/06_boxplots_for_outliers.png results/07_linear_model_test_scores_without_outliers.csv results/08_actual_vs_predicted_fatalities_no_outliers.png results/09_fatalities_vs_width_plot_no_outliers.png results/10_fatalities_vs_length_plot_no_outliers.png: src/05_linear_model_results.R data/processed/03_tornado_test_data.csv results/01_linear_model.rds
	Rscript src/05_linear_model_results.R \
	--test=data/processed/03_tornado_test_data.csv \
	--input=results/01_linear_model.rds \
	--out_file=results/02_linear_model_test_scores_table.csv results/03_actual_vs_predicted_fatalities_plot.png results/04_fatalities_vs_width_plot.png results/05_fatalities_vs_length_plot.png results/06_boxplots_for_outliers.png results/07_linear_model_test_scores_without_outliers.csv results/08_actual_vs_predicted_fatalities_no_outliers.png results/09_fatalities_vs_width_plot_no_outliers.png results/10_fatalities_vs_length_plot_no_outliers.png

# render report
doc/tornado_fatalities_report.md: doc/tornado_fatalities_report.Rmd doc/tornado_refs.bib
	Rscript -e "rmarkdown::render('doc/tornado_fatalities_report.Rmd')"

# clean data
clean-data: 
	rm -f data/raw/raw_tornado_data.csv \
		data/processed/01_clean_tornado_data.csv data/processed/02_tornado_train_data.csv data/processed/03_tornado_test_data.csv

clean-results: 
	rm -f results/eda_01_numeric_features_summary_table.csv results/eda_02_correlation_plot.png results/eda_03_width_vs_fatalities_scatterplot.png results/eda_04_length_vs_fatalities_scatterplot.png \
		results/01_training_linear_model_results_table.csv results/01_linear_model.rds \
		results/02_linear_model_test_scores_table.csv results/03_actual_vs_predicted_fatalities_plot.png results/04_fatalities_vs_width_plot.png results/05_fatalities_vs_length_plot.png results/06_boxplots_for_outliers.png results/07_linear_model_test_scores_without_outliers.csv results/08_actual_vs_predicted_fatalities_no_outliers.png results/09_fatalities_vs_width_plot_no_outliers.png results/10_fatalities_vs_length_plot_no_outliers.png

clean-doc: 
	rm -f doc/tornado_fatalities_report.md doc/tornado_fatalities_report.html

clean-all: 
	clean-data \
	clean-results \
	clean-doc