
###### This is a customized function for bias correction


closeAllConnections()
rm(list=ls())
options(error=recover)
##### PATHS for data
library(pracma)
library(stringr)
library(ncdf4)
library(transformeR)
library(downscaleR)

meth=c("eqm")
windw=c(30,15)
locs=100

vname=c('tmax','pr','tas','tmin')

svn=size(vname)
for (iv in 1:svn[2]){
  varnames<-vname[iv]





  control<-c(paste0(varnames,'_1971_2000'))

  projections<-c(paste0(varnames,'_rcp45_2031_2060'),
                  paste0(varnames,'_rcp45_2071_2100'),
                  paste0(varnames,'_rcp85_2031_2060'),
                  paste0(varnames,'_rcp85_2071_2100'))

init_path<-'/hdterra/OutPut/PTHRES/ncdf_for_bias_correction/'

path0=paste0(init_path,'bias_corrected/')
path_1<-paste0(init_path,'eobs/')
path_2<-paste0(init_path,'models/')


eobsfiles<-paste0(path_1, list.files(path=path_1, pattern = varnames))
#file.ls <-list.files(path=path_2,pattern=control[1])
numfiles_1<-list.files(path = path_2, pattern = control)
numfiles_2<-list.files(path=path_2,pattern=projections[1])
numfiles_3<-list.files(path=path_2,pattern=projections[2])
numfiles_4<-list.files(path=path_2,pattern=projections[3])
numfiles_5<-list.files(path=path_2,pattern=projections[4])


varN=varnames


sm<-length(numfiles_1)

BC=NULL
BC1=NULL
BC2=NULL
BC3=NULL
BC4=NULL

eobsm<-nc_open(eobsfiles)

	lat <- ncvar_get( eobsm, varid='latitude')
  	lon <- ncvar_get( eobsm, varid='longitude')


    if (isTRUE(strcmp(varN,'tmax'))){
	         var<-ncvar_get(eobsm,varid = 'daily_tmax')
    }else if (isTRUE(strcmp(varN,'tmin'))) {
	    	var<-ncvar_get(eobsm,varid = 'daily_tmin')
    } else if (isTRUE(strcmp(varN,'tas'))) {
	var<-ncvar_get(eobsm,varid = 'daily_tmean')
    } else {
	    
	var<-ncvar_get(eobsm,varid = 'daily_pr')
    }




foreach (ifiles = 1:sm[1]) %dopar% {
  
############   CONTROL ######################  

  fileM1=paste0(path_2, numfiles_1[ifiles])
  
  
  modelp1<-nc_open(fileM1)
  
  #lat <- ncvar_get( modelp1, varid='latitude')
  #lon <- ncvar_get( modelp1, varid='longitude')
  dates<-ncvar_get(modelp1,varid = 'dates')
  
  if (isTRUE(strcmp(varN,'tmax'))){
    varm<-ncvar_get(modelp1,varid = 'daily_tmax')
  }else if (isTRUE(strcmp(varN,'tmin'))) {
    varm<-ncvar_get(modelp1,varid = 'daily_tmin')
  }else if (isTRUE(strcmp(varN,'tas'))) {
    varm<-ncvar_get(modelp1,varid = 'daily_tmean')
  }else {
    varm<-ncvar_get(modelp1,varid = 'daily_pr')
  }
  
  
  
  
  
  ######################## RCP 45 2031-2060


    fileM2=paste0(path_2, numfiles_2[ifiles])


    modelf1<-nc_open(fileM2)
    
    datesf1<-ncvar_get(modelf1,varid = 'dates')
    
    if (isTRUE(strcmp(varN,'tmax'))){
      varm1<-ncvar_get(modelf1,varid = 'daily_tmax')
    }else if (isTRUE(strcmp(varN,'tmin'))) {
      varm1<-ncvar_get(modelf1,varid = 'daily_tmin')
    }else if (isTRUE(strcmp(varN,'tas'))) {
      varm1<-ncvar_get(modelf1,varid = 'daily_tmean')
    }else { 
      varm1<-ncvar_get(modelf1,varid = 'daily_pr')
    }

  
  
  
 ############################# RCP 45 2071_2100  

    fileM3=paste0(path_2, numfiles_3[ifiles])
    
    
    modelf2<-nc_open(fileM3)
    
    datesf2<-ncvar_get(modelf2,varid = 'dates')
    
    if (isTRUE(strcmp(varN,'tmax'))){
      varm2<-ncvar_get(modelf2,varid = 'daily_tmax')
    }else if (isTRUE(strcmp(varN,'tmin'))) {
      varm2<-ncvar_get(modelf2,varid = 'daily_tmin')
    }else if (isTRUE(strcmp(varN,'tas'))) {
      varm2<-ncvar_get(modelf2,varid = 'daily_tmean')
    }else {
      varm2<-ncvar_get(modelf2,varid = 'daily_pr')
    }
    
  
    ############################### RCP85 2031-2060
    
    fileM4=paste0(path_2, numfiles_4[ifiles])
    
    
    modelf3<-nc_open(fileM4)
    
    # datesf2<-ncvar_get(modelf2,varid = 'dates')
    
    if (isTRUE(strcmp(varN,'tmax'))){
      varm3<-ncvar_get(modelf3,varid = 'daily_tmax')
    }else if (isTRUE(strcmp(varN,'tmin'))) {
      varm3<-ncvar_get(modelf3,varid = 'daily_tmin')
    }else if (isTRUE(strcmp(varN,'tas'))) {
      varm3<-ncvar_get(modelf3,varid = 'daily_tmean')
    }else {
      varm3<-ncvar_get(modelf3,varid = 'daily_pr')
    }
    
  
    ################### RCP85 2071-2100
    
    
    fileM5=paste0(path_2, numfiles_5[ifiles])
    
    
    modelf4<-nc_open(fileM5)
    
    # datesf2<-ncvar_get(modelf2,varid = 'dates')
    
    if (isTRUE(strcmp(varN,'tmax'))){
      varm4<-ncvar_get(modelf4,varid = 'daily_tmax')
    }else if (isTRUE(strcmp(varN,'tmin'))) {
      varm4<-ncvar_get(modelf4,varid = 'daily_tmin')
    }else if (isTRUE(strcmp(varN,'tas'))) {
      varm4<-ncvar_get(modelf4,varid = 'daily_tmean')
    }else {
      varm4<-ncvar_get(modelf4,varid = 'daily_pr')
      
    }
  
 
  
  A <- (VALUE_Iberia_pr)
  
  strtL<-seq(0,length(lon),locs)
  endL<-seq(1,length(lon),locs)
  
  clon<-size(strtL)
 
  
  
  
 for (icount in  2:clon[2]) {
  ml<-endL[icount-1]:strtL[icount]

lonc<-lon[ml] 
latc<-lat[ml]

 lon_lats=data.frame(x=lonc,y=latc)
  
  newdates<-as.character(as.POSIXct((dates - 719529)*86400, origin = "1970-01-01", tz = "UTC"))
  
  add_date<-as.Date("2001-01-01",tz='UTC')
  
  newdates2<-c(newdates,as.character(add_date))
  
  
  s<- length(newdates2)
  
  strdate<-newdates2[1:s[1]-1]
  
  enddate<-newdates2[2:s[1]]
  
  
  varmm<-varm[ml,]
  model1<-A
  
  
  matp1 <- matrix(NA, nrow = s[1]-1, ncol = length(lonc))
  matp1<-t(varmm) ##### transpose
  attr(matp1, "dimensions") <- c("time" ,"loc")
  
  model1$Dates$start <-strdate
  model1$Dates$end <-enddate
  model1$Data <-matp1
  model1$Variable$varName<-A$Variable$varName
  model1[["xyCoords"]]<-lon_lats
  


  
  
  varf1<-varm1[ml,]
  modelf1<-A 	
  
    matf1 <- matrix(NA, nrow = s[1]-1, ncol = length(lonc))
    matf1<-t(varf1) ##### transpose
    attr(matf1, "dimensions") <- c("time" ,"loc")

      modelf1$Dates$start <-strdate
      modelf1$Dates$end <-enddate
      modelf1$Data <-matf1
      modelf1$Variable$varName<-A$Variable$varName
      modelf1[["xyCoords"]]<-lon_lats

############################# RCP 45 2071_2100  


    	
    varf2<-varm2[ml,]
    varf2<-cbind(varf2, varf2[ ,size(varf2,2)])

    modelf2<-A

      matf2 <- matrix(NA, nrow = s[1]-1, ncol = length(lonc))
      matf2<-t(varf2) ##### transpose
      attr(matf2, "dimensions") <- c("time" ,"loc")

            modelf2$Dates$start <-strdate
            modelf2$Dates$end <-enddate
	    modelf2$Data <-matf2
	    modelf2$Variable$varName<-A$Variable$varName
	    modelf2[["xyCoords"]]<-lon_lats




############################### RCP85 2031-2060





    varf3<-varm3[ml,]
        modelf3<-A

          matf3 <- matrix(NA, nrow = s[1]-1, ncol = length(lonc))
          matf3<-t(varf3) ##### transpose
	        attr(matf3, "dimensions") <- c("time" ,"loc")

	              modelf3$Dates$start <-strdate
	              modelf3$Dates$end <-enddate
		      modelf3$Data <-matf3
		      modelf3$Variable$varName<-A$Variable$varName
		      modelf3[["xyCoords"]]<-lon_lats


################### RCP85 2071-2100






    varf4<-varm4[ml,]
    varf4<-cbind(varf4,varf4[ ,size(varf4,2)])
            modelf4<-A

              matf4 <- matrix(NA, nrow = s[1]-1, ncol = length(lonc))
              matf4<-t(varf4) ##### transpose
	      attr(matf4, "dimensions") <- c("time" ,"loc")

	      modelf4$Dates$start <-strdate
	      modelf4$Dates$end <-enddate
	      modelf4$Data <-matf4
	      modelf4$Variable$varName<-A$Variable$varNanme
	      modelf4[["xyCoords"]]<-lon_lats





# ####################  e-obs ##############################  

  vare<-var[ml,]
 
     eobsdata<-A
     
     
     mat <- matrix(NA, nrow = s[1]-1, ncol = length(lonc))
     mat<-t(vare) ##### transpose
     attr(mat, "dimensions") <- c("time" ,"loc")
     eobsdata$Dates$start <-strdate
     eobsdata$Dates$end <-enddate
     eobsdata$Data <-mat
     eobsdata$Variable$varName<-A$Variable$varName
     eobsdata[["xyCoords"]]<-lon_lats
    


  

    ######################## first we correct the control period

    if (isTRUE(strcmp(varN,'pr'))){
      bc1<-biasCorrection(eobsdata, model1, precipitation = TRUE, method=c("eqm"),wet.threshold = 0.1,window = c(30, 15),parallel = FALSE, max.ncores = 4, ncores = NULL)
     
      bcf1<-biasCorrection(eobsdata, model1,modelf1, precipitation = TRUE, method=c("eqm"), wet.threshold = 0.1, window = c(30,15), parallel = FALSE, max.ncores = 4, ncores = NULL)


      bcf2<-biasCorrection(eobsdata, model1,modelf2, precipitation =TRUE, method=c("eqm"),wet.threshold = 0.1, window = c(30,15), parallel = FALSE, max.ncores = 4, ncores = NULL)

      bcf3<-biasCorrection(eobsdata, model1,modelf3, precipitation = FALSE, method=c("eqm"),wet.threshold = 0.1,window = c(30,15), parallel = FALSE, max.ncores = 4, ncores = NULL)

      bcf4<-biasCorrection(eobsdata, model1,modelf4, precipitation = FALSE, method=c("eqm"),wet.threshold = 0.1, window = c(30,15), parallel = FALSE, max.ncores = 4, ncores = NULL)

    
    
    
    
    }else{
      
      bc1<-biasCorrection(eobsdata, model1, precipitation = FALSE, method=c("eqm"),window = c(30,15), parallel = FALSE, max.ncores = 4, ncores = NULL)
      
      bcf1<-biasCorrection(eobsdata, model1,modelf1, precipitation = FALSE, method=c("eqm"),window = c(30,15), parallel = FALSE, max.ncores = 4, ncores = NULL)
      
      
      bcf2<-biasCorrection(eobsdata, model1,modelf2, precipitation = FALSE, method=c("eqm"),window = c(30,15), parallel = FALSE, max.ncores = 4, ncores = NULL)
      
      bcf3<-biasCorrection(eobsdata, model1,modelf3, precipitation = FALSE, method=c("eqm"),window = c(30,15), parallel = FALSE, max.ncores = 4, ncores = NULL)
      
      bcf4<-biasCorrection(eobsdata, model1,modelf4, precipitation = FALSE, method=c("eqm"),window = c(30,15), parallel = FALSE, max.ncores = 4, ncores = NULL)
      
    }
    
    print(ml)	    
    
    
    BC=cbind(BC, bc1$Data)
    
    print(size(BC))
    
    BC1=cbind(BC1,bcf1$Data)
    
    print(size(BC1))
    
    BC2=cbind(BC2,bcf2$Data[1:10957,])
    
    print(size(BC2))
    
    
    BC3=cbind(BC3,bcf3$Data)
    
    print(size(BC3))
    
    BC4=cbind(BC4,bcf4$Data[1:10957,])
    
    print(size(BC4))
    } 
      # 
#     # ############## SAVE BC NCDF ###################################
#     #
#     #

 
  I <- ncdim_def(name='I', units='', longname='', vals=1:length(lon))
  dimTime <- ncdim_def(name='days', units='days starting in 1971-01-01 in matlab datenumber format', longname='', vals=dates)
  dimTimef1<-ncdim_def(name='days', units='days starting in 2031-01-01 in matlan datenumber format',longname='', vals=datesf1)
  dimTimef2<-ncdim_def(name='days', units='days starting in 2071-01-01 in matlan datenumber format',longname='', vals=datesf2)
  
 
  varLat <- ncvar_def(name='latitude', units='degrees North', list(I),  longname='latitude', prec='double')
  varLon <- ncvar_def(name='longitude', units='degrees East', list(I), longname='longitude', prec='double')
  
  if (isTRUE(strcmp(varN,'tmax'))){
    
    varz <-ncvar_def(name='daily_tmax_eqm', units='degrees C', list(dimTime,I), longname='daily_tmax eqm method',prec='double')
    varzf1<-ncvar_def(name='daily_tmax_eqm', units='degrees C', list(dimTimef1,I), longname='daily_tmax eqm method',prec='double')
    varzf2<-ncvar_def(name='daily_tmax_eqm', units='degrees C', list(dimTimef2,I), longname='daily_tmax eqm method',prec='double')
    varzf3<-ncvar_def(name='daily_tmax_eqm', units='degrees C', list(dimTimef1,I), longname='daily_tmax eqm method',prec='double')
    varzf4<-ncvar_def(name='daily_tmax_eqm', units='degrees C', list(dimTimef2,I), longname='daily_tmax eqm method',prec='double')
    
    
  }else if (isTRUE(strcmp(varN,'tmin'))) {
    varz <-ncvar_def(name='daily_tmin_eqm', units='degrees C', list(dimTime,I), longname='daily_tmin eqm method',prec='double')
    varzf1<-ncvar_def(name='daily_tmin_eqm', units='degrees C', list(dimTimef1,I), longname='daily_tmin eqm method',prec='double')
    varzf2<-ncvar_def(name='daily_tmin_eqm', units='degrees C', list(dimTimef2,I), longname='daily_tmin eqm method',prec='double')
    varzf3<-ncvar_def(name='daily_tmin_eqm', units='degrees C', list(dimTimef1,I), longname='daily_tmin eqm method',prec='double')
    varzf4<-ncvar_def(name='daily_tmin_eqm', units='degrees C', list(dimTimef2,I), longname='daily_tmin eqm method',prec='double')
    
  }else if (isTRUE(strcmp(varN,'tas'))) {
    varz <-ncvar_def(name='daily_tas_eqm', units='degrees C', list(dimTime,I), longname='daily_tas eqm method',prec='double')
    varzf1<-ncvar_def(name='daily_tas_eqm', units='degrees C', list(dimTimef1,I), longname='daily_tas eqm method',prec='double')
    varzf2<-ncvar_def(name='daily_tas_eqm', units='degrees C', list(dimTimef2,I), longname='daily_tas eqm method',prec='double')
    varzf3<-ncvar_def(name='daily_tas_eqm', units='degrees C', list(dimTimef1,I), longname='daily_tas eqm method',prec='double')
    varzf4<-ncvar_def(name='daily_tas_eqm', units='degrees C', list(dimTimef2,I), longname='daily_tas eqm method',prec='double')
    
    
  }else {
    varz <- ncvar_def(name='daily_pr_eqm', units='mm/day', list(dimTime,I), longname='daily_pr eqm method',prec='double')
    varzf1<-ncvar_def(name='daily_pr_eqm', units='mm/day', list(dimTimef1,I), longname='daily_pr eqm method',prec='double')
    varzf2<-ncvar_def(name='daily_pr_eqm', units='mm/day', list(dimTimef2,I), longname='daily_pr eqm method',prec='double')
    varzf3<-ncvar_def(name='daily_pr_eqm', units='mm/day', list(dimTimef1,I), longname='daily_pr eqm method',prec='double')
    varzf4<-ncvar_def(name='daily_pr_eqm', units='mm/day', list(dimTimef2,I), longname='daily_pr eqm method',prec='double')

  
  
  
  
  
  
  
  
  
  
  }
  
  
  
  
  filenm=numfiles_1[ifiles]
  
  filename<-paste0(path0,'BC_',filenm)
  ncnew <- nc_create(filename,list(varLon,varLat,varz))
  
  ncvar_put(ncnew, varLon, lon)
  ncvar_put(ncnew, varLat, lat)
  ncvar_put( ncnew, varz, BC )
  
  
  ncatt_put( ncnew, 0, "Title","This is a postprocessed file by the National Observatory of Athens for the ICT platform / Med-GOLD project")
  nc_close(ncnew)
  
  filenmf1=numfiles_2[ifiles]
  
  filef1<-paste0(path0,'BC_',filenmf1)
  ncnew <- nc_create(filef1,list(varLon,varLat,varzf1))
  
  ncvar_put(ncnew, varLon, lon)
  ncvar_put(ncnew, varLat, lat)
  ncvar_put( ncnew, varzf1, BC1 )
  
  
  ncatt_put( ncnew, 0, "Title","This is a postprocessed file by the National Observatory of Athens for the ICT platform / Med-GOLD project")
  nc_close(ncnew)
  
  
  
  
  filenmf2=numfiles_3[ifiles]
  
  filef2<-paste0(path0,'BC_',filenmf2)
  ncnew <- nc_create(filef2,list(varLon,varLat,varzf2))
  
  ncvar_put(ncnew, varLon, lon)
  ncvar_put(ncnew, varLat, lat)
  ncvar_put( ncnew, varzf2, BC2 )
  ncatt_put( ncnew, 0, "Title","This is a postprocessed file by the National Observatory of Athens for the ICT platform / Med-GOLD project")
  nc_close(ncnew)
  
  
  
  
  
  
  filenmf3=numfiles_4[ifiles]
  
  filef3<-paste0(path0,'BC_',filenmf3)
  ncnew <- nc_create(filef3,list(varLon,varLat,varzf3))
  
  ncvar_put(ncnew, varLon, lon)
  ncvar_put(ncnew, varLat, lat)
  ncvar_put( ncnew, varzf3, BC3 )
  ncatt_put( ncnew, 0, "Title", "This is a postprocessed file by the National Observatory of Athens for the ICT platform / Med-GOLD project")
  nc_close(ncnew)
  
  
  
  
  
  filenmf4=numfiles_5[ifiles]
  
  filef4<-paste0(path0,'BC_',filenmf4)
  ncnew <- nc_create(filef4,list(varLon,varLat,varzf4))
  
  ncvar_put(ncnew, varLon, lon)
  ncvar_put(ncnew, varLat, lat)
  ncvar_put( ncnew, varzf4, BC4 )
  ncatt_put( ncnew, 0, "Title", "This is a postprocessed file by the National Observatory of Athens for the ICT platform / Med-GOLD project")
  nc_close(ncnew)
  
  
	}

}


