obsid=942
obsid1=0942
ra=12:16:56.990
dec=+37:43:35.69
name=ngc4244
# 判断应该采用多大的radius, unit=arcsec
photon_values=()
radius_values=()
rate_values=()
prev_photon_count=0
prev_radius=0
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
    # Update the previous photon count
    prev_photon_count=${photon_count}
    prev_radius=${i}
done

echo "radius_values: ${radius_values[@]}" > output.txt
echo "photon_values: ${photon_values[@]}" >> output.txt
echo "rate_values: ${rate_values[@]}" >> output.txt