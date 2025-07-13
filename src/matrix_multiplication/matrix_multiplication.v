module matrix_mult(input clk, reset, enable, input [7:0] a[0:2][0:2], b[0:2][0:2], output [15:0] matmul[0:2][0:2]);

  dot_product_pipelined dp00(.clk(clk), .reset(reset), .enable(enable), .a0(a[0][0]), .a1(a[0][1]), .a2(a[0][2]), .b0(b[0][0]), .b1(b[1][0]), .b2(b[2][0]), .result(matmul[0][0]));
  dot_product_pipelined dp01(.clk(clk), .reset(reset), .enable(enable), .a0(a[0][0]), .a1(a[0][1]), .a2(a[0][2]), .b0(b[0][1]), .b1(b[1][1]), .b2(b[2][1]), .result(matmul[0][1]));
  dot_product_pipelined dp02(.clk(clk), .reset(reset), .enable(enable), .a0(a[0][0]), .a1(a[0][1]), .a2(a[0][2]), .b0(b[0][2]), .b1(b[1][2]), .b2(b[2][2]), .result(matmul[0][2]));

  dot_product_pipelined dp10(.clk(clk), .reset(reset), .enable(enable), .a0(a[1][0]), .a1(a[1][1]), .a2(a[1][2]), .b0(b[0][0]), .b1(b[1][0]), .b2(b[2][0]), .result(matmul[1][0]));
  dot_product_pipelined dp11(.clk(clk), .reset(reset), .enable(enable), .a0(a[1][0]), .a1(a[1][1]), .a2(a[1][2]), .b0(b[0][1]), .b1(b[1][1]), .b2(b[2][1]), .result(matmul[1][1]));
  dot_product_pipelined dp12(.clk(clk), .reset(reset), .enable(enable), .a0(a[1][0]), .a1(a[1][1]), .a2(a[1][2]), .b0(b[0][2]), .b1(b[1][2]), .b2(b[2][2]), .result(matmul[1][2]));

  dot_product_pipelined dp20(.clk(clk), .reset(reset), .enable(enable), .a0(a[2][0]), .a1(a[2][1]), .a2(a[2][2]), .b0(b[0][0]), .b1(b[1][0]), .b2(b[2][0]), .result(matmul[2][0]));
  dot_product_pipelined dp21(.clk(clk), .reset(reset), .enable(enable), .a0(a[2][0]), .a1(a[2][1]), .a2(a[2][2]), .b0(b[0][1]), .b1(b[1][1]), .b2(b[2][1]), .result(matmul[2][1]));
  dot_product_pipelined dp22(.clk(clk), .reset(reset), .enable(enable), .a0(a[2][0]), .a1(a[2][1]), .a2(a[2][2]), .b0(b[0][2]), .b1(b[1][2]), .b2(b[2][2]), .result(matmul[2][2]));

endmodule
