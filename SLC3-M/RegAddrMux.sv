module RegAddrMux(input logic [15:0]IR,				// for instructions that work with the register files, I tell the mux which bits to use for register addresses
						output logic[2:0]	DR, SR1, SR2);

always_comb
begin
	DR <= 3'b000;
	SR1 <= 3'b000;
	SR2 <= 3'b000;
	case(IR[15:12])
		4'b0001:// ADD
			begin
			DR <= IR[11:9];
			SR1 <= IR[8:6];
			SR2 <= IR[2:0];
			end
		4'b0010:// LD
			begin
			DR <= IR[11:9];
			end
		4'b0011:// ST
			begin
			SR1 <= IR[11:9];
			end
		4'b1010:// MULT
			begin
			DR <= IR[11:9];
			SR1 <= IR[8:6];
			SR2 <= IR[2:0];
			end
		4'b1011:// DIV
			begin
			DR <= IR[11:9];
			SR1 <= IR[8:6];
			SR2 <= IR[2:0];
			end
		4'b1111:// SUB
			begin
			DR <= IR[11:9];
			SR1 <= IR[8:6];
			SR2 <= IR[2:0];
			end
		4'b0101:// AND
			begin
			DR <= IR[11:9];
			SR1 <= IR[8:6];
			SR2 <= IR[2:0];
			end
		4'b1001:// NOT
			begin
			DR <= IR[11:9];
			SR1 <= IR[8:6];
			end
		4'b1100:// JMP
			SR2 <= IR[8:6];
		4'b0100:// JSR
			DR <= 3'b111;
		4'b0110:// LDR
			begin
			DR <= IR[11:9];
			SR2 <= IR[8:6];
			end
		4'b0111:// STR
			begin
			SR1 <= IR[11:9];
			SR2 <= IR[8:6];
			end
		4'b1110: //LEA
			begin
			DR <= IR[11:9];
			end
		default: ;
	endcase
end

endmodule
