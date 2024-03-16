# Tornado Fatalities Predictor pipeline 

# Example usage: 
# make all

# create whole analysis and report 
all: report/tornado_fatalities_predictor.html report/tornado_fatalities_predictor.pdf

# data 
data: data/raw/raw_tornado_data.csv \
	data/processed/01_processed_tornado_data.csv data/processed/02_tornado_train_data.csv data/processed/03_tornado_test_data.csv data/processed/04_tornado_outlierless.csv data/processed/05_tornado_train_outlierless.csv data/processed/06_tornado_test_outlierless.csv

# download data
data/raw/raw_tornado_data.csv: src/01_download_data.R
	Rscript src/01_download_data.R \
	--url=https://raw.githubusercontent.com/rfordatascience/tidytuesday/a9e277dd77331e9091e151bb5adb584742064b3e/data/2023/2023-05-16/tornados.csv \
	--file_path=data/raw/raw_tornado_data.csv

# pre-process data (e.g., scale and split into train & test)
data/processed/01_processed_tornado_data.csv data/processed/02_tornado_train_data.csv data/processed/03_tornado_test_data.csv data/processed/04_tornado_outlierless.csv data/processed/05_tornado_train_outlierless.csv data/processed/06_tornado_test_outlierless.csv: src/02_clean_preprocess_data.R data/raw/raw_tornado_data.csv
	Rscript src/02_clean_preprocess_data.R \
	--raw_data=data/raw/raw_tornado_data.csv \
	--data_to=data/processed/

# results 
results: results/eda_01_numeric_features_summary_table.csv results/eda_02_correlation_plot.png results/eda_03_width_vs_fatalities_scatterplot.png results/eda_04_length_vs_fatalities_scatterplot.png \
	results/01_linear_model.rds results/02_linear_model_outlierless.rds \
	results/03_linear_model_test_scores_table.csv results/04_actual_vs_predicted_fatalities_plot.png results/05_fatalities_vs_width_plot.png results/06_fatalities_vs_length_plot.png results/07_width_outlier_boxplot.png results/08_length_outlier_boxplot.png results/09_fatalities_outlier_boxplot.png results/10_linear_model_test_scores_without_outliers_table.csv results/11_actual_vs_predicted_fatalities_plot_no_outliers.png results/12_fatalities_vs_width_plot_no_outliers.png results/13_fatalities_vs_length_plot_no_outliers.png

# exploratory data analysis - visualizations and tables
results/eda_01_numeric_features_summary_table.csv results/eda_02_correlation_plot.png results/eda_03_width_vs_fatalities_scatterplot.png results/eda_04_length_vs_fatalities_scatterplot.png: src/03_eda.R data/processed/02_tornado_train_data.csv
	Rscript src/03_eda.R \
	--file_path=data/processed/02_tornado_train_data.csv \
	--output_path=results/

# create linear model
results/01_linear_model.rds results/02_linear_model_outlierless.rds: src/04_linear_model.R data/processed/02_tornado_train_data.csv data/processed/05_tornado_train_outlierless.csv
	Rscript src/04_linear_model.R \
	--train_path=data/processed/02_tornado_train_data.csv \
	--outlierless_train=data/processed/05_tornado_train_outlierless.csv \
	--output_path=results/

# test model on unseen data and create visualizations and tables 
results/03_linear_model_test_scores_table.csv results/04_actual_vs_predicted_fatalities_plot.png results/05_fatalities_vs_width_plot.png results/06_fatalities_vs_length_plot.png results/07_width_outlier_boxplot.png results/08_length_outlier_boxplot.png results/09_fatalities_outlier_boxplot.png results/10_linear_model_test_scores_without_outliers_table.csv results/11_actual_vs_predicted_fatalities_plot_no_outliers.png results/12_fatalities_vs_width_plot_no_outliers.png results/13_fatalities_vs_length_plot_no_outliers.png: src/05_linear_model_results.R data/processed/03_tornado_test_data.csv data/processed/06_tornado_test_outlierless.csv results/01_linear_model.rds results/02_linear_model_outlierless.rds
	Rscript src/05_linear_model_results.R \
	--test_data=data/processed/03_tornado_test_data.csv \
	--outlierless_test=data/processed/06_tornado_test_outlierless.csv \
	--lin_fit=results/01_linear_model.rds \
	--lin_fit_outlierless=results/02_linear_model_outlierless.rds \
	--output_path=results/
	
# render report
report: report/tornado_fatalities_predictor.html \
	report/tornado_fatalities_predictor.pdf 

report/tornado_fatalities_predictor.html: report/tornado_fatalities_predictor.qmd \
	report/references.bib \
	results/eda_01_numeric_features_summary_table.csv results/eda_02_correlation_plot.png results/eda_03_width_vs_fatalities_scatterplot.png results/eda_04_length_vs_fatalities_scatterplot.png \
	results/01_linear_model.rds results/02_linear_model_outlierless.rds \
	results/03_linear_model_test_scores_table.csv results/04_actual_vs_predicted_fatalities_plot.png results/05_fatalities_vs_width_plot.png results/06_fatalities_vs_length_plot.png results/07_width_outlier_boxplot.png results/08_length_outlier_boxplot.png results/09_fatalities_outlier_boxplot.png results/10_linear_model_test_scores_without_outliers_table.csv results/11_actual_vs_predicted_fatalities_plot_no_outliers.png results/12_fatalities_vs_width_plot_no_outliers.png results/13_fatalities_vs_length_plot_no_outliers.png
		quarto render report/tornado_fatalities_predictor.qmd --to html

report/tornado_fatalities_predictor.pdf: report/tornado_fatalities_predictor.qmd \
	report/references.bib \
	results/eda_01_numeric_features_summary_table.csv results/eda_02_correlation_plot.png results/eda_03_width_vs_fatalities_scatterplot.png results/eda_04_length_vs_fatalities_scatterplot.png \
	results/01_linear_model.rds results/02_linear_model_outlierless.rds \
	results/03_linear_model_test_scores_table.csv results/04_actual_vs_predicted_fatalities_plot.png results/05_fatalities_vs_width_plot.png results/06_fatalities_vs_length_plot.png results/07_width_outlier_boxplot.png results/08_length_outlier_boxplot.png results/09_fatalities_outlier_boxplot.png results/10_linear_model_test_scores_without_outliers_table.csv results/11_actual_vs_predicted_fatalities_plot_no_outliers.png results/12_fatalities_vs_width_plot_no_outliers.png results/13_fatalities_vs_length_plot_no_outliers.png
	quarto render report/tornado_fatalities_predictor.qmd --to pdf

# clean data
clean-data: 
	rm -f data/raw/raw_tornado_data.csv \
		data/processed/01_processed_tornado_data.csv data/processed/02_tornado_train_data.csv data/processed/03_tornado_test_data.csv data/processed/04_tornado_outlierless.csv data/processed/05_tornado_train_outlierless.csv data/processed/06_tornado_test_outlierless.csv

clean-results: 
	rm -f results/eda_01_numeric_features_summary_table.csv results/eda_02_correlation_plot.png results/eda_03_width_vs_fatalities_scatterplot.png results/eda_04_length_vs_fatalities_scatterplot.png \
		results/01_linear_model.rds results/02_linear_model_outlierless.rds \
		results/03_linear_model_test_scores_table.csv results/04_actual_vs_predicted_fatalities_plot.png results/05_fatalities_vs_width_plot.png results/06_fatalities_vs_length_plot.png results/07_width_outlier_boxplot.png results/08_length_outlier_boxplot.png results/09_fatalities_outlier_boxplot.png results/10_linear_model_test_scores_without_outliers_table.csv results/11_actual_vs_predicted_fatalities_plot_no_outliers.png results/12_fatalities_vs_width_plot_no_outliers.png results/13_fatalities_vs_length_plot_no_outliers.png

clean-report: 
	rm -f report/tornado_fatalities_predictor.html \
	rm -f report/tornado_fatalities_predictor.pdf

clean-all: clean-data \
	clean-results \
	clean-report