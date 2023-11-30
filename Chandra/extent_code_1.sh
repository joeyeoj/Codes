# https://cxc.cfa.harvard.edu/ciao/threads/prep_chart/
# run: conda activate ciao-4.15
pfolder=/Users/joey/Documents/Data/Chandra_data
cd ${pfolder}
# 下载数据，如942，输入obsid=942
read -p 'enter obsid ' obsid
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
read -p 'enter nh ' nh
name=ngc4244
nh=0.5

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

mean=np.mean([float(x) for x in '${photon_counts_background_str}'.split(',')])
std_dev=round(np.sqrt(mean))
lower_bound=mean-std_dev
upper_bound=mean+std_dev

radius_counts = [float(x) for x in '${radius_counts_str}'.split(',')]
photon_counts = [float(x) for x in '${photon_counts_str}'.split(',')]
photon_counts_err=[round(np.sqrt(float(x))) for x in '${photon_counts_str}'.split(',')]
plt.figure(figsize=(10, 8))
plt.errorbar(radius_counts, photon_counts, yerr=photon_counts_err, fmt='o', color='purple')
plt.xlim(0,16)
# 画出误差范围
plt.fill_between([0,16], lower_bound, upper_bound, color='gray', alpha=0.5, label='$\mathrm{1\sigma~Range~is~}$'+str(round(lower_bound))+'-'+str(round(upper_bound)))
plt.axhline(mean, color='red', label='$\mathrm{background_{mean}=}$'+str(round(mean)))
plt.axhline(mean+3*std_dev, color='green', label='$\mathrm{3\sigma=}$'+str(round(mean+3*std_dev)))
plt.xlabel('Radius (pixel)')
plt.ylabel('Photons')
plt.title('Photons vs Radius')
plt.legend()
plt.savefig('photons_vs_radius(pixel).png', dpi=300)
plt.close()

outliers = [(r, p) for r, p in zip(radius_counts, photon_counts) if p > upper_bound]
radius_max=round(max(outliers, key=lambda x: x[0])[0]+0.5)
print('the boundary of radius (pixel) is: '+str(radius_max))

# 用arcsec表示radius
radius_counts_arcsec = [round(float(x)*0.492,3) for x in '${radius_counts_str}'.split(',')]
plt.figure(figsize=(10, 8))
plt.errorbar(radius_counts_arcsec, photon_counts, yerr=photon_counts_err, fmt='o', color='purple')
upper_x=16*0.492
plt.xlim(0,upper_x)
plt.fill_between([0,upper_x], lower_bound, upper_bound, color='gray', alpha=0.5, label='$\mathrm{1\sigma~Range~is~}$'+str(lower_bound)+'-'+str(upper_bound))
plt.axhline(mean, color='red', label='$\mathrm{background_{mean}=}$'+str(mean))
plt.axhline(mean+3*std_dev, color='green', label='$\mathrm{3\sigma=}$'+str(mean+3*std_dev))
plt.xlabel('Radius (arcsec)')
plt.ylabel('Photons')
plt.title('Photons vs Radius')
plt.legend()
plt.savefig('photons_vs_radius(arcsec).png', dpi=300)
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

data_nh=[]
data_gamma=[]
data_ampl=[]
data_nh_error_min=[]
data_gamma_error_min=[]
data_ampl_error_min=[]
data_nh_error_max=[]
data_gamma_error_max=[]
data_ampl_error_max=[]
data_nh_lower=[]
data_gamma_lower=[]
data_ampl_lower=[]
data_nh_upper=[]
data_gamma_upper=[]
data_ampl_upper=[]
rstat_list=[]
for count in range(5, 105, 5):
    clean()
    load_data(\"${name}.pi\")
    group_counts(count)
    notice(${elow},${ehigh})
    set_source( xsphabs.abs1 * powlaw1d.p1)
    abs1.nH = 0.5
    guess(p1)
    fit()
    fit_results = get_fit_results()
    reduced_stat = fit_results.rstat
    rstat_list.append(round(reduced_stat,6))
    # set_conf_opt(\"sigma\", 1)
    conf()
    conf_results=get_conf_results()
    best_fit_values=conf_results.parvals
    errors=(conf_results.parmins, conf_results.parmaxes)
    data_nh.append(round(best_fit_values[0],6))
    data_gamma.append(round(best_fit_values[1],6))
    data_ampl.append(round(best_fit_values[2],6))
    data_nh_error_min.append(abs(round(errors[0][0],6)))
    data_gamma_error_min.append(abs(round(errors[0][1],6)))
    data_ampl_error_min.append(abs(round(errors[0][2],6)))
    data_nh_error_max.append(abs(round(errors[1][0],6)))
    data_gamma_error_max.append(abs(round(errors[1][1],6)))
    data_ampl_error_max.append(abs(round(errors[1][2],6)))
    data_nh_lower.append(round(best_fit_values[0]+errors[0][0],6))
    data_gamma_lower.append(round(best_fit_values[1]+errors[0][1],6))
    data_ampl_lower.append(round(best_fit_values[2]+errors[0][2],6))
    data_nh_upper.append(round(best_fit_values[0]+errors[1][0],6))
    data_gamma_upper.append(round(best_fit_values[1]+errors[1][1],6))
    data_ampl_upper.append(round(best_fit_values[2]+errors[1][2],6))
    # 对ID为1的数据集, 设置x轴的单位为能量, y轴的单位为计数率, 并且不对数据进行任何缩放。
    set_analysis(1, \"energy\", \"rate\", factor=1)
    # 绘制模型的预测光谱，而不是原始的观测数据。
    # 这个函数会根据当前设置的模型参数，计算模型在每个能量点的预测值，并将这个预测光谱绘制出来。
    plot_fit_delchi()
    plt.savefig(\"source_flux_chart_\"+str(count)+\".png\")
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
data=[[count for count in range(5, 105, 5)], rstat_list, data_nh, data_nh_lower, data_nh_upper, data_gamma, data_gamma_lower, data_gamma_upper, data_ampl, data_ampl_lower, data_ampl_upper]
data_transposed=list(map(list, zip(*data)))
title=[\"count\", \"Reduced Stat\", \"nH\", \"nH_lower\", \"nH_upper\", \"gamma\", \"gamma_lower\", \"gamma_upper\", \"ampl\", \"ampl_lower\", \"ampl_upper\"]
fig, ax =plt.subplots(1,1)
ax.axis('tight')
ax.axis('off')
the_table = ax.table(cellText=data_transposed, colLabels=title, cellLoc = 'center', loc='center')
# 设置表格字体
font = FontProperties()
font.set_family('Menlo')
font.set_name('Menlo')
font.set_style('normal')

the_table.auto_set_font_size(False)
the_table.set_fontsize(5)
the_table.scale(1, 1)
the_table.auto_set_column_width(col=list(range(len(title))))

plt.savefig('fit_table.png',dpi=300)

plt.figure(figsize=(10, 8))
plt.errorbar([count for count in range(5, 105, 5)], data_nh, yerr=[data_nh_error_min, data_nh_error_max], fmt='o', color='purple')
plt.xlabel('Group Counts')
plt.ylabel('abs1.nH')
plt.title('abs1.nH vs Group Counts')
plt.savefig('abs1.nH_vs_Group_Counts.png', dpi=300)
plt.close()
plt.figure(figsize=(10, 8))
plt.errorbar([count for count in range(5, 105, 5)], data_gamma, yerr=[data_gamma_error_min, data_gamma_error_max], fmt='o', color='purple')
plt.xlabel('Group Counts')
plt.ylabel('p1.gamma')
plt.title('p1.gamma vs Group Counts')
plt.savefig('p1.gamma_vs_Group_Counts.png', dpi=300)
plt.close()
plt.figure(figsize=(10, 8))
plt.errorbar([count for count in range(5, 105, 5)], data_ampl, yerr=[data_ampl_error_min, data_ampl_error_max], fmt='o', color='purple')
plt.xlabel('Group Counts')
plt.ylabel('p1.ampl')
plt.title('p1.ampl vs Group Counts')
plt.savefig('p1.ampl_vs_Group_Counts.png', dpi=300)
plt.close()
plt.figure(figsize=(10, 8))
plt.errorbar([count for count in range(5, 105, 5)], rstat_list, fmt='o', color='purple')
plt.xlabel('Group Counts')
plt.ylabel('Reduced Statistic')
plt.title('Reduced Statistic vs Group Counts')
plt.savefig('Reduced_Statistic_vs_Group_Counts.png', dpi=300)
plt.close()
plt.figure(figsize=(10, 8))
plt.errorbar([count for count in range(5, 105, 5)], data_nh, yerr=[data_nh_error_min, data_nh_error_max], fmt='o', color='purple', label='abs1.nH')
plt.errorbar([count for count in range(5, 105, 5)], data_gamma, yerr=[data_gamma_error_min, data_gamma_error_max], fmt='o', color='green', label='p1.gamma')
plt.errorbar([count for count in range(5, 105, 5)], data_ampl, yerr=[data_ampl_error_min, data_ampl_error_max], fmt='o', color='red', label='p1.ampl')
plt.xlabel('Group Counts')
plt.ylabel('Parameters')
plt.title('Parameters vs Group Counts')
plt.legend()
plt.savefig('Parameters_vs_Group_Counts.png', dpi=300)
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
# # 查找obs_id和obi_num
# echo "obs_id: "
# dmkeypar acisf0${obsid1}_repro_evt2.fits OBS_ID echo+
# echo "obi_num: "
# dmkeypar acisf0${obsid1}_repro_evt2.fits OBI_NUM echo+