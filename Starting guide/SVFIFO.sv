//`timescale 1ns/100ps
module SVFIFO(clk, reset, WrEn, RdEn, WriteData, emptyBar, fullBar,ReadData,fillCount);
parameter ADDRWIDTH = 5; // depth = 1<<ADDRWIDTH;   
parameter DATAWIDTH = 16;

input logic clk, reset;
input logic WrEn, RdEn;
input logic [DATAWIDTH-1:0] WriteData;
output logic emptyBar, fullBar;
output [DATAWIDTH-1:0] ReadData;
output wire [ADDRWIDTH:0] fillCount;

logic [ADDRWIDTH:0] WPtr;
logic [ADDRWIDTH:0] RPtr;
logic [DATAWIDTH -1:0] fifo [1<<ADDRWIDTH :0];

always_ff@(posedge clk)
begin
if (reset == 0)
begin
	WPtr<= 0; //initialising write pointer
	RPtr<= 0; //initialising Read pointer
end
else
begin
	if (fullBar != 1 &&WrEn == 1) // Producer is allowed to write only 
                                       //if FIFO is not full
	begin
		fifo[WPtr[(ADDRWIDTH-1) :0]][DATAWIDTH -1 :0]= WriteData; //write 
		WPtr<= WPtr + 1;// to FIFO increment the pointer
	end
	
	if (emptyBar != 1 &&RdEn ==1)//When Comsumer wants to read the FIFO 
 	//FIFO is not empty then content of FIFO are read.
	RPtr<= RPtr +1; //read pointer is incremented
end
end

assign fillCount = WPtr - RPtr ; //it calculates the depth
assign ReadData = fifo[RPtr[(ADDRWIDTH-1):0]] [DATAWIDTH -1 :0] ;//data is 
                             //read out of FIFO Asynchronously
always_comb	
begin
	emptyBar = 0;
	fullBar =0;
	if (fillCount == 0) // checking for empty
		emptyBar = 1;
	else
	if (fillCount == 1<<ADDRWIDTH) //checking for full
		fullBar = 1;
	end
endmodule

