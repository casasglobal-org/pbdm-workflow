%%%%%% THIS MATLAB SCRIPT COMPUTE th bio-climatic indicators based on Precip for the MED-GOLD Olive OIL SERVICE for a gridded dataset (in %%%%%% this case ERA5) , starting from the monthly precipipation values present in the MED-GOLD ICT Platform


clear all 
close all

%%% DEFINE PATH FROM YOUR OS
 %%%
puppo=computer;
if strncmp(puppo,'PCWIN',5)
% % %   pth0= '/b_3/alex/'
    pth0='Y:/';
else
    pth0= '/home/alex/';
end


path2out=strcat([pth0 'INDEXES/MAT/']);



simulatio_glo1='ERA5';

%%%% DEFIN ECV for the bio-climatic indicator
cosa_ind='rr' ;
unit_ind='mm'

%%%% PERIOD
yr_1=1979;
yr_end=2020;


%%%%%% FOCUS OVER A SPECIFIC BOX (in this case Iberian Peninsula, data already present and formatted in the MED-GOLD ICT Platform)
NOME_BOX='IBERIAN';%% LEV [ 20 40 30 40] TUNISIA LARGE [8 16 30 38]; 'NORTH ADRIATIC' [12 19 42 46]; MED [-10 40 30 48];
%%%% AEGEAN [22 29 34 41]; MOROCCO [ -6 0 35 37] %%WEST MED [0 15 30 45] %%
%%%% TYR 11 16 39 42.5 %%% DOURO 6.5W 7.5W 40.5 41.5  ANDALUSIA Lon: 7 W -
%%%% 2.W Lat: 36.5-38 IBERIAN -10 4 35 45



% % %   Suffix='_V1' ; %% '_V1' []
   Suffix=[] ;

indicator='WINRR';
%%% Staring month for the integration
sm=10;
%%% lenght fo the period
lenm=8;



yrs=yr_1:yr_end;
len_yrs=length(yrs);
len_yr=len_yrs;
 months=1:12;
len_mon=length(months);
mon_char={'01';'02';'03';'04';'05';'06';'07';'08';'09';'10';'11';'12'};


%%%READ THE FIRST FILE FOR DIMENSIONS
filenamenc=strcat([path2out  simulatio_glo1 '_' NOME_BOX '_' cosa_ind '_' int2str(yr_1)  '_' mon_char{1} '.nc' ]);


lat2_box=double(ncread(filenamenc,'lat'));
lon2_box=double(ncread(filenamenc,'lon'));



xlon2_box=length(lon2_box);
xlat2_box=length(lat2_box);




veclon=lon2_box;
veclat=lat2_box;
 

%%%%%%%%% WHICH PERIOD WE TAKE INTO ACCOUNT

yr_1_sub=yr_1; %%% yr_1 first year
yr_end_sub=yr_end; %%% yr_end last year
yr_sub=yr_1_sub:yr_end_sub;
len_yrs_sub=length(yr_sub);
years_sub=ismember(yrs,yr_sub);





        dummy_glo=zeros(xlon2_box,xlat2_box, len_mon*len_yrs_sub);
        
for annis5b=1:len_yr
  
YR_tbd1b=yrs(annis5b)
 year_hit1b=find(yrs==YR_tbd1b)  
 for mm=1:len_mon
filenamenc_obs=strcat([path2out  simulatio_glo1 '_' NOME_BOX '_' cosa_ind '_' int2str(YR_tbd1b) '_' mon_char{mm}  '.nc' ]);
pippo=double(ncread(filenamenc_obs,cosa_ind ,[1 1 ], [Inf Inf]));
dummy_glo(:,:,(annis5b-1)*len_mon+mm)=pippo;
 end

end


%%% CALCULATION of the cumulated value %%%%%%%%
%%%%%%%%%%%%% 
dummy_ind=zeros(xlon2_box,xlat2_box,len_yrs_sub-1);

for annis5b=1:len_yrs_sub-1

dummy_ind(:,:,annis5b)=sum(dummy_glo(:,:,(annis5b-1)*len_mon+sm: (annis5b-1)*len_mon+sm+lenm-1),3) ;
 end





%%%%% WRITE A NETCDF FILE PER YEARS(WITHOUT PERCENTILES)

for tt=1:len_yrs_sub-1
    
    year2=yr_1+tt-1

nomefile_index1=strcat([path2out simulatio_glo1  '_' NOME_BOX  '_' indicator '_' int2str( year2) '.nc'])

 index11=squeeze(dummy_ind(:,:,tt));

ncid = netcdf.create(nomefile_index1,'NC_WRITE');
dimidlon = netcdf.defDim(ncid,'lon',xlon2_box);
dimidlat = netcdf.defDim(ncid,'lat',xlat2_box);
varid = netcdf.defVar(ncid,indicator,'NC_DOUBLE',[dimidlon dimidlat]);
varid3 = netcdf.defVar(ncid,'lon','NC_DOUBLE',dimidlon);
varid4 = netcdf.defVar(ncid,'lat','NC_DOUBLE',dimidlat);
netcdf.putAtt(ncid,varid,'units',unit_ind);
netcdf.putAtt(ncid,varid,'Long name', indicator);
netcdf.endDef(ncid);
netcdf.putVar(ncid,varid,index11);
netcdf.putVar(ncid,varid3,veclon);
netcdf.putVar(ncid,varid4,veclat);

netcdf.close(ncid);


end




