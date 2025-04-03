module i_s_r(
    input                clk,
    input [DATAIN-1:0]   datain,
    input                empty,
    output               wren,
    output reg           rden,
    output [DATAOUT-1:0] dataout
);

parameter DATAIN = 48;
parameter DATAOUT = 48;

wire [255:0] a;
wire         calcen;
wire         clken;
wire [127:0] vout;
wire [128:0] rout;
wire         calcend;
wire         sqrtidle;

always @(posedge clk) begin
    if (empty == 0) rden <= 1;
    else if (empty==1) rden <= 0;
end

collector uc (
   .clk    (clk),
   .datain (datain),
   .a      (a),
   .clken  (clken),
   .calcen (calcen)
);

isr isr0 (
    .sysclk   (clk),
    .reset_n  (1'b1),
    .din      (a),
    .calcen   (calcen),
    .clken    (clken),
    .vout     (vout),
    .rout     (rout),
    .calcend  (calcend),
    .sqrtidle (sqrtidle)
);

dout ud (
    .clk     (clk),
    .rout    (rout),
    .vout    (vout),
    .calcend (calcend),
    .dataout (dataout),
    .wren    (wren)
);
endmodule
