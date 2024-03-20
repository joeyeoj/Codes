pfolder=/Users/joey/Documents/Data/Chandra_data
read -p 'enter obsid ' obsid
# read -p 'enter the type of detector, e.g., ACIS-S ' type
cd ${pfolder}/${obsid}/repro/30ks
length=${#obsid}
if [ ${length} -eq 4 ]
then
        obsid1=${obsid}
else
        obsid1=0${obsid}
fi

# dmcopy "/Users/joey/Documents/Data/Chandra_data/4138/repro/acisf04138_repro_evt2.fits[energy=500:2000]" acisf04138_repro_evt2_500_2000.fits

for i in {1..4}
do
        # 画psf模拟的radial profile
        punlearn dmextract
        pset dmextract infile="psf_match_i0000.fits[bin sky=@${i}.reg]"
        # pset dmextract infile="acisf04138_repro_evt2_500_2000.fits[bin sky=@${i}.reg]"
        pset dmextract outfile=match_rprofile_${i}.fits
        pset dmextract bkg="psf_match_i0000.fits[bin sky=@bgd_${i}.reg]"
        # pset dmextract bkg="acisf04138_repro_evt2_500_2000.fits[bin sky=@bgd_${i}.reg]"
        pset dmextract opt=generic
        dmextract
done
# python_code_radial_profile="
# import subprocess
# import matplotlib.pyplot as plt
# import numpy as np

# params={
#         # 'axes.labelsize':20,
#         # 'xtick.labelsize':'large',
#         # 'ytick.labelsize':'large',
#         'xtick.direction':'in',
#         'ytick.direction':'in',
#         'xtick.minor.visible':True,
#         'ytick.minor.visible':True,
#         'xtick.top':True,
#         'ytick.right':True,
#         'xtick.labeltop':False,
#         'ytick.labelright':False,
#         'xtick.labelbottom':True,
#         'ytick.labelleft':True,
#         # 'xtick.major.size':10,
#         # 'ytick.major.size':10,
#         # 'xtick.minor.size':5,
#         # 'ytick.minor.size':5,
#         # 'xtick.major.width':1.5,
#         # 'ytick.major.width':1.5,
#         # 'xtick.minor.width':1,
#         # 'ytick.minor.width':1,
#         # 'errorbar.capsize':3,
#         # 'legend.fontsize':'xx-large',
#         'font.family':'serif',
#         'mathtext.default':'it',
#         'figure.subplot.wspace':0}
# plt.rcParams.update(params)

# # 运行命令并获取输出
# cmd = \"dmlist match_rprofile.fits'[cols RMID,COUNTS,ERR_COUNTS,SUR_BRI,SUR_BRI_ERR]' data\"
# output = subprocess.check_output(cmd, shell=True)
# # 将输出转换为字符串
# output = output.decode()
# output=output.split()
# output=output[7:]
# data=[]
# for i in range(1,len(output)+1):
#     if i%6==0:
#         data.append(output[i-6:i])
# column_name=data[0]
# data=data[1:]
# RMID=[]
# COUNTS=[]
# COUNTS_err=[]
# SUR_BRI=[]
# SUR_BRI_err=[]
# photons=0
# for i in range(len(data)):
#     data[i]=[float(j) for j in data[i]]
#     photons+=np.sum(data[i][2])
#     RMID.append(data[i][1])
#     COUNTS.append(data[i][2])
#     COUNTS_err.append(data[i][3])
#     SUR_BRI.append(data[i][4])
#     SUR_BRI_err.append(data[i][5])
# print('photons: '+str(photons))
# # print(len(RMID), len(COUNTS), len(COUNTS_err), RMID, COUNTS, COUNTS_err)
# fig, ax=plt.subplots(1,2,figsize=(11,4))
# ax[0].errorbar(RMID, COUNTS, yerr=COUNTS_err, fmt='o', color='purple')
# ax[0].set_xlim(0,20)
# # 画出误差范围
# # ax[0].fill_between([0,15], lower_bound, upper_bound, color='gray', alpha=0.5, label='$\mathrm{1\sigma~Range~is~}$'+str(round(lower_bound))+'-'+str(round(upper_bound)))
# # ax[0].axhline(mean, color='red', label='$\mathrm{background_{mean}=}$'+str(round(mean)))
# # ax[0].axhline(mean+3*std_dev, color='green', label='$\mathrm{3\sigma=}$'+str(round(mean+3*std_dev)))
# ax[0].set_xlabel('Radius (pixel)')
# ax[0].set_ylabel('Photons')

# ax[1].errorbar(RMID, COUNTS, yerr=COUNTS_err, fmt='o', color='purple')
# ax[1].set_xlim(0,20)
# # 画出误差范围
# ax[1].set_yscale('log')
# ax[1].set_xlabel('Radius (pixel)')
# ax[1].set_ylabel('log(Photons)')

# fig.suptitle('Photons vs Radius')
# # plt.legend()
# plt.savefig('photons_vs_radius.png', dpi=300)
# plt.close()

# fig, ax=plt.subplots(1,2,figsize=(11,4))
# ax[0].errorbar(RMID, SUR_BRI, yerr=SUR_BRI_err, fmt='o', color='purple')
# ax[0].set_xlim(0,20)
# ax[0].set_xlabel('Radius (pixel)')
# ax[0].set_ylabel('Photons/cm^2/pixel^2/s')
# ax[1].errorbar(RMID, SUR_BRI, yerr=SUR_BRI_err, fmt='o', color='purple')
# ax[1].set_xlim(0,20)
# ax[1].set_yscale('log')
# ax[1].set_xlabel('Radius (pixel)')
# ax[1].set_ylabel('log(Photons/cm^2/pixel^2/s)')
# fig.suptitle('Surface Brightness vs Radius')
# plt.savefig('surface_brightness_vs_radius.png', dpi=300)
# plt.close()
# "
# python -c "$python_code_radial_profile"
