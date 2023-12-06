# https://cxc.cfa.harvard.edu/ciao/threads/prep_chart/
# run: conda activate ciao-4.15
pfolder=/Users/joey/Documents/Data/Chandra_data
cd ${pfolder}
# 下载数据，如942，输入obsid=942
read -p 'enter obsid ' obsid
obsid=942
# download_chandra_obsid $obsid
cd ${pfolder}/${obsid}
# 数据处理，输入input file和output file, /Users/joey/Chandra_data/942和/Users/joey/Chandra_data/942/repro
# chandra_repro indir=${pfolder}/${obsid} outdir=${pfolder}/${obsid}/repro
cd ${pfolder}/${obsid}/repro
# 进入Chandra quick research查找源坐标（还没找到快捷方法。。dmstat/dmcoords也许有用
read -p 'enter the source coordinate, ra, e.g., 12:16:56.990 ' ra
read -p 'enter the source coordinate, dec, e.g., +37:43:35.69 ' dec
ra=12:16:56.990
dec=+37:43:35.69

# 将dmcoords中的参数值恢复为系统默认值
punlearn dmcoords
length=${#obsid}
if [ ${length} -eq 4 ]
then
	obsid1=${obsid}
else
	obsid1=0${obsid}
fi
dmcoords acisf0${obsid1}_repro_evt2.fits op=cel ra=${ra} dec=${dec} celfmt=hms
echo "center coordinate: theta, phi: "
## 查找center坐标对应的theta和phi
pget dmcoords theta phi

read -p 'enter the name of source spectrum ' name
read -p 'enter NH ' NH
name=ngc4244
NH=0.5

photon_counts_list=()
radius_counts_list=()
photon_counts_temp=0
photon_counts_background=()
for ((i=0;i<16;i++))
do
    # 单位分别为hms，dms，pixel, 创建源光谱,extracting the pulse height spectrum
    specextract "${pfolder}/${obsid}/repro/acisf0${obsid1}_repro_evt2.fits[sky=annulus(${ra},${dec},${i},$((i+1)))]" ${name} verbose=0 clob+
    photon_counts=$(dmstat "${name}.pi[cols COUNTS]" | grep "sum" | awk '{print $2}')
    if [ $photon_counts -ge 30 ]
    then
        radius_counts_list+=($(echo "$i + 0.5" | bc))
        photon_counts_list+=("$photon_counts")
    else
        photon_counts_temp=$((photon_counts + photon_counts_temp))
        if [ $photon_counts_temp -ge 30 ]
        then
            radius_counts_list+=($(echo "$i + 0.5" | bc))
            photon_counts_list+=("$photon_counts_temp")
            photon_counts_background+=("$photon_counts_temp")
            photon_counts_temp=0
        fi
    fi
done

echo "radius_counts_list: ${radius_counts_list[@]}"
echo "photon_counts_list: ${photon_counts_list[@]}"
echo "photon_counts_background: ${photon_counts_background[@]}"
{
    printf "%s\n" "radius_counts_list: ${radius_counts_list[@]}"
    printf "%s\n" "photon_counts_list: ${photon_counts_list[@]}"
    printf "%s\n" "photon_counts_background: ${photon_counts_background[@]}"
} > output.txt

# Convert the arrays to strings
radius_counts_str=$(printf ",%s" "${radius_counts_list[@]}")
photon_counts_str=$(printf ",%s" "${photon_counts_list[@]}")
photon_counts_background_str=$(printf ",%s" "${photon_counts_background[@]}")

# Remove the leading comma
radius_counts_str=${radius_counts_str:1}
photon_counts_str=${photon_counts_str:1}
photon_counts_background_str=${photon_counts_background_str:1}

# 保存photon_counts随radius变化的图像
python_code_photon_counts="
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

mean=np.mean([float(x) for x in '${photon_counts_background_str}'.split(',')])
std_dev=round(np.sqrt(mean))
lower_bound=mean-std_dev
upper_bound=mean+std_dev

radius_counts = [float(x) for x in '${radius_counts_str}'.split(',')]
photon_counts = [float(x) for x in '${photon_counts_str}'.split(',')]
photon_counts_err=[round(np.sqrt(float(x))) for x in '${photon_counts_str}'.split(',')]
fig, ax=plt.subplots(1,2,figsize=(11,4))
ax[0].errorbar(radius_counts, photon_counts, yerr=photon_counts_err, fmt='o', color='purple')
ax[0].set_xlim(0,15)
# 画出误差范围
ax[0].fill_between([0,15], lower_bound, upper_bound, color='gray', alpha=0.5, label='$\mathrm{1\sigma~Range~is~}$'+str(round(lower_bound))+'-'+str(round(upper_bound)))
ax[0].axhline(mean, color='red', label='$\mathrm{background_{mean}=}$'+str(round(mean)))
ax[0].axhline(mean+3*std_dev, color='green', label='$\mathrm{3\sigma=}$'+str(round(mean+3*std_dev)))
ax[0].set_xlabel('Radius (pixel)')
ax[0].set_ylabel('Photons')

outliers = [(r, p) for r, p in zip(radius_counts, photon_counts) if p > upper_bound]
radius_max=round(max(outliers, key=lambda x: x[0])[0]+0.5)
print('the boundary of radius (pixel) is: '+str(radius_max))

# 用arcsec表示radius
radius_counts_arcsec = [round(float(x)*0.492,3) for x in '${radius_counts_str}'.split(',')]
ax[1].errorbar(radius_counts_arcsec, photon_counts, yerr=photon_counts_err, fmt='o', color='purple')
upper_x=16*0.492
ax[1].set_xlim(0,upper_x)
ax[1].fill_between([0,upper_x], lower_bound, upper_bound, color='gray', alpha=0.5, label='$\mathrm{1\sigma~Range~is~}$'+str(lower_bound)+'-'+str(upper_bound))
ax[1].axhline(mean, color='red', label='$\mathrm{background_{mean}=}$'+str(mean))
ax[1].axhline(mean+3*std_dev, color='green', label='$\mathrm{3\sigma=}$'+str(mean+3*std_dev))
ax[1].set_xlabel('Radius (arcsec)')
# 移除第二个子图的y轴刻度
ax[1].set_yticklabels([])
fig.suptitle('Photons vs Radius')
plt.legend()
plt.savefig('photons_vs_radius.png', dpi=300)
plt.close()

# 检查哪些值超出了误差范围
outliers = [(r, p) for r, p in zip(radius_counts_arcsec, photon_counts) if p > upper_bound]
radius_max=round(max(outliers, key=lambda x: x[0])[0]+0.5*0.492,3)
print('the boundary of radius (arcsec) is: '+str(radius_max))
"
python -c "$python_code_photon_counts"
output=$(python -c "$python_code_photon_counts")
line=$(echo "$output" | grep "the boundary of radius (pixel) is:")
radius_max=${line##* }

specextract "${pfolder}/${obsid}/repro/acisf0${obsid1}_repro_evt2.fits[sky=circle(${ra},${dec},${radius_max})]" ${name} verbose=0 clob+
# read -p 'enter the energy lower limit (keV), e.g., 0.4 ' elow
# read -p 'enter the energy upper limit (keV), e.g., 6.0 ' ehigh
elow=0.4
ehigh=6.0
#只对reduced statistic进行判断
python_code_groupcounts="
from sherpa.astro.ui import *
import matplotlib.pyplot as plt
from matplotlib.font_manager import FontProperties
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

for count in range(40, 55, 5):
    clean()
    load_data(\"${name}.pi\")
    group_counts(count)
    notice(${elow},${ehigh})
    set_source( xsphabs.abs1 * powlaw1d.p1)
    abs1.NH = 0.5
    guess(p1)
    fit()
    fit_results = get_fit_results()
    dof = fit_results.dof
    if dof>20:
        reduced_stat = fit_results.rstat
        # set_conf_opt(\"sigma\", 1)
        conf()
        conf_results=get_conf_results()
        best_fit_values=conf_results.parvals
        errors=(conf_results.parmins, conf_results.parmaxes)
        # 对ID为1的数据集, 设置x轴的单位为能量, y轴的单位为计数率, 并且不对数据进行任何缩放。
        set_analysis(1, \"energy\", \"rate\", factor=1)
        # 绘制模型的预测光谱，而不是原始的观测数据。
        # 这个函数会根据当前设置的模型参数，计算模型在每个能量点的预测值，并将这个预测光谱绘制出来。
        plot_fit_delchi()
        plt.savefig(\"source_flux_chart_\"+str(count)+\".png\")
        data=[[count, dof, \"{:.6g}\".format(reduced_stat), \"{:.6g}\".format(best_fit_values[0]), \"{:.6g}\".format(best_fit_values[1]), \"{:.6g}\".format(best_fit_values[2])]]
        # data=[[count, dof, round(reduced_stat,3), best_fit_values[0], best_fit_values[1], best_fit_values[2]]]
        # data_transposed=list(map(list, zip(*data)))
        title=[\"count\", \"d.o.f\", \"Reduced Stat\", \"NH\", \"gamma\", \"ampl\"]
        fig, ax=plt.subplots(1,1)
        ax.axis('tight')
        ax.axis('off')
        the_table = ax.table(cellText=data, colLabels=title, cellLoc = 'center', loc='center')
        # 设置表格字体
        font = FontProperties()
        font.set_family('serif')
        font.set_name('serif')
        font.set_style('normal')

        the_table.auto_set_font_size(False)
        the_table.set_fontsize(5)
        the_table.scale(1, 1)
        the_table.auto_set_column_width(col=list(range(len(title))))
        plt.savefig('fit_table.png',dpi=300)
        # # 创建一个表格的数据
        # table_data = [[\"count\", count, \"\"],
        #             [\"\", \"Best-fit\", \"Error_min\", \"Error_max],
        #             [\"abs1.nH\", best_fit_values[0], errors[0][0], errors[1][0]],
        #             [\"p1.gamma\", best_fit_values[1], errors[0][1], errors[1][1]],
        #             [\"p1.ampl\", best_fit_values[2], errors[0][2], errors[1][2]]]
        # # 打开一个txt文件，如果这个文件不存在，那么就创建这个文件
        # with open(\"table.txt\", \"a\") as file:
        #     # 遍历表格的每一行
        #     for row in table_data:
        #         # 将这一行的数据转换为字符串，并用制表符连接这些字符串
        #         line = \"\t\".join(str(x) for x in row)
        #         # 将这一行的数据写入文件，并在最后添加一个换行符
        #         file.write(line + \"\n\")
        from sherpa_contrib.chart import *
        save_chart_spectrum(\"source_flux_chart_\"+str(count)+\".dat\", elow=${elow}, ehigh=${ehigh})
        break
"
python -c "$python_code_groupcounts"

# if count==10:
    #     # 寻找单色能量(a monochromatic energy)
    #     flux_data = get_model_plot()
    #     # xhi and xlo is the range of energy
    #     egrid = (flux_data.xhi+flux_data.xlo)/2.0
    #     # y is the predicted flux by the model
    #     flux = flux_data.y
    #     mean_e = np.sum(flux*egrid)/np.sum(flux)
    #     np.savetxt(\"mean_e.txt\", [mean_e], fmt=\"%.2f\")

# mean_e=$(cat mean_e.txt)
# rm mean_e.txt
# # 计算源的光通量，使用宽波段0.4-6.0kev，对应单色能量（a monochromatic energy）为mean_e kev，得到photon_flux
# # https://cxc.cfa.harvard.edu/ciao/why/monochromatic_energy.html
# srcflux acisf0${obsid1}_repro_evt2.fits "${ra} ${dec}" flux bands="${elow}:${ehigh}:${mean_e}" psfmethod=quick verbose=0 clob+
# echo "photon flux in ${mean_e}:"
# dmkeypar flux_${elow}-${ehigh}.flux net_photflux_aper echo+

# 查找obs_id和obi_num
echo "obs_id: "
dmkeypar acisf0${obsid1}_repro_evt2.fits OBS_ID echo+
echo "obi_num: "
dmkeypar acisf0${obsid1}_repro_evt2.fits OBI_NUM echo+