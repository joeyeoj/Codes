# https://cxc.cfa.harvard.edu/ciao/threads/prep_chart/
# run: conda activate ciao-4.15
pfolder=/Users/joey/Chandra_data
cd ${pfolder}
# 下载数据，如942，输入obsid=942
read -p 'enter obsid ' obsid
# download_chandra_obsid $obsid
cd ${pfolder}/${obsid}
# 数据处理，输入input file和output file, /Users/joey/Chandra_data/942和/Users/joey/Chandra_data/942/repro
# chandra_repro indir=${pfolder}/${obsid} outdir=${pfolder}/${obsid}/repro
cd ${pfolder}/${obsid}/repro
# 进入Chandra quick research查找源坐标（还没找到快捷方法。。dmstat/dmcoords也许有用
read -p 'enter the source coordinate, ra, e.g., ra=12:16:56.990 ' ra
read -p 'enter the source coordinate, dec, e.g., dec=+37:43:35.69 ' dec
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
## 查找center坐标对应的theta和phi
pget dmcoords theta phi

read -p 'enter the name of source spectrum ' name
read -p 'enter nh ' nh
# 判断应该采用多大的radius, unit=pixels
photon_values=()
radius_values=()
rate_values=()
prev_photon_count=0
prev_radius=0
prev_rate=100
for ((i=1;i<=30;i++))
do
    # 单位分别为hms，dms，arcsec, 创建源光谱,extracting the pulse height spectrum
    specextract "/Users/joey/Chandra_data/942/repro/acisf0${obsid1}_repro_evt2.fits[sky=circle(${ra},${dec},${i})]" ${name} verbose=0 clob+
    photon_count=$(dmstat "${name}.pi[cols COUNTS]" | grep "sum" | awk '{print $2}')
    rate=$(echo "scale=5; ($photon_count-$prev_photon_count)/(3.14159*($i^2-$prev_radius^2))" | bc)
    radius_values+=("$i")
    photon_values+=("$photon_count")
    rate_values+=("$rate")

    # # Compare the current photon count with the previous photon count
    # if (( $(echo "(${photon_count} - ${prev_photon_count}) / ${prev_photon_count} < ${tolerance}" | bc -l) )); then
    #     echo "Extracted the majority of photons within a radius of ${i}"
    #     break
    # fi

    # Compare the photon rate with the previous photon rate
    if rate>prev_rate
    then
        echo "Extracted the majority of photons within a radius of ${i-1}"
        echo "photon rate is ${prev_rate}"
    fi

    # Update the previous photon count
    prev_photon_count=${photon_count}
    prev_radius=${i}
    prev_rate=${rate}
done

echo "radius_values: ${radius_values[@]}"
echo "photon_values: ${photon_values[@]}"
echo "rate_values: ${rate_values[@]}"

# Convert the arrays to strings
radius_values_str=$(printf ",%s" "${radius_values[@]}")
photon_values_str=$(printf ",%s" "${photon_values[@]}")
rate_values_str=$(printf ",%s" "${rate_values[@]}")

# Remove the leading comma
radius_values_str=${radius_values_str:1}
photon_values_str=${photon_values_str:1}
rate_values_str=${rate_values_str:1}

# 保存photon_count随radius变化的图像
python_code_photoncount="
import matplotlib.pyplot as plt
radius_values = [float(x) for x in '${radius_values_str}'.split(',')]
photon_values = [float(x) for x in '${photon_values_str}'.split(',')]
plt.plot(radius_values, photon_values)
plt.xlabel('Radius')
plt.ylabel('Photon')
plt.xlim(0,30)
# plt.yscale('log')
plt.title('Photon vs Radius')
plt.savefig('photon_vs_radius.png')
"
python -c "$python_code_photoncount"

# 保存photon_rate随radius变化的图像
python_code_photonrate="
import matplotlib.pyplot as plt
radius_values = [float(x) for x in '${radius_values_str}'.split(',')]
rate_values = [float(x) for x in '${rate_values_str}'.split(',')]
plt.plot(radius_values, rate_values)
plt.xlabel('Radius')
plt.ylabel('Photon_rate')
plt.xlim(0,30)
# plt.yscale('log')
plt.title('Photon_rate vs Radius')
plt.savefig('photon_rate_vs_radius.png')
"
python -c "$python_code_photonrate"

# # 对q值和reduced statistic同时进行判断，目前不需要
# python_code_groupcount="
# from sherpa.astro.ui import *
# import matplotlib.pyplot as plt
# qval=[]
# rstat=[]
# count_best=[]
# for count in range(5, 50, 5):
#     clean()
#     load_data(\"ngc4244.pi\")
#     group_counts(count)
#     notice(0.4,6.0)
#     set_source( xsphabs.abs1 * powlaw1d.p1)
#     abs1.nH = 0.5
#     guess(p1)
#     fit()
#     fit_results=get_fit_results()
#     q=fit_results.qval
#     r=fit_results.rstat
#     if round(q,2)>=0.85 and abs(r-1)<1:
#         qval.append(q)
#         rstat.append(r)
#         count_best.append(count)
#     set_analysis(1, \"energy\", \"rate\", factor=1)
#     plot_fit_delchi()
#     plt.xlim(0.4,6.0)
#     # plt.xscale(\"log\")
#     # plt.yscale(\"log\")
#     plt.savefig(\"source_flux_chart_\"+str(count)+\".png\")
# print(\"best count is \", count_best)
# print(\"corresponding to qval is \", qval)
# print(\"corresponding to rstat is \", rstat)
# "
# python -c "$python_code_groupcount"

read -p 'enter the energy lower limit (keV), e.g., 0.4 ' elow
read -p 'enter the energy upper limit (keV), e.g., 6.0 ' ehigh
#只对redused statistic进行判断
python_code_groupcount="
from sherpa.astro.ui import *
import matplotlib.pyplot as plt
rstat=100
count_best=None
for count in range(5, 50, 5):
    clean()
    load_data(\"ngc4244.pi\")
    group_counts(count)
    notice(${elow},${ehigh})
    set_source( xsphabs.abs1 * powlaw1d.p1)
    abs1.nH = 0.5
    guess(p1)
    fit()
    fit_results=get_fit_results()
    r=fit_results.rstat
    if abs(r-1)<abs(rstat-1):
        rstat=r
        count_best=count
    set_analysis(1, \"energy\", \"rate\", factor=1)
    plot_fit_delchi()
    plt.xlim(${elow},${ehigh})
    # plt.xscale(\"log\")
    # plt.yscale(\"log\")
    plt.savefig(\"source_flux_chart_\"+str(count)+\".png\")
print(\"best count is \", count_best)
print(\"corresponding to rstat is \", rstat)
"
python -c "$python_code_groupcount"
output=$(python -c "$python_code_groupcount")
count=$(echo "$output" | grep "best count is " | awk '{print $4}')
echo ${count}

# 进入sherpa程序，设置一个bin内至少有10个counts，设置能量范围为0.4-6.0kev，
# 拟合时使用这两个模型，xsphabs.abs1表示将xsphabs称为abs1，abs1只有一个参数nh，p1有两个参数，gamma和ampl
# 将最佳拟合模型写入文件，设置输出能量范围为0.4-6kev，设置输出的光谱数据为source_flux_chart.dat
sherpa << EOF
load_data("${name}.pi")
# For chi2gehrels, if the number of counts in each bin is small (< 5), 
# then cannot assume that the Poisson distribution 
# from which the counts are sampled has a nearly Gaussian shape.
group_counts(${count})
notice(${elow},${ehigh})
set_source( xsphabs.abs1 * powlaw1d.p1)
abs1.nH = ${nh}
guess(p1)
fit()
flux_data = get_model_plot()
egrid = (flux_data.xhi+flux_data.xlo)/2.0
flux = flux_data.y
mean_e = np.sum(flux*egrid)/np.sum(flux)
np.savetxt('mean_e.txt', [mean_e], fmt='%.2f')
# 对ID为1的数据集, 设置x轴的单位为能量, y轴的单位为计数率, 并且不对数据进行任何缩放。
set_analysis(1, "energy", "rate", factor=1)
# 绘制模型的预测光谱，而不是原始的观测数据。
# 这个函数会根据当前设置的模型参数，计算模型在每个能量点的预测值，并将这个预测光谱绘制出来。
plot_source()
import matplotlib.pylab as plt
plt.xscale("log")
plt.yscale("log")
plt.savefig("source_flux_chart.png")
from sherpa_contrib.chart import *
save_chart_spectrum("source_flux_chart.dat", elow=${elow}, ehigh=${ehigh})
EOF
mean_e=$(cat mean_e.txt)
rm mean_e.txt
# 计算源的光通量，使用宽波段0.4-6.0kev，对应单色能量（a monochromatic energy）为mean_e kev，得到photon_flux
# https://cxc.cfa.harvard.edu/ciao/why/monochromatic_energy.html
srcflux acisf0${obsid1}_repro_evt2.fits "${ra} ${dec}" flux bands="${elow}:${ehigh}:${mean_e}" psfmethod=quick verbose=0 clob+
echo "photon flux in ${mean_e}:"
dmkeypar flux_${elow}-${ehigh}.flux net_photflux_aper echo+
# 查找obs_id和obi_num
echo "obs_id: "
dmkeypar acisf0${obsid1}_repro_evt2.fits OBS_ID echo+
echo "obi_num: "
dmkeypar acisf0${obsid1}_repro_evt2.fits OBI_NUM echo+