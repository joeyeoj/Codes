pfolder=/Users/joey/Documents/Data/Chandra_data
obsid=942
obsid1=0942
ra=12:16:56.990
dec=+37:43:35.69

radius_final=10
# read -p 'enter the energy lower limit (keV), e.g., 0.4 ' elow
# read -p 'enter the energy upper limit (keV), e.g., 6.0 ' ehigh
elow=0.4
ehigh=6.0

python_code_groupcount="
from sherpa.astro.ui import *
import matplotlib.pyplot as plt
import numpy as np

for count in range(5, 35, 5):
    clean()
    load_data(\"ngc4244.pi\")
    group_counts(count)
    notice(${elow},${ehigh})
    set_source( xsphabs.abs1 * powlaw1d.p1)
    abs1.nH = 0.5
    guess(p1)
    fit()

    if count==10:
        # 寻找单色能量(a monochromatic energy)
        flux_data = get_model_plot()
        # xhi and xlo is the range of energy
        egrid = (flux_data.xhi+flux_data.xlo)/2.0
        # y is the predicted flux by the model
        flux = flux_data.y
        mean_e = np.sum(flux*egrid)/np.sum(flux)
        np.savetxt(\"mean_e.txt\", [mean_e], fmt=\"%.2f\")

    set_conf_opt(\"sigma\", 1.6)
    conf()
    conf_results=get_conf_results()
    best_fit_values=conf_results.parvals
    errors=(conf_results.parmins, conf_results.parmaxes)
    errors_pecentage=[]
    for i in range(3):
        error_1=errors[0][i]/best_fit_values[i]
        error_2=errors[1][i]/best_fit_values[i]
        errors_pecentage.append(max(error_1, error_2))
        #设置到小数点后两位
        errors_pecentage[i] = round(errors_pecentage[i], 2)
    # 对ID为1的数据集, 设置x轴的单位为能量, y轴的单位为计数率, 并且不对数据进行任何缩放。
    set_analysis(1, \"energy\", \"rate\", factor=1)
    # 绘制模型的预测光谱，而不是原始的观测数据。
    # 这个函数会根据当前设置的模型参数，计算模型在每个能量点的预测值，并将这个预测光谱绘制出来。
    plot_fit_delchi()
    plt.savefig(\"source_flux_chart_\"+str(count)+\".png\")
    # 创建一个表格的数据
    table_data = [[\"count\", count, \"\"],
                [\"\", \"Best-fit\", \"Error\"],
                [\"abs1.nH\", best_fit_values[0], errors_pecentage[0]],
                [\"p1.gamma\", best_fit_values[1], errors_pecentage[1]],
                [\"p1.ampl\", best_fit_values[2], errors_pecentage[2]]]
    # 打开一个txt文件，如果这个文件不存在，那么就创建这个文件
    with open(\"table.txt\", \"a\") as file:
        # 遍历表格的每一行
        for row in table_data:
            # 将这一行的数据转换为字符串，并用制表符连接这些字符串
            line = \"\t\".join(str(x) for x in row)
            # 将这一行的数据写入文件，并在最后添加一个换行符
            file.write(line + \"\n\")
    from sherpa_contrib.chart import *
    save_chart_spectrum(\"source_flux_chart_\"+str(count)+\".dat\", elow=${elow}, ehigh=${ehigh})
"
python -c "$python_code_groupcount"
