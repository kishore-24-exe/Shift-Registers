module shift_reg_pipo(
	input reset_n,
	input clk,
    input [3:0] d,
	output reg [3:0] q
    );

	always @(posedge clk or negedge reset_n) begin
	    if (!reset_n)
		    q <= 4'b0;
	    else
		    q[3:0] <= d[3:0];  
	end
endmodule

`timescale 1us/1ns
module tb_shift_reg_pipo();
	
	// Testbench variables
    reg [3:0] d;
	reg clk = 0;
	reg reset_n;
	wire [3:0] q;
    integer i;
	
	// Instantiate the DUT
    shift_reg_pipo PIPO0(
	    .reset_n(reset_n),
	    .clk(clk),
            .d(d),
	    .q(q)
    );
	
	always begin #0.5 clk = ~clk; end
	  
    initial begin
	    #1; // apply reset 
        reset_n = 0; d = 0;		
		#1.3; // release the reset
		reset_n = 1;

		for (i=0; i<5; i=i+1) begin
           @(posedge clk); d = $random;
		end	
	end
	
    initial begin
        #10 $stop;
    end  
endmodule
