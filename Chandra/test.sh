cd /Users/joey/Documents/Data/Chandra_data/4138/repro

python_code_radial_profile="
import subprocess
import matplotlib.pyplot as plt
import numpy as np

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

# 运行命令并获取输出
cmd_real = \"dmlist 3.65ks_real/match_rprofile.fits'[cols RMID,COUNTS,ERR_COUNTS,BG_COUNTS,BG_ERR]' data\"
output_real = subprocess.check_output(cmd_real, shell=True)
# 将输出转换为字符串
output_real = output_real.decode()
output_real=output_real.split()
print(output_real)
output_real=output_real[7:]
print(output_real)
"
python -c "$python_code_radial_profile"