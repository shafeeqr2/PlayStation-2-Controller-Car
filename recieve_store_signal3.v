//module shift9(w, Clock, Q, enable);
//	input w, Clock, enable;
//	output reg [0:8]Q;
//	
//	always@(posedge Clock)
//	begin
//		if (enable)
//			if (enable2))
//				begin
//					Q[8] <= w;
//					Q[7] <= Q[8];
//					Q[6] <= Q[7];
//					Q[5] <= Q[6];
//					Q[4] <= Q[5];
//					Q[3] <= Q[4];
//					Q[2] <= Q[3];
//					Q[1] <= Q[2];
//					Q[0] <= Q[1];
//				end
//		end
//endmodule 


module recieve_store_signal3 (GPIO_0, CLOCK_50, LEDR);
// Created a 16-bit register to store the incoming data
	input CLOCK_50;
	reg x1, x2, x3, x4;
	reg [0:8]clockcycles;
	integer i;
	integer j;
	integer k;
	integer ticks = 0;
	reg [9:0]counter;
	reg outClock = 1'b1;
	reg attention = 1'b1;
	reg bytes = 0;
	inout [0:4]GPIO_0;
	output [14:17]LEDR;
	
	assign signal = GPIO_0[4];
	assign GPIO_0[0] = outClock;
	assign GPIO_0[1] = attention;
	assign LEDR[17] = x1;
	assign LEDR[16] = x2;
	assign LEDR[15] = x3;
	assign LEDR[14] = x4;
	
//	shift9(signal,CLOCK_50, clockcycles, enable);
	
	reg enable;
//	reg enable2;
	
	always@(posedge CLOCK_50)
	begin
	if (counter == 10'd0) 
		counter <= 10'd49;
	else counter <= counter - 1'd1;

	enable <= counter == 10'd0;
	end

	always@(posedge CLOCK_50)

		if (enable) begin
				ticks = ticks + 1;
			
			if (ticks > 699) begin
				ticks = 0;
			end
			
			if (ticks == 13) begin
				attention <= 1'b0;
			end
			
			if (ticks < 21) begin
				outClock <= 1'b1;
			end
		
			if (ticks >= 21) begin 
				if (ticks <= 673) begin
					
					if (ticks%16 == 0) begin
						bytes <= bytes + 1;
					end
					
					if (bytes%2 == 0) begin
						
						outClock <= 1'b1;
					
					end else begin
						outClock <= ~outClock;
						
						//4th Byte
						if (ticks > 128) begin
							if (ticks < 148) begin
							
								if ((ticks - 128)%2 == 0) begin
								
									clockcycles[8] <= signal;
									clockcycles[7] <= clockcycles[8];
									clockcycles[6] <= clockcycles[7];
									clockcycles[5] <= clockcycles[6];
									clockcycles[4] <= clockcycles[5];
									clockcycles[3] <= clockcycles[4];
									clockcycles[2] <= clockcycles[3];
									clockcycles[1] <= clockcycles[2];
									clockcycles[0] <= clockcycles[1];
								
								end
							end
						end
					end
				end
			end
			
			if (ticks >= 676) begin
				outClock <= 1'b1;
			end
			
			if (ticks > 679) begin
				attention <= 1'b1;
			end
			
			if (clockcycles[4] == 0) begin
				x1 = 1'b1;
				x2 = 1'b0;
				
			end else if (clockcycles[5] == 0) begin
				x1 = 1'b0;
				x2 = 1'b1;

			end else if (clockcycles[6] == 0) begin
				x3 = 1'b1;
				x4 = 1'b0;	
				
			if (clockcycles[7] == 0) begin
				x3 = 1'b0;
				x4 = 1'b1;				
			end
		end
	end
	
endmodule 

