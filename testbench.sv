module testbench();

timeunit 10ns;//50 Mhz Clock 

timeprecision 1ns;

logic Clk = 0;
logic Reset, Run, Continue, ContinueIR; 


logic cpu0_write;										
logic [19:0] cpu0_addr;
logic [15:0] cpu0_data_in;
logic cpu0_ready;
logic [15:0] cpu0_data_out;
logic cpu1_write;										
logic[19:0] cpu1_addr;
logic[15:0] cpu1_data_in;
logic cpu1_ready;
logic [15:0] cpu1_data_out;
logic cpu2_write;									
logic[19:0] cpu2_addr;
logic[15:0] cpu2_data_in;
logic cpu2_ready;
logic [15:0] cpu2_data_out;
logic cpu3_write;									
logic[19:0] cpu3_addr;
logic[15:0] cpu3_data_in;
logic cpu3_ready;
logic [15:0] cpu3_data_out;
wire [10:0] pcm_mem_mm_address;
wire pcm_mem_mm_chipselect;
wire pcm_mem_mm_clken;
wire pcm_mem_mm_write;
wire  [15:0] pcm_mem_mm_readdata;
wire [15:0] pcm_mem_mm_writedata;
wire [1:0] pcm_mem_mm_byteenable;

//PCM_MM_REG variables
logic resolved, cpu_write, init;
logic [19:0] addr;
logic [15:0] data_in, cpu_in;
logic schedule, cpu_ready;
logic [15:0] cpu_out;
logic [19:0] addr_reg;

logic [15:0] S;

integer ErrorCnt = 0; //Error counter; succesful run means count=0


//SOC_W_PCM soc(.*, .clk(Clk), .reset(~Reset));

//PCM_MM pcm (.*, .clk(Clk), .reset(~Reset));

PCM_MM_reg pcm_reg(.*, .clk(Clk), .reset(~Reset));

always begin : CLOCK_GENERATION //1 timeunit delay
	#1 Clk = ~Clk;
end

initial begin: CLOCK_INITIALIZATION
	Clk=0;
end

task test_setup(reg [15:0] addr);
@(posedge Clk)
#10 Reset = 0;

#10 Reset = 1;

#2 S= addr;

#100 Run = 0;

#10 Run = 1;

//#2 index = 16'hFFFF;
endtask

task test_add(int num1, int num2, reg [15:0] addr);
//@(posedge Clk)
	int sum = 0;
	sum = num1 + num2;
	test_setup(addr);
		
endtask

task PCM_MM_REG_test(reg [19:0] newaddr);
@(posedge Clk)
#2 addr =newaddr ;

#1 if(schedule == 1)
begin
#5	$display ("Schedule was set correctly");
end
else
begin
#5	$display ("Schedule was not correctly");
end

#5 data_in = 16'h0FF0;

#5 resolved = 1 ;

	

endtask
//Begin testing
initial begin: TEST_VECTORS
Reset = 1;
Run = 1;
Continue = 1;
//first function starting address will be loaded



begin
addr = 20'h00000;
data_in = 16'h0101;
#1 init = 1'b1;
#2 init = 1'b0;
#4 resolved = 1'b1;
#1 resolved = 1'b0;

#5 PCM_MM_REG_test(20'hFFFFF);


	

end

end


endmodule
