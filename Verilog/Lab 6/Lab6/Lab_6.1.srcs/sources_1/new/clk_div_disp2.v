`timescale 1ns / 1ps

module clk_div_disp2(
    input clk,
    input reset,
    output refresh_clk
    //output time_clk
    );
        

        reg [15:0] time_count;
        //reg [1:0] time_count;
        
        assign refresh_clk=time_count[15];//15 for board
            
            //always @(posedge clk or posedge reset)
            always @(posedge clk)
            begin
            if (time_count>=500000)
            //if (reset)
                time_count = 0;
            else
                time_count = time_count + 1;
            end
        
    endmodule
