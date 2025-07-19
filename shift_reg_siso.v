
module shift_reg_siso(
	input reset_n,
	input clk,
    input sdi, 
	output sdo 
    );
	//Reg declaration
	reg [3:0] siso;
	
	always @(posedge clk or negedge reset_n) begin
	    if (!reset_n)
		    siso <= 4'b0;
	    else
		    siso[3:0] <= {siso[2:0], sdi};
	end
    assign sdo = siso[3];

endmodule


`timescale 1us/1ns
module tb_shift_reg_siso();
	
	// Testbench variables
    reg sdi;
	reg clk = 0;
	reg reset_n;
	wire sdo;
	
	// Instantiate the DUT
    shift_reg_siso SISO0(
		.reset_n(reset_n),
	    .clk    (clk    ),
        .sdi    (sdi    ),
	    .sdo    (sdo    )
    );
	
	always begin #0.5 clk = ~clk; end
	  
    initial begin
	    #1; 
        reset_n = 0; sdi = 0;
		
		#1.3;
		reset_n = 1;
		
		@(posedge clk); sdi = 1'b1; @(posedge clk); sdi = 1'b0;
        
        repeat (5) @(posedge clk); 
		@(posedge clk); sdi = 1'b1; 
	end
	initial begin 
		#15 $stop;
	end

endmodule
