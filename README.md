# Neural-Oscillations

## File

* model:
  * model_full.m 增加变量判断是否ratio
    * Res. V_e， Res.V_i
    * Res.V_e_P, Res.V_e_P (mean<0)
    * Res.H_ee, H_ei, H_ie, H_ii
    * Res.spike
    * Res.N_GE, Res.N_GI
    * Res.t
  * model_reduced_network.m 
  * coarse_grained.m
  * P_generation_statistics.m
  * P_generation_histogram.m
  * rare_model_full.m
  * firing_rate.m
* output:
  * model_full:  Results of full model.
  * model_reduced_twos: Results of two state reduced model.
  * model_reduced_coag: Results of coarse grained model.
* reference:
  * Notes
  * Papers
* graphics:
  * correlation.m
  * scatterplot.m
  * line_graph.m (Raster & Projection)
  * dynamical_motion.m
  * coarse_grained_plot.m 
* main.m
  * main_model_full.m
  * main_model_reduced.m
  * P_generation.m



## Todo

* 2020.9.21
  * 天一：
    * Check rare_model_full.m 里面参数是不是有问题
    * 补上P_generation.m 里面关于rare_model 的部分并且check是否正确
    * 跑一下三种noref full model和相关的rare_model， 可以简单调参，check一下结果
    * 根据Yao Li上次的idea设计一个给coarse grained model 画raster plot的 办法
    * 跑一下有ref full model 的结果
    * 调整 noref syn 的参数
  * 榆杭：
    * 仔细调整关于统计法里面如果bar下移，某些概率的计算
    * 跑三种noref fullmodel的low bar的P，观察不调整参数是否可以有好结果



* 2020.9.30
  * 天一：
    * 调出三个regime的reduced network和coarse grained model
    * 画图，P关于不同bar的变化（可以是3D，也可以是画几条线，每条线代表不同的bar）
    * 画图，P关于不同$\tau_e/\tau_i$的变化（3D或者几条线）
    * 画图，关于不同的输入，就是external drive的频率变化，P怎么变（同上）