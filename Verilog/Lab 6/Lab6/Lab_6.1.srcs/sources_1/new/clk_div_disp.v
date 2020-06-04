`timescale 1ns / 1ps


module clk_div_disp(

    input clk,
    input reset,
    output time_clk
    );
        

        reg [19:0] time_count;
        //reg [1:0] time_count;
        
        assign time_clk=time_count[19];//19 for board
            
            //always @(posedge clk or posedge reset)
            always @(posedge clk)
            begin
            if (time_count>=1000000)
            //if (reset)
                time_count = 0;
            else
                time_count = time_count + 1;
            end
        
    endmodule
