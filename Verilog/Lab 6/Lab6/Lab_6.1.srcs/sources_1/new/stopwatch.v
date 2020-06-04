`timescale 1ns / 1ps

module stopwatch(

    input clk,
    input startstop,
    input reset,
    input [1:0] mode,
    input [7:0] sw,
    output reg [3:0] digitOne, // hundrethes
    output reg [3:0] digitTwo, // tenths
    output reg [3:0] digitThree, //ones
    output reg [3:0] digitFour  // tens
    );
    
    reg SS_switch;
    reg startStopFlag = 1;
    reg CountCompleteFlag;
    
    
always @ (posedge clk) begin
    SS_switch <= startstop;
    
    if( SS_switch && !startstop)
        startStopFlag <= ~startStopFlag;
end
    
//always @ (posedge clk or posedge reset) begin
always @(posedge clk) begin
//--------------- Mode 1 (Counting Up from 00.00) ---------------
    if (mode == 2'b00) begin
          if (reset == 1)//if (startStopFlag == 1 && reset == 1) //if both stop & reset astartStopFlagerted 
                begin 
                    digitOne <= 0; 
                    digitTwo <= 0; 
                    digitThree <= 0; 
                    digitFour <= 0;
                    CountCompleteFlag = 0;
                end
                
            // if only stop signal is astartStopFlagerted, store the previous count
            // when stop button is prestartStopFlaged again, resume the old count
            else if (startStopFlag == 1 && reset != 0) 
                begin
                    //store the old count
                    digitOne <= digitOne;
                    digitTwo <= digitTwo;
                    digitThree <= digitThree;
                    digitFour <= digitFour;
                end
             
             //Start stopwatch
             else if (startStopFlag != 1 && CountCompleteFlag != 1)
                begin
                  if(digitOne == 9) begin   // first digit        
                     digitOne <= 0;   
                                            
                     if (digitTwo == 9) begin   // second digit            
                            digitTwo <= 0; 
                                             
                            if (digitThree == 9) begin   // third digit  
                                    digitThree <= 0;  
                                         
                                    if(digitFour == 9)begin   // fourth digit  
                                        digitThree <= 9;
                                        digitTwo <= 9;
                                        digitOne <= 9;
                                        CountCompleteFlag = 1;
                                        
                                    end else
                                        digitFour <= digitFour + 1; 
                                        
                                end else                      
                                    digitThree <= digitThree + 1;
                                    
                         end else                             
                             digitTwo <= digitTwo + 1; 
                             
                  end else                                    
                    digitOne <= digitOne + 1;
                    
            end
     end
     
 //--------------- Mode 2 (Counting Up from XX.00) ---------------
         if (mode == 2'b01) begin
             if (startStopFlag == 1 && reset ==1) //if both stop & reset astartStopFlagerted 
                     begin 
                         digitOne <= 0;
                         digitTwo <= 0; 
                         digitThree <= sw[3:0];
                         digitFour <= sw[7:4]; 
                         CountCompleteFlag = 0;
                        
                     end
                     
                 // if only stop signal is astartStopFlagerted, store the previous count
                 // when stop button is prestartStopFlaged again, resume the old count
                 else if (startStopFlag == 1) 
                     begin
                         //store the old count
                         digitOne <= digitOne;
                         digitTwo <= digitTwo;
                         digitThree <= digitThree;
                         digitFour <= digitFour;
                    
                     end
                 else if (reset == 1 && startStopFlag !=1)//if (startStopFlag == 1 && reset == 1) //if both stop & reset astartStopFlagerted 
                      begin 
                        digitOne <= 0; 
                        digitTwo <= 0;
                        digitThree <= 0;
                        digitFour <= 0; 
                        CountCompleteFlag = 0;
                      end
                  
                  //Start stopwatch
                  else if (startStopFlag != 1 && CountCompleteFlag != 1)
                     begin
                    
                       if(digitOne == 9) begin     // first number              
                          digitOne <= 0;      
                                              
                          if (digitTwo == 9) begin     // second number          
                                 digitTwo <= 0;  
                                                 
                                 if (digitThree == 9) begin     // third number     
                                         digitThree <= 0; 
                                               
                                         if(digitFour == 9)begin     // fourth number
                                             digitThree <= 9;
                                             digitTwo <= 9;
                                             digitOne <= 9;
                                             CountCompleteFlag = 1;
                                             
                                             end else
                                             digitFour <= digitFour + 1; 
                                             
                                     end else                      
                                         digitThree <= digitThree + 1;
                                         
                              end else                             
                                  digitTwo <= digitTwo + 1; 
                                  
                       end else                                    
                         digitOne <= digitOne + 1;
                      end
          end
     
     

//--------------- Mode 3 (Counting Down from 99.99) ---------------
    if (mode == 2'b10) begin
         if (reset ==1)
         begin 
             digitOne <= 9;
             digitTwo <= 9;
             digitThree <= 9;
             digitFour <= 9;
             CountCompleteFlag = 0;
         end
         
         else if (startStopFlag == 1 && reset != 0)
         begin
             digitOne <= digitOne; //stores old value
             digitTwo <= digitTwo; //stores old value
             digitThree <= digitThree; //stores old value
             digitFour <= digitFour; //stores old value
         end
         
         else if (startStopFlag != 1 && CountCompleteFlag == 0) begin
         
           if(digitOne == 0) begin     // first number
              digitOne <= 9;
              
              if (digitTwo == 0) begin     // second number
                     digitTwo <= 9;
                     
                     if (digitThree == 0) begin     // thrid number
                             digitThree <= 9; 
                             
                             if(digitFour == 0) begin     // fourth number
                                 digitOne <= 0;
                                 digitTwo <= 0;
                                 digitThree <= 0;
                                 digitFour <= 0;
                                 CountCompleteFlag = 1;
                                 
                             end else
                                 digitFour <= digitFour - 1;
                                 
                         end else
                             digitThree <= digitThree - 1;
                             
                  end else
                      digitTwo <= digitTwo - 1; 
                      
           end else 
             digitOne <= digitOne - 1;
          end
    end
     

      
 //--------------- Mode 4 (Counting Down from XX.00) ---------------
    if (mode == 2'b11) begin
     
       if (startStopFlag == 1 && reset == 1) begin
          digitOne <= 0; 
          digitTwo <= 0; 
          digitThree <= sw[3:0]; 
          digitFour <= sw[7:4];
          CountCompleteFlag = 0;
          
      end
      else if (startStopFlag == 1) 
        begin
           
            digitOne <= digitOne;
            digitTwo <= digitTwo;
            digitThree <= digitThree;
            digitFour <= digitFour;
            
        end
      else if (startStopFlag != 1 && reset == 1)
        begin 
            digitOne <= 9;
            digitTwo <= 9;
            digitThree <= 9;
            digitFour <= 9;
            CountCompleteFlag = 0;
        end
      else if (startStopFlag != 1 && CountCompleteFlag == 0) begin //if no stop
        
        if(digitOne == 0) begin     // first number
              digitOne <= 9;
              
              if (digitTwo == 0) begin     // second number
                     digitTwo <= 9;
                     
                     if (digitThree == 0) begin     // thrid number
                             digitThree <= 9; 
                             
                             if(digitFour == 0) begin     // fourth number
                                 digitOne <= 0;
                                 digitTwo <= 0;
                                 digitThree <= 0;
                                 digitFour <= 0;
                                 CountCompleteFlag = 1;
                                 
                             end else
                                 digitFour <= digitFour - 1;
                                 
                         end else
                             digitThree <= digitThree - 1;
                             
                      end else
                          digitTwo <= digitTwo - 1; 
                          
                   end else 
                     digitOne <= digitOne - 1;
                  end
 end
     
     
end

endmodule
