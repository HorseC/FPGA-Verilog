module data_get
#(
    parameter                           CNT_MAX = 26'd49_999_999   ,
    parameter                           DATA_MAX= 20'd100           
)
(
    input  wire                         sys_clk                    ,
    input  wire                         sys_rst_n                  ,
	
    output reg         [  19:0]         data                       ,
    output wire        [   5:0]         point                      ,
    output wire                         sign                       ,
    output reg                          seg_en                      
);

reg                    [  25:0]         cnt_100ms                  ;
reg                                     cnt_flag                   ;

always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        cnt_100ms <= 26'b0;
    else if(cnt_100ms == CNT_MAX)
        cnt_100ms <= 26'b0;
    else
        cnt_100ms <= cnt_100ms + 1'd1;
		
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        cnt_flag <= 1'b0;
    else if(cnt_100ms == CNT_MAX - 1'd1)
        cnt_flag <= 1'b1;
    else
        cnt_flag <= 1'b0;
		
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        data <= 20'd0;
    else if((data == DATA_MAX) && (cnt_flag <= 1'b1))
        data <= 20'd0;
    else if(cnt_flag == 1'b1)
        data <= data + 1'd1;
    else
        data <= data;
	
assign point = 6'b000_000;
assign sign  = 1'b0;

always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        seg_en <= 1'b0;
    else
        seg_en <= 1'b1;
	
	
	
endmodule