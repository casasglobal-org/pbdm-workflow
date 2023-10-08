
# A sh script to obtain daily data from the hourly era5 data downloaded using the python script 
# download_cds_era5_an.py.It also requires cdo 

varnome=tp;


YEAR=2020;

dataset="ERA5"
DATAIN=/home/alex/DATI/${dataset}
mani="daysum"
CDO_FILE_SUFFIX="_${mani}.nc"
echo $CDO_FILE_SUFFIX


echo $YEAR
mkdir ${DATAIN}/${YEAR}/DAILY
for nome in ${DATAIN}/${YEAR}/*${varnome}*.nc
do
echo $nome
a=`echo $nome|sed s[\.nc[[g`
#cp $nome  ${DATAIN}/${YEAR}/TEMP/
#mv $nome /g/ftp_medcordex/MEDCORDEX/$dove/ENEA/CORE/MONTHLY/$a$CDO_FILE_SUFFIX 
cp $nome ${DATAIN}/${YEAR}/DAILY/puppob.nc
cdo  -b 64 -$mani -selyear,${YEAR} ${DATAIN}/${YEAR}/DAILY/puppob.nc ${DATAIN}/${YEAR}/DAILY/puppob1.nc 


cdo sellevidx,1 ${DATAIN}/${YEAR}/DAILY/puppob1.nc  ${DATAIN}/${YEAR}/DAILY/prova1.nc
cdo sellevidx,2 ${DATAIN}/${YEAR}/DAILY/puppob1.nc  ${DATAIN}/${YEAR}/DAILY/prova2.nc
cdo --reduce_dim -enssum ${DATAIN}/${YEAR}/DAILY/prova1.nc ${DATAIN}/${YEAR}/DAILY/prova2.nc ${DATAIN}/${YEAR}/DAILY/puppo.nc
mv ${DATAIN}/${YEAR}/DAILY/puppo.nc $a$CDO_FILE_SUFFIX 
rm ${DATAIN}/${YEAR}/DAILY/prova1.nc ${DATAIN}/${YEAR}/DAILY/prova2.nc ${DATAIN}/${YEAR}/DAILY/puppob1.nc  ${DATAIN}/${YEAR}/DAILY/puppob.nc
mv $a$CDO_FILE_SUFFIX  ${DATAIN}/${YEAR}/DAILY/
done

 
 