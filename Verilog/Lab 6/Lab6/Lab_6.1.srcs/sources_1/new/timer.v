`timescale 1ns / 1ps

module timer(

    input clk,
    input reset,
    output reg [3:0] reg_d0, //count for right most digit
    output reg [3:0] reg_d1, //count for 2nd right most digit
    output reg [3:0] reg_d2, //count for 2nd left most digit
    output reg [3:0] reg_d3  //count for left most digit
    );
    
    reg [8:0] counter = 1'd9999;
    reg startstop; //start, stop or resume signal 
    
    always @ (*) begin
    if (startstop == 1 && reset ==1) //if both stop & reset asserted 
        begin 
            reg_d0 <= 1'd9; //counter0 is 0
            reg_d1 <= 1'd9; //counter1 is 0
            reg_d2 <= 1'd9; //counter2 is 0
            reg_d3 <= 1'd9; //counter3 is 0
        // if only stop signal is asserted, store the previous count
        // when stop button is pressed again, resume the old count
        end
        else if (startstop == 1) 
        begin
            reg_d0 <= reg_d0; //store the old count
            reg_d1 <= reg_d1; //store the old count
            reg_d2 <= reg_d2; //store the old count
            reg_d3 <= reg_d3; //store the old count
        end
        else if (startstop != 1) //if no stop
        begin
          if(reg_d0 == 9) // if count is xxx9 
          begin
             reg_d0 <= 0; //assign count0 to 0 
             if (reg_d1 == 9) //if count is xx99
                 begin
                    reg_d1 <= 0; //assign count1 to 0
                    if (reg_d2 == 9) // if count is x999
                        begin 
                            reg_d2 <= 0; // assign count2 to 0  
                            if(reg_d3 == 9) //if count is 9999
                                reg_d3 <= 0; //assign count3 to 0 
                            else
                                reg_d3 <= reg_d3 - 1; //else case for count 9999 
                        end else //else case for count x999
                            reg_d2 <= reg_d2 - 1;
                 end else //else case for count xx99
                     reg_d1 <= reg_d1 - 1; 
          end else // else case for count xxx9
            reg_d0 <= reg_d0 - 1;
         end
     end
         
endmodule