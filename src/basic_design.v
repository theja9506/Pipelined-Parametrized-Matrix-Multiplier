module just_trying_out_new_things(input [7:0] ain, bin, input [15:0] cin, input clk, reset, enable, output reg [7:0] aout, bout, output reg [15:0] cout);

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      aout <= 0;
      bout <= 0;
      cout <= 0;
    end
    else if (enable) begin
      aout <= ain;
      bout <= bin;
      cout <= cin + (ain * bin);  // normal dot product (one element)
    end
  end

endmodule
