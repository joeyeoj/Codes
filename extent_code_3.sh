pfolder=/Users/joey/Chandra_data
read -p 'enter obsid ' obsid
read -p 'enter the type of detector, e.g., ACIS-S ' type
cd ${pfolder}/${obsid}/repro
length=${#obsid}
if [ ${length} -eq 4 ]
then
        obsid1=${obsid}
else
        obsid1=0${obsid}
fi
# # removing contaminating point sources
# more contam.reg
# dmcopy "bin1.fits[exclude sky=region(contam.reg)]" bin1_excel.fits

# 画psf模拟的radial profile
punlearn dmextract
pset dmextract infile="cts_psf.fits[bin sky=@match.reg]"
pset dmextract outfile=match_rprofile.fits
pset dmextract bkg="cts_psf.fits[bin sky=@match_bgd.reg]"
pset dmextract opt=generic
dmextract
dmlist match_rprofile.fits cols
dmlist match_rprofile.fits'[cols R,RMID]' data
python << EOF
from pycrates import read_file
import matplotlib.pylab as plt

tab = read_file("match_rprofile.fits")
xx = tab.get_column("rmid").values
yy = tab.get_column("sur_bri").values
ye = tab.get_column("sur_bri_err").values

plt.errorbar(xx,yy,yerr=ye, marker="o")
plt.xscale("log")
plt.yscale("log")
plt.xlabel("R_MID (pixel)")
plt.ylabel("SUR_BRI (photons/cm**2/pixel**2/s)")
plt.title('${obsid} ${type}')
plt.savefig("match_rprofile.png")
EOF
# # 对模拟的radial profile进行拟合
# sherpa << EOF
# load_data(1,"match_rprofile.fits", 3, ["RMID","SUR_BRI","SUR_BRI_ERR"])
# set_source("beta1d.src")
# src.r0 = 105 #未测试
# src.beta = 4 #未测试
# src.ampl = 0.00993448 #未测试
# # Fix model parameters so they are not changed by a fit.
# freeze(src.xpos)
# fit()
# plot_fit()
# import matplotlib.pylab as plt
# plt.xscale("log")
# plt.yscale("log")
# plt.savefig("match_rprofile_fit.png")
# EOF

# 画实际观测数据的radial profile
punlearn dmextract
pset dmextract infile="bin1.fits[bin sky=@real.reg]"
pset dmextract outfile=real_rprofile.fits
pset dmextract bkg="bin1.fits[bin sky=@real_bgd.reg]"
pset dmextract opt=generic
dmextract
dmlist real_rprofile.fits cols
dmlist real_rprofile.fits'[cols R,RMID]' data
python << EOF
from pycrates import read_file
import matplotlib.pylab as plt

tab = read_file("real_rprofile.fits")
xx = tab.get_column("rmid").values
yy = tab.get_column("sur_bri").values
ye = tab.get_column("sur_bri_err").values

plt.errorbar(xx,yy,yerr=ye, marker="o")
plt.xscale("log")
plt.yscale("log")
plt.xlabel("R_MID (pixel)")
plt.ylabel("SUR_BRI (photons/cm**2/pixel**2/s)")
plt.title('${obsid} ${type}')
plt.savefig("real_rprofile.png")
EOF
# # 对radial profile进行拟合
# sherpa << EOF
# load_data(1,"real_rprofile.fits", 3, ["RMID","SUR_BRI","SUR_BRI_ERR"])
# set_source("beta1d.src")
# src.r0 = 105
# src.beta = 4
# src.ampl = 0.00993448
# # Fix model parameters so they are not changed by a fit.
# freeze(src.xpos)
# fit()
# plot_fit()
# import matplotlib.pylab as plt
# plt.xscale("log")
# plt.yscale("log")
# plt.savefig("real_rprofile_fit.png")
# EOF
