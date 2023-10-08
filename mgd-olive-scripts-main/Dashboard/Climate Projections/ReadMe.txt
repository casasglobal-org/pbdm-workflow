bias_adjust_anda.R is the main script used by NOA to bias adjust the daily Regional Climate Model data for the temperature variables (daily maximum, daily minimum and daily mean) as well as daily accumulated precipitation for the Andalusia.
The script reads both the daily data for the reference observed gridded dataset (eobsv19) as well as the Regional Climate Model data for the periods examined in MED-GOLD and performs bias adjustment using the empirical quantile mapping method. Before running the script the only action needed is to make sure that the regional climate model data are on the same grid with the reference observed gridded dataset.
The script is written in R project programming language thus the user is expected to be familiar with the specific programming language. Bias adjustment is  performed using the downscaleR package (https://github.com/SantanderMetGroup/downscaleR).

contact person: Konstantninos V. Varotsos (varotsos@noa.gr)
