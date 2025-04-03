module dout(
    input                    clk,
    input [ROUT-1:0]         rout,
    input [VOUT-1:0]         vout,
    input                    calcend,
    output reg [DATAOUT-1:0] dataout,
    output reg               wren
);

parameter ROUT = 129;
parameter VOUT = 128;
parameter DATAOUT = 48;

reg [15:0] count = 0;

always @(posedge clk) begin
    if (calcend) begin
        if (count == 0) begin
            wren <= 1;
            dataout <= {3'b001, 1'b0, vout[127:84]};
            count <= count + 1;
        end else if (count == 1) begin
            wren <= 1;
            dataout <= {3'b010, 1'b0, vout[83:40]};
            count <= count + 1;
        end else if (count == 2) begin
            wren <= 1;
            dataout <= {3'b011, 1'b0, vout[39:0], 4'b0};
            count <= count + 1;
        end else if (count == 3) begin
            wren <= 1;
            dataout <= {3'b100, 1'b1, rout[128:85]};
            count <= count + 1;
        end else if (count == 4) begin
            wren <= 1;
            dataout <= {3'b101, 1'b1, rout[84:41]};
            count <= count + 1;
        end else if (count == 5) begin
            wren <= 1;
            dataout <= {3'b110, 1'b1, rout[40:0], 3'b0};
            count <= count + 1;
        end else if (count > 5) begin
            wren <= 0;
        end
    end else begin
        wren <= 0;
        count <= 0;
    end
end
endmodule
