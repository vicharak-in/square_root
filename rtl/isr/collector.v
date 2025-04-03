module collector (
    input                     clk,
    input [DATAIN-1:0]        datain,
    output reg [DATA_WID-1:0] a,
    output reg                clken,
    output reg                calcen
);

parameter DATA_WID = 256;
parameter DATAIN = 48;

reg [2:0] packet;
reg lastpacket;
reg [43:0] data;

always @(posedge clk) begin
    packet <= datain[47:45];
    lastpacket <= datain[44];
    data <= datain[43:0];
    
    if (packet == 1) begin
        a[255:212] <= data;
        clken <= 1;
        calcen <= 0;
    end else if (packet == 2) begin
        a[211:168] <= data;
        clken <= 1;
        calcen <= 0;
    end else if (packet == 3) begin
        a[167:124] <= data;
        clken <= 1;
        calcen <= 0;
    end else if (packet == 4) begin
        a[123:80] <= data;
        clken <= 1;
        calcen <= 0;
    end else if (packet == 5) begin
        a[79:36] <= data;
        clken <= 1;
        calcen <= 0;
    end else if (packet == 6) begin
        a[35:0] <= data[43:8];
        clken <= 1;
        if (lastpacket == 1) begin
            calcen <= 1;
        end
    end
end
endmodule
