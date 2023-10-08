CSIndicators

-----

For the most updated version of the package please go to:

https://cran.r-project.org/web/packages/CSIndicators/index.html

-----

#### Sectoral Indicators for Climate Services Based on Sub-Seasonal to Decadal Climate Predictions

## Description

Set of generalised tools for the flexible computation of climate related indicators defined by the user. Each method represents a specific mathematical approach which is combined with the possibility to select an arbitrary time period to define the indicator. This enables a wide range of possibilities to tailor the most suitable indicator for each particular climate service application (agriculture, food security, energy, water management…). This package is intended for sub-seasonal, seasonal and decadal climate predictions, but its methods are also applicable to other time-scales, provided the dimensional structure of the input is maintained. Additionally, the outputs of the functions in this package are compatible with CSTools.

## Functions and documentation

To learn how to use the package see:

- [**Agricultural Indicators**](https://CRAN.R-project.org/package=CSIndicators/vignettes/AgriculturalIndicators.html)
- [**Wind Energy Indicators**](https://CRAN.R-project.org/package=CSIndicators/vignettes/EnergyIndicators.html)

Functions documentation can be found [here](https://CRAN.R-project.org/package=CSIndicators/CSIndicators.pdf)

| Function                       | CST version                        | Indicators                      |
|--------------------------------|------------------------------------|---------------------------------|
|PeriodMean                      |CST_PeriodMean                      |GST, SprTX, DTR                  |
|PeriodAccumulation              |CST_PeriodAccumulation              |SprR, HarR, PRCPTOT              | 
|AccumulationExceedingThreshold  |CST_AccumulationExceedingThreshold  |GDD, R95pTOT, R99pTOT            |
|TotalTimeExceedingThreshold     |CST_TotalTimeExceedingThreshold     |SU35, SU, FD, ID, TR, R10mm, Rnmm|
|TotalSpellTimeExceedingThreshold|CST_TotalSpellTimeExceedingThreshold|WSDI, CSDI                       |
|WindCapacityFactor              |CST_WindCapacityFactor              |Wind Capacity Factor             |
|WindPowerDensity                |CST_WindPowerDensity                |Wind Power Density               |
 
  	
| Auxiliar function | CST version          |
|-------------------|----------------------|
|AbsToProbs         |CST_AbsToProbs        |
|QThreshold         |CST_QThreshold        |
|Threshold          |CST_Threshold         |
|MergeRefToExp      |CST_MergeRefToExp     |
|SelectPeriodOnData |CST_SelectPeriodOnData|
|SelectPeriodOnDates|                      |


*Note: the CST version uses 's2dv_cube' objects as inputs and outputs while the former version uses multidimensional arrays with named dimensions as inputs and outputs*

*Note: All functions computing indicators allows to subset a time period if required, although this temporal subsetting can also be done with functions `SelectPeriodOnData` in a separated step.* 

----

For any issues please contact, 

- Raül Marcos-Matamoros (raul.marcos@bsc.es)
- Nube González-Reviriego (nube.gonzalez@bsc.es)
- Núria Pérez-Zanón (nuria.perez@bsc.es)
