module mealy_ol(
                in                                    ,//input
                clk                                   ,//clock
                reset                                 ,//reset
                out                                    //output
                )                                     ;

//port declaration
input             in, clk, reset                      ;//input declaration
output reg        out                                 ;//output
parameter         S0 = 0 , S1 = 1 , S2 = 2 , S3 = 3   ; //parameter declaration for states
reg         [1:0] present_state,next_state            ;//register declaration for present state and next state

/*State S0 is assigned to present state if the reset is 1 else the next state is assigned to present state*/
always@(posedge clk or posedge reset)
   begin
      if(reset)
         present_state <= S0                          ;// assign S0 to present state
      else    
         present_state <= next_state                  ;// assign next state to present state
   end             

/*Here the states S0, S1, S2, or S3 is assigned according to the input encountered (for the sequence 1101)*/
always@(present_state or in)
   begin      
     case(present_state)    
         S0 : begin
           	  	if (in)
             		next_state  = S1                    ;//assign S1 to next state if 1 is encountered
           		else
             		next_state  = S0                    ;//assign S0 to next state if 0 is encountered
           		out            = 0                     ;//output is 0 untill sequence 1101 is obtained
              end
         S1 : begin 
              	if (in)
             		next_state  = S2                    ;//assign S2 to next state if 1 is encountered
           		else
             		next_state  = S0                    ;//assign S0 to next state if 0 is encountered
           		out            = 0                     ;//output is 0 untill sequence 1101 is obtained
              end
         S2 : begin 
              	if (in)
                  next_state  = S2                    ;//assign S2 to next state if 1 is encountered
           		else
             		next_state  = S3                    ;//assign S3 to next state if 0 is encountered
           		out            = 0                     ;//output is 0 untill sequence 1101 is obtained
              end 
         S3 : begin 
           	  	if (in)
                  begin
             		out          = 1                    ;//output is 1 when sequence 1101 is obtained
                    next_state = S1                   ;//assign S1 to next state if 1 is encountered
                  end
           		else
                  begin
             		out          = 0                    ;//output is 1 when sequence 1101 is obtained
                    next_state = S0                   ;//assign S0 to next state if 0 is encountered
                  end
              end
      endcase
   end

endmodule                                              //end of mealy machine
