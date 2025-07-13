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
  input [BitWidth-1:0] a[0:N-1], b[0:N-1],
  output wire [2*BitWidth-1:0] result
);

  reg [N-1:0] en;
  integer j;

  // Pipelining the enable signal
  always @(posedge clk) begin
    en[0] <= enable;
    for (j = 1; j < N; j = j + 1)
      en[j] <= en[j-1];
  end

  wire [2*BitWidth-1:0] cout[0:N-1];

  genvar i;
  generate
    for (i = 0; i < N; i = i + 1) begin : mac_chain
      mulnaccum mac (
        .clk(clk), .reset(reset), .enable(en[i]),
        .ain(a[i]), .bin(b[i]),
        .cin((i == 0) ? {2*BitWidth{1'b0}} : cout[i-1]),
        .cout(cout[i])
      );
    end
  endgenerate

  assign result = cout[N-1];

endmodule


module matrix_mult #(parameter N = 3, BitWidth = 8)(
  input clk, reset, enable,
  input [BitWidth-1:0] A[0:N*N-1], B[0:N*N-1],
  output [2*BitWidth-1:0] matmul[0:N*N-1]
);

  genvar i, j;
  generate
    for (i = 0; i < N; i = i + 1) begin : row_loop
      for (j = 0; j < N; j = j + 1) begin : col_loop

        wire [2*BitWidth-1:0] result;
        wire [BitWidth-1:0] a_vec[0:N-1], b_vec[0:N-1];

        // Row from A
        for (genvar k = 0; k < N; k = k + 1)
          assign a_vec[k] = A[i*N + k];

        // Column from B
        for (genvar k = 0; k < N; k = k + 1)
          assign b_vec[k] = B[k*N + j];

        dot_product_pipelined #(N, BitWidth) dp_unit (
          .clk(clk), .reset(reset), .enable(enable),
          .a(a_vec), .b(b_vec), .result(result)
        );

        assign matmul[i*N + j] = result;

      end
    end
  endgenerate

endmodule
