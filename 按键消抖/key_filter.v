module key_filter                                                   //按键消抖
#(
    parameter                           COUNT_MAX = 20'd999_999     
)
(
    input  wire                         sys_clk                    ,//系统时钟
    input  wire                         sys_rst_n                  ,//系统复位
    input  wire                         key_in                     ,//按键输入
										
    output reg                          key_flag                    //按键输出
);

reg                    [  19:0]         count                      ;//计数器

always@(posedge sys_clk or negedge sys_rst_n)begin
    if(sys_rst_n == 1'b0)
        count <= 20'd0;
    else if(key_in == 1'b1)
        count <= 20'd0;
    else if(count == COUNT_MAX)
        count <= count;
    else
        count <= count + 20'd1;
end

always@(posedge sys_clk or negedge sys_rst_n)begin
    if(sys_rst_n == 1'b0)
        key_flag <= 1'b0;
    else if(count == COUNT_MAX - 20'd1)
        key_flag <= 1'b1;
    else
        key_flag <= 1'b0;
end
endmodule