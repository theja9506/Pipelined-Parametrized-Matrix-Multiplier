module testbench;

  parameter N = 3;
  parameter BitWidth = 8;

  reg clk, enable, reset;
  reg [BitWidth-1:0] A[0:N*N-1], B[0:N*N-1];
  wire [2*BitWidth-1:0] C[0:N*N-1];

  // DUT
  matrix_mult #(N, BitWidth) dut (.clk(clk), .reset(reset), .enable(enable), .A(A), .B(B), .matmul(C));

  // Clock
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Dump
  initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, testbench);
  end

  // Matrix display
  task display_result;
    integer i, j;
    begin
      for (i = 0; i < N; i = i + 1) begin
        for (j = 0; j < N; j = j + 1)
          $write("C[%0d][%0d] = %0d\t", i, j, C[i*N + j]);
        $display();
      end
    end
  endtask

  // Stimulus
  initial begin
    reset = 1;
    enable = 0;
    #12 reset = 0;

    // Matrix A (row-major)
    A[0] = 1;  A[1] = 2;  A[2] = 3;
    A[3] = 4;  A[4] = 5;  A[5] = 6;
    A[6] = 7;  A[7] = 8;  A[8] = 9;

    // Matrix B (row-major)
    B[0] = 9;  B[1] = 8;  B[2] = 7;
    B[3] = 6;  B[4] = 5;  B[5] = 4;
    B[6] = 3;  B[7] = 2;  B[8] = 1;

    #10 enable = 1; // start pipeline

    #400;
    $display("Final matrix result:");
    display_result();

    $finish;
  end

endmodule
