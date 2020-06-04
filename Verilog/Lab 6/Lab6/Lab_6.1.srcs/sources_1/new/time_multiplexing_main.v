`timescale 1ns / 1ps


module time_multiplexing_main(

    input clk,
    input startstop,
    input reset,
    input [7:0] sw,
    input [1:0] mode,
    output [3:0] an,
    output [6:0] sseg,
    output dp
    );
    
    wire [6:0] in0, in1, in2, in3;
    wire slow_clk;
    wire refresh_clk;
    //wire time_clk;
    wire [3:0] digitOne; //count for right most digit
    wire [3:0] digitTwo; //count for second right most digit
    wire [3:0] digitThree; //count for second left most digit
    wire [3:0] digitFour; //count for left most digit
    
    hexto7segment c1 (.x(digitOne), .r(in0));
    hexto7segment c2 (.x(digitTwo), .r(in1));
    hexto7segment c3 (.x(digitThree), .r(in2));
    hexto7segment c4 (.x(digitFour), .r(in3));
    
    clk_div_disp c5 (.clk(clk), .reset(reset), .time_clk(slow_clk));  
    clk_div_disp2 c7 (.clk(clk), .reset(reset), .refresh_clk(refresh_clk));
    
    stopwatch stopwatch_a (
            .clk(slow_clk),
            .startstop(startstop),
            .reset(reset),
            .mode(mode[1:0]),
            .sw(sw[7:0]),
            .digitOne(digitOne),
            .digitTwo(digitTwo),
            .digitThree(digitThree),
            .digitFour(digitFour));
    
    
    time_mux_state_machine c6(
        .clk (refresh_clk),
        .reset (reset),
        .in0 (in0),
        .in1 (in1),
        .in2 (in2),
        .in3 (in3),
        .an (an),
        .sseg (sseg),
        .dp(dp));
    
endmodule
