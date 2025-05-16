#基于Mips指令集的多周期五级流水线设计
目前实现指令
R型：add、sub、and、or、xor、nor、slt、sllv、srlv、srav
I型：addi、andi、ori、xori、lw、sw、beq
J型：j
使用数据前推处理RAW相关，对于load互锁减少至暂停一个时钟周期；同时将分支计算提前到译码段，使用静态预测分支失败。
在Xilinx Artix-7 EGO1开发板上通过验证。
