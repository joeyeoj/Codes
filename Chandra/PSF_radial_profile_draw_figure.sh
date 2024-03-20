cd /Users/joey/Documents/Data/Chandra_data/pre/4138/repro

python_code_radial_profile="
import subprocess
import matplotlib.pyplot as plt
import numpy as np

params={
        # 'axes.labelsize':20,
        # 'xtick.labelsize':'large',
        # 'ytick.labelsize':'large',
        'xtick.direction':'in',
        'ytick.direction':'in',
        'xtick.minor.visible':True,
        'ytick.minor.visible':True,
        'xtick.top':True,
        'ytick.right':True,
        'xtick.labeltop':False,
        'ytick.labelright':False,
        'xtick.labelbottom':True,
        'ytick.labelleft':True,
        # 'xtick.major.size':10,
        # 'ytick.major.size':10,
        # 'xtick.minor.size':5,
        # 'ytick.minor.size':5,
        # 'xtick.major.width':1.5,
        # 'ytick.major.width':1.5,
        # 'xtick.minor.width':1,
        # 'ytick.minor.width':1,
        # 'errorbar.capsize':3,
        # 'legend.fontsize':'xx-large',
        'font.family':'serif',
        'mathtext.default':'it',
        'figure.subplot.wspace':0}
plt.rcParams.update(params)

# 运行命令并获取输出
cmd = \"dmlist 3.65ks_real/match_rprofile.fits'[cols RMID,SUR_BRI,SUR_BRI_ERR,BG_SUR_BRI,BG_SUR_BRI_ERR,COUNTS]' data\"
output = subprocess.check_output(cmd, shell=True)
# 将输出转换为字符串
output = output.decode()
output=output.split()
output=output[7:]
data=[]
for i in range(1,len(output)+1):
    if i%7==0:
        data.append(output[i-7:i])
column_name=data[0]
data=data[1:]
RMID=[]
SUR_BRI=[]
SUR_BRI_err=[]
BG_SUR_BRI=[]
BG_SUR_BRI_err=[]
photons_real=0
for i in range(len(data)):
    data[i]=[float(j) for j in data[i]]
    photons_real+=np.sum(data[i][6])
    RMID.append(data[i][1]*0.492)
    SUR_BRI.append(data[i][2])
    SUR_BRI_err.append(data[i][3])
    BG_SUR_BRI.append(data[i][4])
    BG_SUR_BRI_err.append(data[i][5])
print('photons(real data): '+str(photons_real))
print('SUR_BRI: '+str(SUR_BRI))

cmd = \"dmlist 3.65ks_spec/match_rprofile.fits'[cols RMID,SUR_BRI,SUR_BRI_ERR,BG_SUR_BRI,BG_SUR_BRI_ERR,COUNTS]' data\"
output = subprocess.check_output(cmd, shell=True)
# 将输出转换为字符串
output = output.decode()
output=output.split()
output=output[7:]
data=[]
for i in range(1,len(output)+1):
    if i%7==0:
        data.append(output[i-7:i])
column_name=data[0]
data=data[1:]
SUR_BRI_simulate=[]
SUR_BRI_err_simulate=[]
BG_SUR_BRI_simulate=[]
BG_SUR_BRI_err_simulate=[]
photons_simulate=0
for i in range(len(data)):
    data[i]=[float(j) for j in data[i]]
    photons_simulate+=np.sum(data[i][6])
    SUR_BRI_simulate.append(data[i][2])
    SUR_BRI_err_simulate.append(data[i][3])
    BG_SUR_BRI_simulate.append(data[i][4])
    BG_SUR_BRI_err_simulate.append(data[i][5])
print('photons(3.65 ks simulation): '+str(photons_simulate))
# print(SUR_BRI_simulate)

cmd = \"dmlist 20ks_spec/match_rprofile.fits'[cols RMID,SUR_BRI,SUR_BRI_ERR,BG_SUR_BRI,BG_SUR_BRI_ERR,COUNTS]' data\"
output = subprocess.check_output(cmd, shell=True)
# 将输出转换为字符串
output = output.decode()
output=output.split()
output=output[7:]
data=[]
SUR_BRI_20ks=[]
SUR_BRI_err_20ks=[]
BG_SUR_BRI_20ks=[]
BG_SUR_BRI_err_20ks=[]
photons_20ks=0
for i in range(1,len(output)+1):
    if i%7==0:
        data.append(output[i-7:i])
column_name=data[0]
data=data[1:]
for i in range(len(data)):
    data[i]=[float(j) for j in data[i]]
    photons_20ks+=np.sum(data[i][6])
    SUR_BRI_20ks.append(data[i][2])
    SUR_BRI_err_20ks.append(data[i][3])
    BG_SUR_BRI_20ks.append(data[i][4])
    BG_SUR_BRI_err_20ks.append(data[i][5])
print('photons(20 ks simulation): '+str(photons_20ks))

fig, ax=plt.subplots(3,1,figsize=(5,8))
ax[0].errorbar(RMID, SUR_BRI, yerr=SUR_BRI_err, fmt='o', color='purple',label='Real')
ax[0].axhline(BG_SUR_BRI[0], color='red', label='BG')
ax[0].axhline(BG_SUR_BRI[0]+3*BG_SUR_BRI_err[0], color='green', label='$\mathrm{3\sigma}$ BG')
ax[1].errorbar(RMID, SUR_BRI_simulate, yerr=SUR_BRI_err_simulate, fmt='o', color='purple',label='3.65ks')
ax[1].axhline(BG_SUR_BRI_simulate[0], color='red', label='BG')
ax[1].axhline(BG_SUR_BRI_simulate[0]+3*BG_SUR_BRI_err_simulate[0], color='green', label='$\mathrm{3\sigma}$ BG')
ax[1].axhline(BG_SUR_BRI[0]+3*BG_SUR_BRI_err[0], color='black', label='$\mathrm{3\sigma}$ real BG')
ax[2].errorbar(RMID, SUR_BRI_20ks, yerr=SUR_BRI_err_20ks, fmt='o', color='purple',label='20ks')
ax[2].axhline(BG_SUR_BRI_20ks[0], color='red', label='BG')
ax[2].axhline(BG_SUR_BRI_20ks[0]+3*BG_SUR_BRI_err_20ks[0], color='green', label='$\mathrm{3\sigma}$ BG')
ax[2].axhline(BG_SUR_BRI[0]+3*BG_SUR_BRI_err[0], color='black', label='$\mathrm{3\sigma}$ real BG')
ax[0].set_xlim(0,10)
ax[0].set_yscale('log')
# ax[0].set_title('photons: '+str(photons_real))
ax[0].legend()
ax[1].set_xlim(0,10)
ax[1].set_yscale('log')
# ax[1].set_title('photons: '+str(photons_simulate))
ax[1].legend()
ax[1].set_ylabel('Surface Brightness (counts/cm^2/arcsec^2/s)')
ax[2].set_xlim(0,10)
ax[2].set_yscale('log')
ax[2].set_xlabel('Radius (arcsec)')
# ax[2].set_title('photons: '+str(photons_20ks))
ax[2].legend()

plt.savefig('radial_profile.png',dpi=300)
"
python -c "$python_code_radial_profile"