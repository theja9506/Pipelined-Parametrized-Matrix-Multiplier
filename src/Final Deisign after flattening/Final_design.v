module mulnaccum(input clk, reset, enable, input [7:0] ain, bin, input [15:0] cin, output reg [15:0] cout);

  reg [15:0] mult_res, cdel;

  always @(posedge clk or posedge reset)
    if (reset) begin
      cdel <= 0;
      mult_res <= 0;
    end else if (enable) begin
      mult_res <= ain * bin;
      cdel <= cin;
    end

  always @(posedge clk or posedge reset)
    if (reset) cout <= 0;
    else if (enable) cout <= cdel + mult_res;

endmodule

module dot_product_pipelined #(parameter N = 3, BitWidth = 8)(
  input clk, reset, enable,
  input [BitWidth-1:0] a0, a1, a2,
  input [BitWidth-1:0] b0, b1, b2,
  output wire [2*BitWidth-1:0] result
);

  reg [N-1:0] en;
  integer j;

  always @(posedge clk) begin
    en[0] <= enable;
    for (j = 1; j < N; j = j + 1)
      en[j] <= en[j-1];
  end

  wire [2*BitWidth-1:0] cout[0:N-1];

  mulnaccum mac0(.clk(clk), .reset(reset), .enable(en[0]), .ain(a0), .bin(b0), .cin(0),          .cout(cout[0]));
  mulnaccum mac1(.clk(clk), .reset(reset), .enable(en[1]), .ain(a1), .bin(b1), .cin(cout[0]), .cout(cout[1]));
  mulnaccum mac2(.clk(clk), .reset(reset), .enable(en[2]), .ain(a2), .bin(b2), .cin(cout[1]), .cout(cout[2]));

  assign result = cout[N-1];
endmodule


module matrix_mult #(parameter BitWidth = 8)(
  input clk, reset, enable,
  input [BitWidth-1:0]
    A00, A01, A02,
    A10, A11, A12,
    A20, A21, A22,
    B00, B01, B02,
    B10, B11, B12,
    B20, B21, B22,
  output [2*BitWidth-1:0]
    C00, C01, C02,
    C10, C11, C12,
    C20, C21, C22
);

  dot_product_pipelined #(3, BitWidth) dp00(.clk(clk), .reset(reset), .enable(enable),
    .a0(A00), .a1(A01), .a2(A02),
    .b0(B00), .b1(B10), .b2(B20), .result(C00));

  dot_product_pipelined #(3, BitWidth) dp01(.clk(clk), .reset(reset), .enable(enable),
    .a0(A00), .a1(A01), .a2(A02),
    .b0(B01), .b1(B11), .b2(B21), .result(C01));

  dot_product_pipelined #(3, BitWidth) dp02(.clk(clk), .reset(reset), .enable(enable),
    .a0(A00), .a1(A01), .a2(A02),
    .b0(B02), .b1(B12), .b2(B22), .result(C02));

  dot_product_pipelined #(3, BitWidth) dp10(.clk(clk), .reset(reset), .enable(enable),
    .a0(A10), .a1(A11), .a2(A12),
    .b0(B00), .b1(B10), .b2(B20), .result(C10));

  dot_product_pipelined #(3, BitWidth) dp11(.clk(clk), .reset(reset), .enable(enable),
    .a0(A10), .a1(A11), .a2(A12),
    .b0(B01), .b1(B11), .b2(B21), .result(C11));

  dot_product_pipelined #(3, BitWidth) dp12(.clk(clk), .reset(reset), .enable(enable),
    .a0(A10), .a1(A11), .a2(A12),
    .b0(B02), .b1(B12), .b2(B22), .result(C12));

  dot_product_pipelined #(3, BitWidth) dp20(.clk(clk), .reset(reset), .enable(enable),
    .a0(A20), .a1(A21), .a2(A22),
    .b0(B00), .b1(B10), .b2(B20), .result(C20));

  dot_product_pipelined #(3, BitWidth) dp21(.clk(clk), .reset(reset), .enable(enable),
    .a0(A20), .a1(A21), .a2(A22),
    .b0(B01), .b1(B11), .b2(B21), .result(C21));

  dot_product_pipelined #(3, BitWidth) dp22(.clk(clk), .reset(reset), .enable(enable),
    .a0(A20), .a1(A21), .a2(A22),
    .b0(B02), .b1(B12), .b2(B22), .result(C22));

endmodule
