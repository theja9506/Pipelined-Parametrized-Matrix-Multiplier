module testbench;

  reg clk, reset, enable;
  reg [7:0] a0, a1, a2;
  reg [7:0] b0, b1, b2;
  wire [15:0] result;

  dot_product_pipelined dut (.clk(clk), .reset(reset), .enable(enable), .a0(a0), .a1(a1), .a2(a2), .b0(b0), .b1(b1), .b2(b2), .result(result));

  initial clk = 0;
  always #5 clk = ~clk;

  initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, testbench);
  end

  initial begin
    $display("time\tenable\ta={a0,a1,a2}\tb={b0,b1,b2}\tresult");
    $monitor("%0t\t%b\t\t{%0d,%0d,%0d}\t{%0d,%0d,%0d}\t%0d", $time, enable, a0, a1, a2, b0, b1, b2, result);
  end

  initial begin
    reset = 1; enable = 0;
    a0 = 0; a1 = 0; a2 = 0; 
    b0 = 0; b1 = 0; b2 = 0;

    #10 reset = 0;

    #10 enable = 1;
    a0 = 8'd1; a1 = 8'd2; a2 = 8'd3;
    b0 = 8'd9; b1 = 8'd6; b2 = 8'd3;

    #10 enable = 0;

    #40 enable = 1;

    #50;
    $display("Final result (should be 30): %0d", result);
    $finish;
  end

endmodule
