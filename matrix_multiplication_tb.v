module testbench;

  reg clk, reset, enable;
  reg [7:0] A [0:2][0:2], B [0:2][0:2];
  wire [15:0] C [0:2][0:2];

  matrix_mult dut(.clk(clk), .reset(reset), .enable(enable), .a(A), .b(B), .matmul(C));

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, testbench);
  end

  task display_result;
    begin
      $display("C[0][0] = %0d, C[0][1] = %0d, C[0][2] = %0d", C[0][0], C[0][1], C[0][2]);
      $display("C[1][0] = %0d, C[1][1] = %0d, C[1][2] = %0d", C[1][0], C[1][1], C[1][2]);
      $display("C[2][0] = %0d, C[2][1] = %0d, C[2][2] = %0d", C[2][0], C[2][1], C[2][2]);
    end
  endtask

  initial begin
    reset = 1; enable = 0;

    #10 reset = 0;

    // Matrix A
    A[0][0] = 1; A[0][1] = 2; A[0][2] = 3;
    A[1][0] = 4; A[1][1] = 5; A[1][2] = 6;
    A[2][0] = 7; A[2][1] = 8; A[2][2] = 9;

    // Matrix B
    B[0][0] = 9; B[0][1] = 8; B[0][2] = 7;
    B[1][0] = 6; B[1][1] = 5; B[1][2] = 4;
    B[2][0] = 3; B[2][1] = 2; B[2][2] = 1;

    #10 enable = 1;

    #340;

    $display("Final matrix result:");
    display_result();

    $finish;
  end

endmodule
