cd /Users/joey/Documents/Data/Chandra_data/4138/repro/30ks

data=$(dmlist match_rprofile_1.fits'[cols RMID,SUR_BRI,SUR_BRI_ERR,BG_SUR_BRI,BG_SUR_BRI_ERR,COUNTS]' data)
RMID=$(echo "$data" | awk '{ print $2 }')
RMID1=$(echo "$RMID" | tr ' ' '\n' | grep -E '[0-9]')
SUR_BRI=$(echo "$data" | awk '{ print $3 }')
SUR_BRI1=$(echo "$SUR_BRI" | tr ' ' '\n' | grep -E '[0-9]')
SUR_BRI_ERR=$(echo "$data" | awk '{ print $4 }')
SUR_BRI_ERR1=$(echo "$SUR_BRI_ERR" | tr ' ' '\n' | grep -E '[0-9]')
BG_SUR_BRI=$(echo "$data" | awk '{ print $5 }')
BG_SUR_BRI1=$(echo "$BG_SUR_BRI" | tr ' ' '\n' | grep -E '[0-9]')
BG_SUR_BRI_ERR=$(echo "$data" | awk '{ print $6 }')
BG_SUR_BRI_ERR1=$(echo "$BG_SUR_BRI_ERR" | tr ' ' '\n' | grep -E '[0-9]')
COUNTS=$(echo "$data" | awk '{ print $7 }')
COUNTS1=$(echo "$COUNTS" | tr ' ' '\n' | grep -E '[0-9]')

data=$(dmlist match_rprofile_2.fits'[cols RMID,SUR_BRI,SUR_BRI_ERR,BG_SUR_BRI,BG_SUR_BRI_ERR,COUNTS]' data)
RMID=$(echo "$data" | awk '{ print $2 }')
RMID2=$(echo "$RMID" | tr ' ' '\n' | grep -E '[0-9]')
SUR_BRI=$(echo "$data" | awk '{ print $3 }')
SUR_BRI2=$(echo "$SUR_BRI" | tr ' ' '\n' | grep -E '[0-9]')
SUR_BRI_ERR=$(echo "$data" | awk '{ print $4 }')
SUR_BRI_ERR2=$(echo "$SUR_BRI_ERR" | tr ' ' '\n' | grep -E '[0-9]')
BG_SUR_BRI=$(echo "$data" | awk '{ print $5 }')
BG_SUR_BRI2=$(echo "$BG_SUR_BRI" | tr ' ' '\n' | grep -E '[0-9]')
BG_SUR_BRI_ERR=$(echo "$data" | awk '{ print $6 }')
BG_SUR_BRI_ERR2=$(echo "$BG_SUR_BRI_ERR" | tr ' ' '\n' | grep -E '[0-9]')
COUNTS=$(echo "$data" | awk '{ print $7 }')
COUNTS2=$(echo "$COUNTS" | tr ' ' '\n' | grep -E '[0-9]')

data=$(dmlist match_rprofile_3.fits'[cols RMID,SUR_BRI,SUR_BRI_ERR,BG_SUR_BRI,BG_SUR_BRI_ERR,COUNTS]' data)
RMID=$(echo "$data" | awk '{ print $2 }')
RMID3=$(echo "$RMID" | tr ' ' '\n' | grep -E '[0-9]')
SUR_BRI=$(echo "$data" | awk '{ print $3 }')
SUR_BRI3=$(echo "$SUR_BRI" | tr ' ' '\n' | grep -E '[0-9]')
SUR_BRI_ERR=$(echo "$data" | awk '{ print $4 }')
SUR_BRI_ERR3=$(echo "$SUR_BRI_ERR" | tr ' ' '\n' | grep -E '[0-9]')
BG_SUR_BRI=$(echo "$data" | awk '{ print $5 }')
BG_SUR_BRI3=$(echo "$BG_SUR_BRI" | tr ' ' '\n' | grep -E '[0-9]')
BG_SUR_BRI_ERR=$(echo "$data" | awk '{ print $6 }')
BG_SUR_BRI_ERR3=$(echo "$BG_SUR_BRI_ERR" | tr ' ' '\n' | grep -E '[0-9]')
COUNTS=$(echo "$data" | awk '{ print $7 }')
COUNTS3=$(echo "$COUNTS" | tr ' ' '\n' | grep -E '[0-9]')

data=$(dmlist match_rprofile_4.fits'[cols RMID,SUR_BRI,SUR_BRI_ERR,BG_SUR_BRI,BG_SUR_BRI_ERR,COUNTS]' data)
RMID=$(echo "$data" | awk '{ print $2 }')
RMID4=$(echo "$RMID" | tr ' ' '\n' | grep -E '[0-9]')
SUR_BRI=$(echo "$data" | awk '{ print $3 }')
SUR_BRI4=$(echo "$SUR_BRI" | tr ' ' '\n' | grep -E '[0-9]')
SUR_BRI_ERR=$(echo "$data" | awk '{ print $4 }')
SUR_BRI_ERR4=$(echo "$SUR_BRI_ERR" | tr ' ' '\n' | grep -E '[0-9]')
BG_SUR_BRI=$(echo "$data" | awk '{ print $5 }')
BG_SUR_BRI4=$(echo "$BG_SUR_BRI" | tr ' ' '\n' | grep -E '[0-9]')
BG_SUR_BRI_ERR=$(echo "$data" | awk '{ print $6 }')
BG_SUR_BRI_ERR4=$(echo "$BG_SUR_BRI_ERR" | tr ' ' '\n' | grep -E '[0-9]')
COUNTS=$(echo "$data" | awk '{ print $7 }')
COUNTS4=$(echo "$COUNTS" | tr ' ' '\n' | grep -E '[0-9]')

python_code_radial_profile="
import matplotlib.pyplot as plt
import matplotlib.image as mpimg
import numpy as np
import sys

params={
        # 'axes.labelsize':20,
        # 'xtick.labelsize':'medium',
        # 'ytick.labelsize':'medium',
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

RMID1 = [float(i)*0.492 for i in sys.argv[1].split()]
SUR_BRI1 = [float(i)/0.492**2 for i in sys.argv[2].split()]
SUR_BRI_ERR1 = [float(i)/0.492**2 for i in sys.argv[3].split()]
BG_SUR_BRI1 = [float(i)/0.492**2 for i in sys.argv[4].split()]
BG_SUR_BRI_ERR1 = [float(i)/0.492**2 for i in sys.argv[5].split()]
photons1=np.sum([float(i) for i in sys.argv[6].split()])

RMID2 = [float(i)*0.492 for i in sys.argv[7].split()]
SUR_BRI2 = [float(i)/0.492**2 for i in sys.argv[8].split()]
SUR_BRI_ERR2 = [float(i)/0.492**2 for i in sys.argv[9].split()]
BG_SUR_BRI2 = [float(i)/0.492**2 for i in sys.argv[10].split()]
BG_SUR_BRI_ERR2 = [float(i)/0.492**2 for i in sys.argv[11].split()]
photons2=np.sum([float(i) for i in sys.argv[12].split()])

RMID3 = [float(i)*0.492 for i in sys.argv[13].split()]
SUR_BRI3 = [float(i)/0.492**2 for i in sys.argv[14].split()]
SUR_BRI_ERR3 = [float(i)/0.492**2 for i in sys.argv[15].split()]
BG_SUR_BRI3 = [float(i)/0.492**2 for i in sys.argv[16].split()]
BG_SUR_BRI_ERR3 = [float(i)/0.492**2 for i in sys.argv[17].split()]
photons3=np.sum([float(i) for i in sys.argv[18].split()])

RMID4 = [float(i)*0.492 for i in sys.argv[19].split()]
SUR_BRI4 = [float(i)/0.492**2 for i in sys.argv[20].split()]
SUR_BRI_ERR4 = [float(i)/0.492**2 for i in sys.argv[21].split()]
BG_SUR_BRI4 = [float(i)/0.492**2 for i in sys.argv[22].split()]
BG_SUR_BRI_ERR4 = [float(i)/0.492**2 for i in sys.argv[23].split()]
photons4=np.sum([float(i) for i in sys.argv[24].split()])

print('photons1: '+str(photons1))
print('photons2: '+str(photons2))
print('photons3: '+str(photons3))
print('photons4: '+str(photons4))

fig, ax = plt.subplots(1, 4, figsize=(10, 4), sharey=True)
ax[0].errorbar(RMID1, SUR_BRI1, yerr=SUR_BRI_ERR1, fmt='o', color='purple')
ax[0].axhline(BG_SUR_BRI1[0], color='red', label='BG')
ax[0].axhline(BG_SUR_BRI1[0]+3*BG_SUR_BRI_ERR1[0], color='green', label='$\mathrm{3\sigma}$ BG')
ax[0].set_xlim(0,10)
ax[0].set_yscale('log')
ax[0].set_title('NE region: '+str(photons1))
ax[0].legend()
ax[0].set_xlabel('Radius (arcsec)')
ax[0].set_ylabel('Surface Brightness (counts/cm^2/arcsec^2/s)')

ax[1].errorbar(RMID2, SUR_BRI2, yerr=SUR_BRI_ERR2, fmt='o', color='purple')
ax[1].axhline(BG_SUR_BRI2[0], color='red', label='BG')
ax[1].axhline(BG_SUR_BRI2[0]+3*BG_SUR_BRI_ERR2[0], color='green', label='$\mathrm{3\sigma}$ BG')
ax[1].set_xlim(0,10)
ax[1].set_yscale('log')
ax[1].set_title('NW region: '+str(photons2))
ax[1].legend()
ax[1].xaxis.get_major_ticks()[0].label1.set_visible(False)
ax[1].set_xlabel('Radius (arcsec)')

ax[2].errorbar(RMID3, SUR_BRI3, yerr=SUR_BRI_ERR3, fmt='o', color='purple')
ax[2].axhline(BG_SUR_BRI3[0], color='red', label='BG')
ax[2].axhline(BG_SUR_BRI3[0]+3*BG_SUR_BRI_ERR3[0], color='green', label='$\mathrm{3\sigma}$ BG')
ax[2].set_xlim(0,10)
ax[2].set_yscale('log')
ax[2].set_title('SW region: '+str(photons3))
ax[2].legend()
ax[2].xaxis.get_major_ticks()[0].label1.set_visible(False)
ax[2].set_xlabel('Radius (arcsec)')

ax[3].errorbar(RMID4, SUR_BRI4, yerr=SUR_BRI_ERR4, fmt='o', color='purple')
ax[3].axhline(BG_SUR_BRI4[0], color='red', label='BG')
ax[3].axhline(BG_SUR_BRI4[0]+3*BG_SUR_BRI_ERR4[0], color='green', label='$\mathrm{3\sigma}$ BG')
ax[3].set_xlim(0,10)
ax[3].set_yscale('log')
ax[3].set_title('SE region: '+str(photons4))
ax[3].legend()
ax[3].xaxis.get_major_ticks()[0].label1.set_visible(False)
ax[3].set_xlabel('Radius (arcsec)')

# fig, ax = plt.subplots(3, 1, figsize=(5, 8))
# ax[0].errorbar(RMID_real, SUR_BRI_real, yerr=SUR_BRI_ERR_real, fmt='o', color='purple',label='Real')
# ax[0].axhline(BG_SUR_BRI_real[0], color='red', label='BG')
# ax[0].axhline(BG_SUR_BRI_real[0]+3*BG_SUR_BRI_ERR_real[0], color='green', label='$\mathrm{3\sigma}$ BG')

# ax[1].errorbar(RMID_real, SUR_BRI_simulate, yerr=SUR_BRI_ERR_simulate, fmt='o', color='purple',label='3.65ks')
# ax[1].axhline(BG_SUR_BRI_simulate[0], color='red', label='BG')
# ax[1].axhline(BG_SUR_BRI_simulate[0]+3*BG_SUR_BRI_ERR_simulate[0], color='green', label='$\mathrm{3\sigma}$ BG')
# ax[1].axhline(BG_SUR_BRI_real[0]+3*BG_SUR_BRI_ERR_real[0], color='black', label='$\mathrm{3\sigma}$ real BG')

# ax[2].errorbar(RMID_real, SUR_BRI_20ks, yerr=SUR_BRI_ERR_20ks, fmt='o', color='purple',label='20ks')
# ax[2].axhline(BG_SUR_BRI_20ks[0], color='red', label='BG')
# ax[2].axhline(BG_SUR_BRI_20ks[0]+3*BG_SUR_BRI_ERR_20ks[0], color='green', label='$\mathrm{3\sigma}$ BG')
# ax[2].axhline(BG_SUR_BRI_real[0]+3*BG_SUR_BRI_ERR_real[0], color='black', label='$\mathrm{3\sigma}$ real BG')

# ax[0].set_xlim(0,10)
# ax[0].set_yscale('log')
# # ax[0].set_title('photons: '+str(photons_real))
# ax[0].legend()

# ax[1].set_xlim(0,10)
# ax[1].set_yscale('log')
# # ax[1].set_title('photons: '+str(photons_simulate))
# ax[1].legend()
# ax[1].set_ylabel('Surface Brightness (counts/cm^2/arcsec^2/s)')

# ax[2].set_xlim(0,10)
# ax[2].set_yscale('log')
# ax[2].set_xlabel('Radius (arcsec)')
# # ax[2].set_title('photons: '+str(photons_20ks))
# ax[2].legend()

plt.savefig('radial_profile_30ks_soft.png',dpi=300)
"
python -c "$python_code_radial_profile" "$RMID1" "$SUR_BRI1" "$SUR_BRI_ERR1" "$BG_SUR_BRI1" "$BG_SUR_BRI_ERR1" "$COUNTS1" "$RMID2" "$SUR_BRI2" "$SUR_BRI_ERR2" "$BG_SUR_BRI2" "$BG_SUR_BRI_ERR2" "$COUNTS2" "$RMID3" "$SUR_BRI3" "$SUR_BRI_ERR3" "$BG_SUR_BRI3" "$BG_SUR_BRI_ERR3" "$COUNTS3" "$RMID4" "$SUR_BRI4" "$SUR_BRI_ERR4" "$BG_SUR_BRI4" "$BG_SUR_BRI_ERR4" "$COUNTS4"

# for i in {1..4}
# do
#     data_real=$(dmlist real/match_rprofile_${i}.fits'[cols RMID,SUR_BRI,SUR_BRI_ERR,BG_SUR_BRI,BG_SUR_BRI_ERR,COUNTS]' data)
#     RMID_real=$(echo "$data_real" | awk '{ print $2 }')
#     RMID_real=$(echo "$RMID_real" | tr ' ' '\n' | grep -E '[0-9]')
#     SUR_BRI_real=$(echo "$data_real" | awk '{ print $3 }')
#     SUR_BRI_real=$(echo "$SUR_BRI_real" | tr ' ' '\n' | grep -E '[0-9]')
#     SUR_BRI_ERR_real=$(echo "$data_real" | awk '{ print $4 }')
#     SUR_BRI_ERR_real=$(echo "$SUR_BRI_ERR_real" | tr ' ' '\n' | grep -E '[0-9]')
#     BG_SUR_BRI_real=$(echo "$data_real" | awk '{ print $5 }')
#     BG_SUR_BRI_real=$(echo "$BG_SUR_BRI_real" | tr ' ' '\n' | grep -E '[0-9]')
#     BG_SUR_BRI_ERR_real=$(echo "$data_real" | awk '{ print $6 }')
#     BG_SUR_BRI_ERR_real=$(echo "$BG_SUR_BRI_ERR_real" | tr ' ' '\n' | grep -E '[0-9]')
#     COUNTS_real=$(echo "$data_real" | awk '{ print $7 }')
#     COUNTS_real=$(echo "$COUNTS_real" | tr ' ' '\n' | grep -E '[0-9]')

#     data_simulate=$(dmlist simulate/match_rprofile_${i}.fits'[cols RMID,SUR_BRI,SUR_BRI_ERR,BG_SUR_BRI,BG_SUR_BRI_ERR,COUNTS]' data)
#     SUR_BRI_simulate=$(echo "$data_simulate" | awk '{ print $3 }')
#     SUR_BRI_simulate=$(echo "$SUR_BRI_simulate" | tr ' ' '\n' | grep -E '[0-9]')
#     SUR_BRI_ERR_simulate=$(echo "$data_simulate" | awk '{ print $4 }')
#     SUR_BRI_ERR_simulate=$(echo "$SUR_BRI_ERR_simulate" | tr ' ' '\n' | grep -E '[0-9]')
#     BG_SUR_BRI_simulate=$(echo "$data_simulate" | awk '{ print $5 }')
#     BG_SUR_BRI_simulate=$(echo "$BG_SUR_BRI_simulate" | tr ' ' '\n' | grep -E '[0-9]')
#     BG_SUR_BRI_ERR_simulate=$(echo "$data_simulate" | awk '{ print $6 }')
#     BG_SUR_BRI_ERR_simulate=$(echo "$BG_SUR_BRI_ERR_simulate" | tr ' ' '\n' | grep -E '[0-9]')
#     COUNTS_simulate=$(echo "$data_simulate" | awk '{ print $7 }')
    # COUNTS_simulate=$(echo "$COUNTS_simulate" | tr ' ' '\n' | grep -E '[0-9]')

    # data_20ks=$(dmlist 20ks_spec/match_rprofile_${i}.fits'[cols RMID,SUR_BRI,SUR_BRI_ERR,BG_SUR_BRI,BG_SUR_BRI_ERR,COUNTS]' data)
    # SUR_BRI_20ks=$(echo "$data_20ks" | awk '{ print $3 }')
    # SUR_BRI_20ks=$(echo "$SUR_BRI_20ks" | tr ' ' '\n' | grep -E '[0-9]')
    # SUR_BRI_ERR_20ks=$(echo "$data_20ks" | awk '{ print $4 }')
    # SUR_BRI_ERR_20ks=$(echo "$SUR_BRI_ERR_20ks" | tr ' ' '\n' | grep -E '[0-9]')
    # BG_SUR_BRI_20ks=$(echo "$data_20ks" | awk '{ print $5 }')
    # BG_SUR_BRI_20ks=$(echo "$BG_SUR_BRI_20ks" | tr ' ' '\n' | grep -E '[0-9]')
    # BG_SUR_BRI_ERR_20ks=$(echo "$data_20ks" | awk '{ print $6 }')
    # BG_SUR_BRI_ERR_20ks=$(echo "$BG_SUR_BRI_ERR_20ks" | tr ' ' '\n' | grep -E '[0-9]')
    # COUNTS_20ks=$(echo "$data_20ks" | awk '{ print $7 }')
    # COUNTS_20ks=$(echo "$COUNTS_20ks" | tr ' ' '\n' | grep -E '[0-9]')

#     python -c "$python_code_radial_profile" "$RMID_real" "$SUR_BRI_real" "$SUR_BRI_ERR_real" "$BG_SUR_BRI_real" "$BG_SUR_BRI_ERR_real" "$SUR_BRI_simulate" "$SUR_BRI_ERR_simulate" "$BG_SUR_BRI_simulate" "$BG_SUR_BRI_ERR_simulate" "$SUR_BRI_20ks" "$SUR_BRI_ERR_20ks" "$BG_SUR_BRI_20ks" "$BG_SUR_BRI_ERR_20ks" "$i" "$COUNTS_real" "$COUNTS_simulate" "$COUNTS_20ks"
# done