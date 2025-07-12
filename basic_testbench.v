module test_bench_for_fun;

  reg [7:0] ain, bin;
  reg clk, reset, enable;
  reg [15:0] cin;
  wire [15:0] cout;
  wire [7:0] aout, bout;

  just_trying_out_new_things dut (.clk(clk), .reset(reset), .enable(enable), .ain(ain), .bin(bin), .cin(cin), .aout(aout), .bout(bout), .cout(cout));

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, test_bench_for_fun);
  end

  initial begin
    $display("Time\tclk\treset\tenable\tain\tbin\tcin\t|\taout\tbout\tcout");
    $monitor("%0t\t%b\t%b\t%b\t%d\t%d\t%d\t|\t%d\t%d\t%d", $time, clk, reset, enable, ain, bin, cin, aout, bout, cout);
  end

  initial begin
    ain = 0; bin = 0; cin = 0; reset = 0; enable = 1;

    // Test 1
    #10; reset = 0; enable = 1;
    @(posedge clk) begin ain = 1; bin = 1; cin = 1; end

    // Test 2 (with reset)
    #10; reset = 1;
    @(posedge clk) begin ain = 1; bin = 1; cin = 0; end

    // Test 3
    #10; reset = 0;
    @(posedge clk) begin ain = 2; bin = 2; cin = 2; end

    // Test 4
    #10;
    @(posedge clk) begin ain = 0; bin = 3; cin = 1; end

    // Test 5 (enable off)
    #10; enable = 0;
    @(posedge clk) begin ain = 9; bin = 9; cin = 9; end

    #100 $finish;
  end

endmodule
