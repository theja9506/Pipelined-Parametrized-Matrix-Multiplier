module dot_product_pipelined(input [7:0] a0, a1, a2, b0, b1, b2, input clk, reset, enable, output reg [15:0] result);

  reg en1, en2, en3;
  reg [15:0] cout1, cout2;

  // pipeline enable signals (to sync with each stage)
  always @(posedge clk) begin
    en1 <= enable;
    en2 <= en1;
    en3 <= en2;
  end

  mulnaccum dut1 (.clk(clk), .enable(en1), .reset(reset), .ain(a0), .bin(b0), .cin(16'd0), .cout(cout1));
  mulnaccum dut2 (.clk(clk), .enable(en2), .reset(reset), .ain(a1), .bin(b1), .cin(cout1), .cout(cout2));
  mulnaccum dut3 (.clk(clk), .enable(en3), .reset(reset), .ain(a2), .bin(b2), .cin(cout2), .cout(result));

endmodule
