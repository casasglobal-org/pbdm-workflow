


clear all 
close all

 %%%
puppo=computer;
if strncmp(puppo,'PCWIN',5)
% % %   pth0= '/b_3/alex/'
    pth0='Y:/';
else
    pth0= '/home/alex/';
end


path2out=strcat([pth0 'INDEXES/']);



cosa_tbd='INDEX'; %ECV OR INDEX

name='tx'
unit_ind='K';
tipo_aggre='Daily' % 'Daily', 'ANNUAL' 'MONTHLY'
var_obs=name;
len=12;

cosa_tbd='ECV'; %ECV OR INDEX
% % % name='precp'

tipo_aggre_in='daily' % 'Daily', 'ANNUAL' 'MONTHLY'
tipo_aggre_out='MONTHLY' % 'Daily', 'ANNUAL' 'MONTHLY'



% % % % name_aggre=strcat([ name '_' tipo_aggre_out]);
% % % % % % % perio='MJ'
% % % % periodo=[5 6];
% % % % months=['J'; 'F'; 'M'; 'A';'M';'J';'J'; 'A';'S';'O';'N';'D'];
% % % % if length(periodo)==12
% % % %     perio='ANN'
% % % % else
% % % % perio=months(periodo,1)';
% % % % end
% % % %  index_show=strcat([ name '-' perio]);


 
 index_show='SU35-AMJJASO'

 if strcmp ( index_show,'su36')
starting_date='21-Jun';
ending_date='21-Sep';
thre_val=36;
 elseif strcmp ( index_show,'su40')
starting_date='21-Jun';
ending_date='21-Sep';
thre_val=40;
 elseif strcmp ( index_show,'SU35-AMJJASO')
starting_date='1-Apr';
ending_date='31-Oct';
thre_val=35;
 elseif strcmp ( index_show,'spr32')
starting_date='21-Apr';
ending_date='21-Jun';
thre_val=32;
 end
 
 
%%%% LOADING DATASETS CLOSEST TO IPMA WETAHER STATIONS
%%%%SCELTA SIMULAZIONE GLOBALE 
simulatio_glo1='ERA5';
DOMAIN='EU-'
var_glo='t2m'; % t2m tp
tipoSRF='daymax'; %% [];  dayavg daymin daymax daysum

var_glo_nome=strcat([ var_glo '-' tipoSRF]) ; % precip t2m tmax

res='028';


%leggo il primo file per estrarre lat lon lev,......
year12=2020; 
%%len2=[  365 365 365 365 365 365 365 365 365 365 365 365 365 365 365 365 365 365 365 365 365 365 365 365 365 365];
annofin=2020;

if strcmp (var_glo_nome,'tp')
multi_glo1=1000; %
else
    multi_glo1=1;
end

%%%%% reference period (hindcast)
year12_ref=1993;
annofin_ref=2016;




%%%%%% SERIE TEMP SU BOX


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
%%%%%Leggo il  file per la griglia


filenamenc=strcat([pth0 'DATI/' simulatio_glo1 '/' DOMAIN 'mask_' res   '.nc' ]);


lat2_glo1_old=double(ncread(filenamenc,'latitude'));
lon2_glo1_old=double(ncread(filenamenc,'longitude'));




lon2_glo1=lon2_glo1_old;
lat2_glo1=lat2_glo1_old;

% % % % 
% % % % lat2_glo1=nc2_glo1{'latitude'}(:);
% % % % lon2_glo1=nc2_glo1{'longitude'}(:);
xlon2_glo1=length(lon2_glo1);

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




% % % scala_glo1=nc2_glo1{'lsm'}.scale_factor(:) ;
% % % offs_glo1=nc2_glo1{'lsm'}.add_offset;
% % % mask_glo1=nc2_glo1{'lsm'}(:,:).*scala_glo1+offs_glo1;

mask_glo1=double(ncread(filenamenc,'lsm'));

% % % % % scala_glo_oro1=nc2_glo1{'z'}.scale_factor(:) ;
% % % % % offs_glo_oro1=nc2_glo1{'z'}.add_offset;
% % % oro_glo1=ncread(filenamenc,'z')./9.8;
% % % 
% % % % % oro_glo1=(nc2_glo1{'z'}(:,:).*scala_glo_oro1+offs_glo_oro1)./9.8;
% % % sotto1=find(oro_glo1<0);
% % % oro_glo1(sotto1)=0;
% % % 


mare=find(mask_glo1==0);





[longrat_glo1,latgrat_glo1]=meshgrat((lon2_glo1),(lat2_glo1));
[longrat_glo1_old,latgrat_glo1_old]=meshgrat((lon2_glo1_old),(lat2_glo1_old));

if strncmp(puppo,'PCWIN',5)
figure
pcolor(longrat_glo1_old,latgrat_glo1_old,mask_glo1)
end


% % % % oro_glo1_gr=griddata(longrat_glo1_old,latgrat_glo1_old, oro_glo1, longrat_glo1,latgrat_glo1);
% % % % 
% % % % figure
% % % % pcolor(longrat_glo1,latgrat_glo1,oro_glo1_gr)


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

if strncmp(puppo,'PCWIN',5)
figure
pcolor(longrat_glo1_old,latgrat_glo1_old,puppob)
end


 


anni2=year12:annofin;
DateNumberini = datenum(year12,01,01);
DateNumberfin = datenum(annofin,12,31);
real_length=DateNumberfin-DateNumberini+1;
t_dates=DateNumberini:DateNumberfin;
len_yrs=length(anni2);
years=anni2;
% % % 
% % % nome_file_ind=(strcat([path2out '/MAT/' dataset_obs_nome '_' int2str(year12) '-' int2str(annofin) '_' var_obs '_' NOME_BOX '_MAP.mat']));
% % % 
% % % 
% % % 
% % % 
% % % load(nome_file_ind); 

 index_stat=zeros(xlon2_box,xlat2_box,len_yrs);
% % %   va_seas=zeros(xlon2_box,xlat2_box,real_length);
% % %    va_mon=zeros(xlon2_box,xlat2_box,len_yrs*12);
% % %   
  
  len_dum=0;
for tt=1:len_yrs
    
    
    year2=year12+tt-1
            calenda_ini0=datenum([ year2 01 01]);
           calenda_fin0= datenum([ year2 12 31]);
           real_length_yr=calenda_fin0-calenda_ini0+1;    
           t_dates0=calenda_ini0:calenda_fin0;
           period={strcat([starting_date '-' int2str(year2) ]) ,  strcat([ ending_date '-' int2str(year2) ])};
           aggdates=(datenum(period{1}) :datenum(period{2}));
           len_perio=length(aggdates);
            aggdates_ini=(datenum(period{1}));
            start_date=aggdates_ini-calenda_ini0+1;
           
           t_dates_perio=ismember(t_dates0,aggdates);
           
% % %               dummy_glo=zeros(xlon2_glo1,xlat2_glo1,real_length_yr,1);
            dummy_glo=zeros(xlon2_glo1,xlat2_glo1,len_perio,1);


                questo2_glo1=(strcat( [ pth0 'DATI/' simulatio_glo1 '/' int2str(year2) '/DAILY/' simulatio_glo1 '-' DOMAIN  var_glo '.' int2str(year2) '_' tipoSRF '.nc']))


    dummy_glo(:,:,:)=squeeze(ncread(questo2_glo1,var_glo, [1 1 start_date], [Inf Inf len_perio])).*multi_glo1 -273.15;

  
    
% % % %     period={strcat([starting_date '-' int2str(years(tt)) ]) ,  strcat([ ending_date '-' int2str(years(tt)) ])};
% % % %    
% % % %     season=ismember(t_dates0,aggdates);
    
      for xx=1:xlon2_box
        for yy=1:xlat2_box
pippo=find (dummy_glo(veclondum(xx),veclatdum(yy),:)>=thre_val);

index_stat(xx,yy,tt)=length(pippo);


        end
    end
       

       
end





index=index_stat;

yr_1=year12;
yr_end=annofin;
yr_sub=yr_1:yr_end;
len_yrs_sub=length(yr_sub);
% % % % 
% % % % years_sub=ismember(years,yr_sub);
% % % %  index1=index(:,:,years_sub);
% % % % 
% % % % % % %  year_hit1=find(yr_sub==YR_tbd1)
% % % % % % %   year_hit2=find(yr_sub==YR_tbd2)
% % % % % % %   year_hit3=find(yr_sub==YR_tbd3)
% % % %  
% % % % 
% % % % 
% % % % f2Y_prctile=zeros(xlon2_box,xlat2_box,len_yrs_sub);
% % % % 
% % % %  for xx=1:xlon2_box
% % % %        for yy=1:xlat2_box
% % % %  for tt=1:len_yrs_sub;
% % % %      
% % % %     f2Y_prctile(xx,yy,tt)=invprctile(index1(xx,yy,(year12_ref-year12)+1:end-(annofin-annofin_ref)),index1(xx,yy,tt));
% % % %     
% % % %  end
% % % %        end
% % % %  end
% % % %  
% % % %  
% % % % nomefile_index1=strcat([path2out '/MAT/' simulatio_glo1 '_' NOME_BOX  '_perctile_ ' index_show ' ' int2str(yr_1) '-' int2str(yr_end) '_R3.mat']);
% % % % save(nomefile_index1, 'f2Y_prctile', 'yr_sub' )
% % % % 
% % % % 
% % % % %%%%% WRITE A NETCDF FILE
% % % % 
% % % % 
% % % % 
% % % % nomefile_index1=strcat([path2out '/MAT/' simulatio_glo1 '_' NOME_BOX  '_' index_show ' ' int2str(yr_1) '-' int2str(yr_end) '_R3.nc'])
% % % % uu=dir(nomefile_index1);
% % % % 
% % % % if isempty(uu)<1
% % % %     
% % % % else
% % % % 
% % % % ncid = netcdf.create(nomefile_index1,'NC_WRITE');
% % % % dimidlon = netcdf.defDim(ncid,'lon',xlon2_box);
% % % % dimidlat = netcdf.defDim(ncid,'lat',xlat2_box);
% % % % dimidyrs = netcdf.defDim(ncid,'time',len_yrs_sub);
% % % % varid = netcdf.defVar(ncid,index_show,'NC_DOUBLE',[dimidlon dimidlat dimidyrs]);
% % % % varid2 = netcdf.defVar(ncid,strcat(['percentile' index_show]),'NC_DOUBLE',[dimidlon dimidlat dimidyrs]);
% % % % varid3 = netcdf.defVar(ncid,'lon','NC_DOUBLE',dimidlon);
% % % % varid4 = netcdf.defVar(ncid,'lat','NC_DOUBLE',dimidlat);
% % % % varid5 = netcdf.defVar(ncid,'time','NC_DOUBLE',dimidyrs);
% % % % 
% % % % netcdf.endDef(ncid);
% % % % netcdf.putVar(ncid,varid,index1);
% % % % netcdf.putVar(ncid,varid2,f2Y_prctile);
% % % % netcdf.putVar(ncid,varid3,veclon);
% % % % netcdf.putVar(ncid,varid4,veclat);
% % % % netcdf.putVar(ncid,varid5,yr_sub);
% % % % netcdf.close(ncid);
% % % % 
% % % % end
% % % % 


%%%%% WRITE A NETCDF FILE PER YEARS

for tt=1:len_yrs
    
    year2=year12+tt-1

nomefile_index1=strcat([path2out '/MAT/' simulatio_glo1 '_' NOME_BOX  '_' index_show '_' int2str(year2) '_V2.nc'])
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

% % % 
% % % nomefile_index1=strcat([path2out '/MAT/' simulatio_glo1 '_' NOME_BOX  '_' index_show '_' int2str(year2) '_PERCENTILE_V2.nc'])
% % % uu=dir(nomefile_index1);
% % % 
% % % % % %  index11=squeeze(index1(:,:,tt));
% % %  index11=squeeze(f2Y_prctile(:,:,tt));
% % %  
% % % ncid = netcdf.create(nomefile_index1,'NC_WRITE');
% % % dimidlon = netcdf.defDim(ncid,'lon',xlon2_box);
% % % dimidlat = netcdf.defDim(ncid,'lat',xlat2_box);
% % % % % % varid = netcdf.defVar(ncid,index_show,'NC_DOUBLE',[dimidlon dimidlat]);
% % % varid = netcdf.defVar(ncid,strcat(['percentile' index_show]),'NC_DOUBLE',[dimidlon dimidlat]);
% % % varid3 = netcdf.defVar(ncid,'lon','NC_DOUBLE',dimidlon);
% % % varid4 = netcdf.defVar(ncid,'lat','NC_DOUBLE',dimidlat);
% % % 
% % % netcdf.endDef(ncid);
% % % netcdf.putVar(ncid,varid,index11);
% % % netcdf.putVar(ncid,varid3,veclon);
% % % netcdf.putVar(ncid,varid4,veclat);
% % % 
% % % netcdf.close(ncid);
% % % 


end




