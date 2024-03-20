# https://cxc.cfa.harvard.edu/ciao/threads/prep_chart/
# run: conda activate ciao-4.15
pfolder=/Users/joey/Documents/Data/Chandra_data
cd ${pfolder}
# 下载数据，如942，输入obsid=942
read -p 'enter obsid ' obsid
if [ -d ${obsid} ]
then
	echo "The folder exists"
else
	download_chandra_obsid $obsid
	# 数据处理，输入input file和output file, /Users/joey/Chandra_data/942和/Users/joey/Chandra_data/942/repro
	chandra_repro indir=${pfolder}/${obsid} outdir=${pfolder}/${obsid}/repro
fi
cd ${pfolder}/${obsid}/repro
# 进入Chandra quick research查找源坐标（还没找到快捷方法。。dmstat/dmcoords也许有用
read -p 'enter the source coordinate, ra, e.g., 12:27:49.15 ' ra
read -p 'enter the source coordinate, dec, e.g., +32:14:59.0 ' dec
read -p 'enter the name of source spectrum ' name
read -p 'enter NH ' NH

length=${#obsid}
if [ ${length} -eq 4 ]
then
	obsid1=${obsid}
else
	obsid1=0${obsid}
fi

# 将dmcoords中的参数值恢复为系统默认值
punlearn dmcoords
dmcoords acisf0${obsid1}_repro_evt2.fits op=cel ra=${ra} dec=${dec} celfmt=hms
echo "center coordinate: theta, phi: "
## 查找center坐标对应的theta和phi
pget dmcoords theta phi

read -p 'enter the maximum radius of the region (pixel), e.g., 20 ' radius_max
punlearn specextract
pset specextract infile="${pfolder}/${obsid}/repro/acisf0${obsid1}_repro_evt2.fits[sky=circle(${ra},${dec},${radius_max})]"
pset specextract outroot="${name}"
pset specextract bkgfile="${pfolder}/${obsid}/repro/acisf0${obsid1}_repro_evt2.fits[sky=annulus(${ra},${dec},${radius_max},"$(echo "${radius_max}+20" | bc -l)")]"
pset specextract energy_wmap="500:2000"
pset specextract binwmap=40
specextract
photon_counts=$(dmstat "${name}.pi[cols COUNTS]" | grep "sum" | awk '{print $2}')
echo "photon_counts: ${photon_counts}"

read -p 'enter the energy lower limit (keV), e.g., 0.4 ' elow
read -p 'enter the energy upper limit (keV), e.g., 6.0 ' ehigh

python_code_spectrum="
from sherpa.astro.ui import *
from sherpa_contrib.chart import *
import matplotlib.pyplot as plt

count=40
clean()
load_data(\"${name}.pi\")
group_counts(count)
notice(${elow},${ehigh})
set_source( xsphabs.abs1 * powlaw1d.p1)
abs1.NH = ${NH}
guess(p1)
fit()
set_analysis(1, \"energy\", \"rate\", factor=1)
plot_source()
plt.xscale(\"log\")
plt.yscale(\"log\")
save_chart_spectrum(\"source_flux_chart.dat\", elow=${elow}, ehigh=${ehigh})
"
python -c "${python_code_spectrum}"
# #计算单色能量和photon flux
# srcflux acisf0${obsid1}_repro_evt2.fits "${ra} ${dec}" flux psfmethod=quick outroot=out verbose=0 clob+
# dmtcalc flux_0001.arf arf_weights expression="mid_energy=(energ_lo+energ_hi)/2.0;weights=(mid_energy*specresp)" clob+
# dmstat "arf_weights[mid_energy=2.0:10.0][cols weights,specresp]" verbose=0
# # 使用 pget dmstat out_sum 获取输出
# output=$(pget dmstat out_sum)
# output=$(echo $output | tr ',' ' ')
# read value1 value2 <<< "$output"
# mono_e=$(echo "${value1} / ${value2}" | bc -l)
# echo "mono_e: ${mono_e}"
# numbers=(4.0 3.4 4.4 3.6)
# photon_fluxes=(4.72E-06 4.64E-06 4.99E-06 4.63E-06)
# # 初始化最小差距和对应的 photon_flux
# min_diff=999999999
# min_flux=0
# # 遍历 numbers 数组
# for i in "${!numbers[@]}"; do
# 	# 计算差距
# 	diff=$(echo "${numbers[i]} - $mono_e" | bc -l | tr -d -)
# 	# 如果差距小于当前的最小差距，更新最小差距和对应的 photon_flux
# 	if (( $(echo "$diff < $min_diff" | bc -l) )); then
# 		min_diff=$diff
# 		min_flux=${photon_fluxes[i]}
# 		mono_e=${numbers[i]}
# 	fi
# done
# # 打印最小差距对应的 photon_flux
# photon_flux=$(echo $min_flux)
# echo "mono_e_new: ${mono_e}"
# echo "photon_flux: ${photon_flux}"

parameters_nom=$(dmlist acisf0${obsid1}_repro_evt2.fits header | grep _NOM)
parameters_telescope=$(echo "${parameters_nom}" | awk '{print $3}' )
echo "parameters_telescope: ${parameters_telescope}"

# 查找obs_id和obi_num
echo "obs_id: "
dmkeypar acisf0${obsid1}_repro_evt2.fits OBS_ID echo+
echo "obi_num: "
dmkeypar acisf0${obsid1}_repro_evt2.fits OBI_NUM echo+