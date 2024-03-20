pfolder=/Users/joey/Documents/Data/Chandra_data/pre
read -p 'enter obsid ' obsid
cd ${pfolder}/${obsid}/repro
length=${#obsid}
if [ ${length} -eq 4 ]
then
        obsid1=${obsid}
else
        obsid1=0${obsid}
fi
## get the nominal celestial position of the telescope optical axis, roll_nom, double, deg, 
## observation tangent plane roll angle (used to determine tangent plane North)，表示ccd array旋转的角度
# dmlist acisf0${obsid1}_repro_evt2.fits header | grep _NOM
parameters_nom=$(dmlist acisf0${obsid1}_repro_evt2.fits header | grep _NOM)
parameters_telescope=$(echo "${parameters_nom}" | awk '{print $3}' )
read -ra nom_split <<< ${parameters_telescope}

for filename in `ls -a ${pfolder}/${obsid}/repro`
do
        if [ "${filename##*_}"x = "pointed"x ];then
                file=${pfolder}/${obsid}/repro/${filename}
		filename_special=${filename}
        fi
        if [ "${filename##*_}"x = "dithered"x ];then
                file=${pfolder}/${obsid}/repro/${filename}
		filename_special=${filename}
        fi
done

dmlist ${file}/${filename_special}_i0000_rays.fits header | egrep "SRC_(RA|DEC)"
parameters_src=$(dmlist ${file}/${filename_special}_i0000_rays.fits header | egrep "SRC_(RA|DEC)")
parameters_source=$(echo "${parameters_src}" | awk '{print $3}' )
read -ra src_split <<< ${parameters_source}
## dmkeypar检索文件中的关键字，并返回相关值显示在terminal，to check if the ChaRT simulation used an aspect solution，
## 通常这个文件chandra_repro后就存在了
dmkeypar ${file}/${filename_special}_i0000_rays.fits ASOLFILE echo+
# 显示psf图像
pset simulate_psf infile=acisf0${obsid1}_repro_evt2.fits
## 设置输出名称
pset simulate_psf outroot=chart
# psf源的ra，dec，degree
pset simulate_psf ra=${src_split[0]}
pset simulate_psf dec=${src_split[1]}
## 选择是使用“marx”来模拟 Chandra mirror还是使用“file”（将使用 rayfile 参数中指定的 ChaRT rayfiles）
pset simulate_psf simulator=file
pset simulate_psf rayfile=${file}/${filename_special}_i0000_rays.fits
## 使用marx应用程序将rays投射到探测器上，另一个选择是"psf_project_ray"，如果similator选择了marx，这里只能选marx
pset simulate_psf projector=marx
## 从参数文件中得到参数，不提示输入参数
simulate_psf mode=h

# 将参数文件复制放入local folder
cp /Users/joey/MARX/marx-5.5.2/share/marx/pfiles/marx.par ./marx.par
## 添加write权限
chmod +w ./marx.par

read -p 'enter the type of detector, e.g., ACIS-S ' type
# 设置marx拟合时的必要参数
pset ./marx SAOSACFile=${file}/${filename_special}_i0000_rays.fits
## 输出文件取名
pset ./marx OutputDir=marx_output_i0000.dir
pset ./marx SourceType=SAOSAC
pset ./marx RA_Nom=${nom_split[0]}
pset ./marx Dec_Nom=${nom_split[1]}
pset ./marx Roll_Nom=${nom_split[2]}
pset ./marx SourceRA=${src_split[0]}
pset ./marx SourceDEC=${src_split[1]}
pset ./marx DitherModel=FILE
pset ./marx DitherFile=$(ls -a ${pfolder}/${obsid}/repro | grep pcadf0${obsid1})
pset ./marx DetectorType=${type}
pset ./marx GratingType=NONE 
pset ./marx ExposureTime=0.0
dmlist acisf0${obsid1}_repro_evt2.fits header | grep SIM_
parameters_sim=$(dmlist acisf0${obsid1}_repro_evt2.fits header | grep SIM_)
parameters=$(echo "${parameters_sim}" | awk '{print $3}')
read -ra sim_split <<< ${parameters}
if [ "$type" = "ACIS-I" ]
then
	offsetx=$(echo "scale=12; ${sim_split[0]}+0.78234819833843" | bc)
	offxetz=$(echo "scale=12; ${sim_split[2]}+233.5924630914" | bc)
	pset ./marx AspectBlur=0.20
elif [ "$type" = "ACIS-S" ]
then 
	offsetx=$(echo "scale=12; ${sim_split[0]}+0.68426746699586" | bc)
        offxetz=$(echo "scale=12; ${sim_split[2]}+190.1325231040" | bc)
	pset ./marx AspectBlur=0.25
elif [ "$type" = "HRC-I" ]
then
	offsetx=$(echo "scale=12; ${sim_split[0]}+1.0402925884" | bc)
        offxetz=$(echo "scale=12; ${sim_split[2]}-126.9854943053" | bc)
	pset ./marx AspectBlur=0.07
elif [ "$type" = "HRC-S(spec)" ]
then
        offsetx=$(echo "scale=12; ${sim_split[0]}+1.4295857921" | bc)
        offxetz=$(echo "scale=12; ${sim_split[2]}-250.4559758190" | bc)
        pset ./marx AspectBlur=0.07
elif [ "$type" = "HRC-S(image)" ]
then
        offsetx=$(echo "scale=12; ${sim_split[0]}+1.5333365632" | bc)
        offxetz=$(echo "scale=12; ${sim_split[2]}-250.4559758190" | bc)
        pset ./marx AspectBlur=0.07
fi
offsety=$(echo "scale=12; ${sim_split[1]}-0" | bc)
pset ./marx DetOffsetX=${offsetx}
pset ./marx DetOffsetY=${offsety}
pset ./marx DetOffsetZ=${offsetz}
## 对rays作投影
marx @@./marx.par
ls marx_output_i0000.dir
## 转成fits文件，创建事件文件（event file）
marx2fits --pixadj=EDSER marx_output_i0000.dir marx_output_i0000.fits

# dmlist marx_output_i0000.fits blocks
dmlist "acisf0${obsid1}_repro_evt2.fits[cols ccd_id]" data,clean | head -n 2
read -p 'enter the ccd_id ' ccd_id
dmlist marx_output_i0000.fits cols
read -p 'enter the elow (eV) ' elow
read -p 'enter the ehigh (eV) ' ehigh
apply_fov_limits "acisf0${obsid1}_repro_evt2.fits[ccd_id=${ccd_id},energy=${elow}:${ehigh}]" bin1.fits bin=1
get_sky_limits bin1.fits
read -p 'enter the DM filter ' pixels
## 创建模拟所得的点源psf的图像文件
dmcopy "marx_output_i0000.fits[bin ${pixels}]" psf_match_i0000.fits
# for d in i0001 i0002 i0003 i0004
# do 
# 	marx @@./marx OutputDir=marx_output_${d}.dir SAOSACFile=${filename_special}_${d}_rays.fits
# 	marx2fits --pixadj=EDSER marx_output_${d}.dir marx_output_${d}.fits
# done
# dmmerge "marx_output_i00*.fits" marx_output.fits
# cts=$(dmlist marx_output.fits counts)
# dmimgcalc "marx_output.fits[bin ${pixels}]" none norm_psf.fits op="imgout=img1/((float)${cts})" clob+