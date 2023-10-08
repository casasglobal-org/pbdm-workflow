%%%%%% THIS MATLAB SCRIPT COMPUTE th bio-climatic indicators based on Temp Max for the MED-GOLD OLIVE OIL SERVICE for a gridded dataset (in %%%%%% this case ERA5) , the METEOLAB package from Santander University is required http://www.meteo.unican.es/en/software/meteolab


clear all 
close all

%%% DEFINE PATH FROM YOUR OS
puppo=computer;
if strncmp(puppo,'PCWIN',5)
% % %   pth0= '/b_3/alex/'
    pth0='Y:/';
else
    pth0= '/home/alex/';
end


path2out=strcat([pth0 'INDEXES/']);



%%%% DEFIN ECV for the bio-climatic indicator

name='tx'
unit_ind='K';
tipo_aggre='Daily' % 'Daily', 'ANNUAL' 'MONTHLY'
var_obs=name;
len=12;

cosa_tbd='ECV'; %ECV OR INDEX
% % % name='precp'

tipo_aggre_in='daily' % 'Daily', 'ANNUAL' 'MONTHLY'
tipo_aggre_out='MONTHLY' % 'Daily', 'ANNUAL' 'MONTHLY'



 %%%% INDICATOR BASED on T MAX: 
 %%%% SprTx:  Mean maximum temperature over spring (1 Apr-31 May)

 
 %%% index_show='sprtx';
 index_show='sprtx';
version='V3';

starting_date='1-Apr';
ending_date='31-May';

 
 
%%%%LOADING GRIDDED DATASET (ERA5) downloaded by CDS in hourly data (download_cds_era5_an.py)  and afterwards converted in daily values over the Euro-Med Domain (Manipulate_era5_2020.sh)
simulatio_glo1='ERA5';
DOMAIN='EU-'
var_glo='t2m'; % t2m tp
tipoSRF='daymax'; %% [];  dayavg daymin daymax daysum

var_glo_nome=strcat([ var_glo '-' tipoSRF]) ; % precip t2m tmax

res='028';


%YEAR OF INTEREST
year12=1979; 
%%len2=[  365 365 365 365 365 365 365 365 365 365 365 365 365 365 365 365 365 365 365 365 365 365 365 365 365 365];
annofin=2020;

if strcmp (var_glo_nome,'tp')
multi_glo1=1000; %
else
    multi_glo1=1;
end



%%%%%% FOCUS OVER A SPECIFIC BOX (in this case Iberian Peninsula)


Blonmin=-10;
Blonmax=4;

Blatmin=35;
Blatmax=45;

NOME_BOX='IBERIAN';%%;%% LEV [ 20 40 30 40] TUNISIA LARGE [8 16 30 38]; 'NORTH ADRIATIC' [12 19 42 46]; MED [-10 40 30 48];
%%%% AEGEAN [22 29 34 41]; MOROCCO [ -6 0 35 37] %%WEST MED [0 15 30 45] %%
%%%% TYR 11 16 39 42.5 %%% DOURO 6.5W 7.5W 40.5 41.5 DOURO2 6.5W 8W 40.5
%%%% 41.5  ANDALUSIA Lon: 7 W - 2.W Lat: 36.5-38  %%% IBERIAN -10 4 35 45


%%%%% OBSERVATIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%READING THE GRID FROM THE MASK FILE


filenamenc=strcat([pth0 'DATI/' simulatio_glo1 '/' DOMAIN 'mask_' res   '.nc' ]);


lat2_glo1_old=double(ncread(filenamenc,'latitude'));
lon2_glo1_old=double(ncread(filenamenc,'longitude'));




lon2_glo1=lon2_glo1_old;
lat2_glo1=lat2_glo1_old;


xlon2_glo1=length(lon2_glo1);

%%%% IF LONGITUDE IS REPORTED in 0-360 
    lond1=find(lon2_glo1>180);
    lon2_glo1(lond1)=lon2_glo1(lond1)-360;
    
xlat2_glo1=length(lat2_glo1);
xlon_glo1= xlon2_glo1;
lunlon2_glo1=xlon2_glo1;
lat_glo1=xlat2_glo1;
dlon1=lon2_glo1(2)-lon2_glo1(1);
dlat1=lat2_glo1(1)-lat2_glo1(2);

veclon0=Blonmin:dlon1:Blonmax;
veclat0=Blatmin:dlat1:Blatmax;
veclondum=find(ismember(lon2_glo1,veclon0));
veclatdum=find(ismember(lat2_glo1,veclat0));
veclat=lat2_glo1(veclatdum);
veclon=lon2_glo1(veclondum);

xlat2_box=length(veclat)
xlon2_box=length(veclon)



mask_glo1=double(ncread(filenamenc,'lsm'));

%% SEA POINTS
mare=find(mask_glo1==0);





[longrat_glo1,latgrat_glo1]=meshgrat((lon2_glo1),(lat2_glo1));
[longrat_glo1_old,latgrat_glo1_old]=meshgrat((lon2_glo1_old),(lat2_glo1_old));

if strncmp(puppo,'PCWIN',5)
figure
pcolor(longrat_glo1_old,latgrat_glo1_old,mask_glo1)
end




     dummask=zeros( size(longrat_glo1));                
    dummaskX=zeros( size(longrat_glo1));    
    dummaskY=zeros( size(longrat_glo1));
                    
                            kklon=find( longrat_glo1>=Blonmin & longrat_glo1<=Blonmax);
                        kklat=find( latgrat_glo1>=Blatmin & latgrat_glo1<=Blatmax);
    
                        dummaskX(kklon)=1;
                         dummaskY(kklat)=1;
                    dummask=dummaskX.*dummaskY;
                   dummask(mare)=NaN;
                    
                               
                                ocn = find(dummask==1);

puppob=ones(size(longrat_glo1)).*NaN;
puppob(ocn)=1;




 
  
 %% AGGREGATING TEMP OVER THE FIXED PERIOD (AM)  

anni2=year12:annofin;
DateNumberini = datenum(year12,01,01);
DateNumberfin = datenum(annofin,12,31);
real_length=DateNumberfin-DateNumberini+1;
t_dates=DateNumberini:DateNumberfin;
len_yrs=length(anni2);
years=anni2;


 index_stat=zeros(xlon2_box,xlat2_box,len_yrs);
  va_seas=zeros(xlon2_box,xlat2_box,real_length);
   va_mon=zeros(xlon2_box,xlat2_box,len_yrs*12);
  
  
  len_dum=0;
for tt=1:len_yrs
    
    
    year2=year12+tt-1
            calenda_ini0=datenum([ year2 01 01]);
           calenda_fin0= datenum([ year2 12 31]);
           real_length_yr=calenda_fin0-calenda_ini0+1;    
           t_dates0=calenda_ini0:calenda_fin0;
           
              dummy_glo=zeros(xlon2_glo1,xlat2_glo1,real_length_yr,1);
       


                questo2_glo1=(strcat( [ pth0 'DATI/' simulatio_glo1 '/' int2str(year2) '/DAILY/' simulatio_glo1 '-' DOMAIN  var_glo '.' int2str(year2) '_' tipoSRF '.nc']))


    dummy_glo(:,:,:)=squeeze(ncread(questo2_glo1,var_glo, [1 1 1], [Inf Inf real_length_yr])).*multi_glo1;

  
    
    period={strcat([starting_date '-' int2str(years(tt)) ]) ,  strcat([ ending_date '-' int2str(years(tt)) ])};
    aggdates=(datenum(period{1}):datenum(period{2}));
    season=ismember(t_dates0,aggdates);
    
      for xx=1:xlon2_box
        for yy=1:xlat2_box

index_stat(xx,yy,tt)=nanmean(dummy_glo(veclondum(xx),veclatdum(yy),season),3);
va_seas(xx,yy,len_dum+1:len_dum+real_length_yr)=(dummy_glo(veclondum(xx),veclatdum(yy),:));
pippi=aggregateData(squeeze(squeeze(dummy_glo(veclondum(xx),veclatdum(yy),:))),t_dates0,'M','aggFun','nanmean','missing',1);
     va_mon(xx,yy,(tt-1)*12+(1:12))=pippi;

        end
    end
       
    len_dum=len_dum+real_length_yr;
       
end







index=index_stat;


%%%%%%%%% WHICH PERIOD WE TAKE INTO ACCOUNT (in case a subperiod should be considered)
yr_1=year12;
yr_end=annofin;
yr_sub=yr_1:yr_end;
len_yrs_sub=length(yr_sub);

years_sub=ismember(years,yr_sub);
 index1=index(:,:,years_sub);

 




%%%%% WRITE A NETCDF FILE PER YEARS

for tt=1:len_yrs
    
    year2=year12+tt-1

nomefile_index1=strcat([path2out '/MAT/' simulatio_glo1 '_' NOME_BOX  '_' index_show '_' int2str(year2) '_' version '.nc'])
uu=dir(nomefile_index1);

% % %  index11=squeeze(index1(:,:,tt));
 index11=squeeze(index(:,:,tt));
 
ncid = netcdf.create(nomefile_index1,'NC_WRITE');
dimidlon = netcdf.defDim(ncid,'lon',xlon2_box);
dimidlat = netcdf.defDim(ncid,'lat',xlat2_box);
varid = netcdf.defVar(ncid,index_show,'NC_DOUBLE',[dimidlon dimidlat]);
varid3 = netcdf.defVar(ncid,'lon','NC_DOUBLE',dimidlon);
varid4 = netcdf.defVar(ncid,'lat','NC_DOUBLE',dimidlat);

netcdf.endDef(ncid);
netcdf.putVar(ncid,varid,index11);
netcdf.putVar(ncid,varid3,veclon);
netcdf.putVar(ncid,varid4,veclat);

netcdf.close(ncid);


end










