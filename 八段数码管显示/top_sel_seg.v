module top_sel_seg
(
    input  wire                         sys_clk                    ,
    input  wire                         sys_rst_n                  ,
	
    output wire        [   5:0]         sel                        ,
    output wire        [   7:0]         seg                         
);

wire                   [  19:0]         data                       ;
wire                   [   5:0]         point                      ;
wire                                    sign                       ;
wire                                    seg_en                     ;


data_get
#(
    .CNT_MAX                           (26'd49_999_999            ),
    .DATA_MAX                          (20'd99                    ) 
)data_get_inst1
(
    .sys_clk                           (sys_clk                   ),
    .sys_rst_n                         (sys_rst_n                 ),

    .data                              (data                      ),
    .point                             (point                     ),
    .sign                              (sign                      ),
    .seg_en                            (seg_en                    ) 
);

seg_sel seg_sel_inst1
(
    .sys_clk                           (sys_clk                   ),
    .sys_rst_n                         (sys_rst_n                 ),
    .point                             (point                     ),
    .seg_en                            (seg_en                    ),
    .data                              (data                      ),
    .sign                              (sign                      ),

    .seg                               (seg                       ),
    .sel                               (sel                       ) 
);

endmodule