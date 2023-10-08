In this folder has been reported the main scripts from ENEA to compute Bioc-climatic indicators for the MED-GOLD olive oil Service and reported in the MED-GOLD Dashboard (historical climate tab) from Gridded datasets (e.g. ERA5 downloaded from CDS and then manipulated to obtain daily netcdf files).  The Scritps are written in Matlab programming language, Shell scripts and python. They also require cdo

1)The file TOOL_ERA5_AREA_YEARS_Threshold_TMAX.m computes the bio-climatic threshold indicators based on Tmax (namely Spr32, SU36 and SU40) starting from daily fields from a gridded dataset (in this case, ERA5: hourly fields downloaded with download_cds_era5_an.py and daily valued obtained by using the sh script Manipulate_era5_2020.sh )

2) The file OLIVE_TOOL_ERA5_AREA_YEARS.m computes the bio-climatic  indicators based on Tmax (namely, Sprtx) starting from daily fields from a gridded dataset (in this case, ERA5: hourly fields downloaded with download_cds_era5_an.py and daily valued obtained by using the sh script Manipulate_era5_2020.sh )

3) The file Manipulate_netcdf_dashboard_MONTHLY_CUMULATIVE_WINRR computes the WINRR indicator starting from the monthly precipipation ERA5 values present in the MED-GOLD ICT Platform (computed wiht the below script TOOL_ERA5_AREA_ECVs_MONTHLY_R2021.m)

4) The file sh Manipulate_era5_2020.sh,starting from ERA5 hourly data (see script below), computes daily values (daysum, daymin, daymax,dayavg)

5)The file download_cds_era5_an.py download netcdf hourly ERA5 data from CDS over a specific area

6)The file The file TOOL_ERA5_AREA_ECVs_MONTHLY_R2021.m computes the monthly ECVs for the Dashboard starting from daily fields from a gridded dataset (in this case, ERA5: hourly fields downloaded with download_cds_era5_an.py and daily valued obtained by using the sh script Manipulate_era5_2020.sh )