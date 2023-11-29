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
counts=0
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
lower_limit = [round(float(x)-np.sqrt(float(x))) for x in '${photon_counts_str}'.split(',')]
upper_limit = [round(float(x)+np.sqrt(float(x))) for x in '${photon_counts_str}'.split(',')]
photon_counts_err = [lower_limit,upper_limit]
plt.figure(figsize=(10, 6))
plt.errorbar(radius_counts, photon_counts, yerr=photon_counts_err, fmt='o', color='purple')
plt.xlim(0,16)
# 画出误差范围
plt.fill_between([0,16], lower_bound, upper_bound, color='gray', alpha=0.5, label='$\mathrm{1\sigma~Range~is~}$'+str(lower_bound)+'-'+str(upper_bound))
plt.axhline(mean, color='red', label='$\mathrm{background_{mean}=}$'+str(mean))
plt.axhline(mean+3*std_dev, color='green', label='$\mathrm{3\sigma=}$'+str(mean+3*std_dev))
plt.xlabel('Radius (pixel)')
plt.ylabel('Photons')
plt.title('Photons vs Radius')
plt.legend()
plt.savefig('photons_vs_radius(pixel).png')
plt.close()

outliers = [(r, p) for r, p in zip(radius_counts, photon_counts) if p > upper_bound]
print('the boundary of radius is: '+str(max(outliers, key=lambda x: x[0])))

# 用arcsec表示radius
radius_counts_arcsec = [round(float(x)*0.492,3) for x in '${radius_counts_str}'.split(',')]
plt.figure(figsize=(10, 6))
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
plt.savefig('photons_vs_radius(arcsec).png')
plt.close()

# 检查哪些值超出了误差范围
outliers = [(r, p) for r, p in zip(radius_counts_arcsec, photon_counts) if p > upper_bound]
print('the boundary of radius is: '+str(max(outliers, key=lambda x: x[0])))
"
python -c "$python_code_photon_counts"

#     # Compare the photon rate with the previous photon rate
#     # echo "$rate < 1" | bc -l会输出1如果$rate小于1，否则输出0。
#     # 然后，[ $(echo "$rate < 1" | bc -l) -eq 1 ]会检查这个输出是否等于1，如果等于1，那么整个if语句就为真。
#     if [ $(echo "$rate < 1" | bc -l) -eq 1 ]
#     then
#         number=$((number+1))
#         if [ ${number} -eq 1 ]
#         then
#             ## 删除最后一个元素
#             # radius_values=("${radius_values[@]:0:${#radius_values[@]}-1}")
#             # photon_values=("${photon_values[@]:0:${#photon_values[@]}-1}")
#             # rate_values=("${rate_values[@]:0:${#rate_values[@]}-1}")
#             radius_final=${prev_radius}
#             echo "Extracted the majority of photons within a radius of ${prev_radius}"
#             echo "photon rate is ${prev_rate}"
#         fi
#     fi

#     # Update the previous photon count
#     prev_photon_count=${photon_count}
#     prev_radius=${i}
#     prev_rate=${rate}
# done

# echo "radius_values: ${radius_values[@]}"
# echo "photon_values: ${photon_values[@]}"
# echo "rate_values: ${rate_values[@]}"

# {
#     printf "%s\n" "radius_values: ${radius_values[@]}"
#     printf "%s\n" "photon_values: ${photon_values[@]}"
#     printf "%s\n" "rate_values: ${rate_values[@]}"
# } > output.txt

# # Convert the arrays to strings
# radius_values_str=$(printf ",%s" "${radius_values[@]}")
# photon_values_str=$(printf ",%s" "${photon_values[@]}")
# rate_values_str=$(printf ",%s" "${rate_values[@]}")

# # Remove the leading comma
# radius_values_str=${radius_values_str:1}
# photon_values_str=${photon_values_str:1}
# rate_values_str=${rate_values_str:1}

# # 保存photon_count随radius变化的图像
# python_code_photoncount="
# import matplotlib.pyplot as plt
# radius_values = [float(x) for x in '${radius_values_str}'.split(',')]
# photon_values = [float(x) for x in '${photon_values_str}'.split(',')]
# plt.plot(radius_values, photon_values)
# plt.xlabel('Radius')
# plt.ylabel('Photon')
# plt.xlim(0,30)
# # plt.yscale('log')
# plt.title('Photon vs Radius')
# plt.savefig('photon_vs_radius.png')
# "
# python -c "$python_code_photoncount"

# # 保存photon_rate随radius变化的图像
# python_code_photonrate="
# import matplotlib.pyplot as plt
# radius_values = [float(x) for x in '${radius_values_str}'.split(',')]
# rate_values = [float(x) for x in '${rate_values_str}'.split(',')]
# plt.plot(radius_values, rate_values)
# plt.xlabel('Radius')
# plt.ylabel('Photon_rate')
# plt.xlim(0,30)
# # plt.yscale('log')
# plt.title('Photon_rate vs Radius')
# plt.savefig('photon_rate_vs_radius.png')
# "
# python -c "$python_code_photonrate"

# echo "radius_final: ${radius_final}"
# specextract "${pfolder}/${obsid}/repro/acisf0${obsid1}_repro_evt2.fits[sky=circle(${ra},${dec},${radius_final})]" ${name} verbose=0 clob+
# # read -p 'enter the energy lower limit (keV), e.g., 0.4 ' elow
# # read -p 'enter the energy upper limit (keV), e.g., 6.0 ' ehigh
# elow=0.4
# ehigh=6.0
# #只对reduced statistic进行判断
# python_code_groupcount="
# from sherpa.astro.ui import *
# import matplotlib.pyplot as plt
# import numpy as np

# for count in range(5, 35, 5):
#     clean()
#     load_data(\"${name}.pi\")
#     group_counts(count)
#     notice(${elow},${ehigh})
#     set_source( xsphabs.abs1 * powlaw1d.p1)
#     abs1.nH = 0.5
#     guess(p1)
#     fit()

#     if count==10:
#         # 寻找单色能量(a monochromatic energy)
#         flux_data = get_model_plot()
#         # xhi and xlo is the range of energy
#         egrid = (flux_data.xhi+flux_data.xlo)/2.0
#         # y is the predicted flux by the model
#         flux = flux_data.y
#         mean_e = np.sum(flux*egrid)/np.sum(flux)
#         np.savetxt(\"mean_e.txt\", [mean_e], fmt=\"%.2f\")

#     set_conf_opt(\"sigma\", 1.6)
#     conf()
#     conf_results=get_conf_results()
#     best_fit_values=conf_results.parvals
#     errors=(conf_results.parmins, conf_results.parmaxes)
#     errors_pecentage=[]
#     for i in range(3):
#         error_1=errors[0][i]/best_fit_values[i]
#         error_2=errors[1][i]/best_fit_values[i]
#         errors_pecentage.append(max(error_1, error_2))
#         #设置到小数点后两位
#         errors_pecentage[i] = round(errors_pecentage[i], 2)
#     # 对ID为1的数据集, 设置x轴的单位为能量, y轴的单位为计数率, 并且不对数据进行任何缩放。
#     set_analysis(1, \"energy\", \"rate\", factor=1)
#     # 绘制模型的预测光谱，而不是原始的观测数据。
#     # 这个函数会根据当前设置的模型参数，计算模型在每个能量点的预测值，并将这个预测光谱绘制出来。
#     plot_fit_delchi()
#     plt.savefig(\"source_flux_chart_\"+str(count)+\".png\")
#     # 创建一个表格的数据
#     table_data = [[\"count\", count, \"\"],
#                 [\"\", \"Best-fit\", \"Error\"],
#                 [\"abs1.nH\", best_fit_values[0], errors_pecentage[0]],
#                 [\"p1.gamma\", best_fit_values[1], errors_pecentage[1]],
#                 [\"p1.ampl\", best_fit_values[2], errors_pecentage[2]]]
#     # 打开一个txt文件，如果这个文件不存在，那么就创建这个文件
#     with open(\"table.txt\", \"a\") as file:
#         # 遍历表格的每一行
#         for row in table_data:
#             # 将这一行的数据转换为字符串，并用制表符连接这些字符串
#             line = \"\t\".join(str(x) for x in row)
#             # 将这一行的数据写入文件，并在最后添加一个换行符
#             file.write(line + \"\n\")
#     from sherpa_contrib.chart import *
#     save_chart_spectrum(\"source_flux_chart_\"+str(count)+\".dat\", elow=${elow}, ehigh=${ehigh})
# "
# python -c "$python_code_groupcount"

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