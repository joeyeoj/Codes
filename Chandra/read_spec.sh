# conda activate ciao
read -p 'enter the path of the data folder ' pfolder
# pfolder=/Users/joey/Documents/Data/Chandra_data
# read -p 'enter obsid ' obsid
cd ${pfolder}
# cd ${pfolder}/${obsid}/repro
# length=${#obsid}
# if [ ${length} -eq 4 ]
# then
#         obsid1=${obsid}
# else
#         obsid1=0${obsid}
# fi
# read -p 'enter the name of the source ' srcname
read -p 'enter the infile ' infile
read -p 'enter the region file ' region
read -p 'enter the outroot ' outroot
read -p 'enter the bkgfile ' bkgfile
punlearn dmextract
pset dmextract infile="${infile}[[bin sky=@${region}]"
pset dmextract outfile=${outroot}
pset dmextract bkgfile="${infile}[bin sky=@${bkgfile}]"
pset dmextract opt=generic 
dmextract