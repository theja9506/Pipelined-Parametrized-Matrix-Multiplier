module testbench;

  parameter BitWidth = 8;

  reg clk, enable, reset;

  // Flattened inputs for 3x3 matrix A and B
  reg [BitWidth-1:0]
    A00, A01, A02,
    A10, A11, A12,
    A20, A21, A22,
    B00, B01, B02,
    B10, B11, B12,
    B20, B21, B22;

  // Flattened output matrix C
  wire [2*BitWidth-1:0]
    C00, C01, C02,
    C10, C11, C12,
    C20, C21, C22;

  // DUT
  matrix_mult #(BitWidth) dut (
    .clk(clk), .reset(reset), .enable(enable),
    .A00(A00), .A01(A01), .A02(A02),
    .A10(A10), .A11(A11), .A12(A12),
    .A20(A20), .A21(A21), .A22(A22),
    .B00(B00), .B01(B01), .B02(B02),
    .B10(B10), .B11(B11), .B12(B12),
    .B20(B20), .B21(B21), .B22(B22),
    .C00(C00), .C01(C01), .C02(C02),
    .C10(C10), .C11(C11), .C12(C12),
    .C20(C20), .C21(C21), .C22(C22)
  );

  // Clock
  initial begin
    clk = 0;
    forever #5 clk = ~clk;  // 10ns clock
  end

  // Dump for GTKWave
  initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, testbench);
  end

  // Print result matrix
  task display_result;
    begin
      $display("Result matrix:");
      $display("%0d %0d %0d", C00, C01, C02);
      $display("%0d %0d %0d", C10, C11, C12);
      $display("%0d %0d %0d", C20, C21, C22);
    end
  endtask

  // Input stimulus
  initial begin
    reset = 1;
    enable = 0;
    #12 reset = 0;

    // Matrix A (row-major)
    A00 = 1;  A01 = 2;  A02 = 3;
    A10 = 4;  A11 = 5;  A12 = 6;
    A20 = 7;  A21 = 8;  A22 = 9;

    // Matrix B (row-major)
    B00 = 9;  B01 = 8;  B02 = 7;
    B10 = 6;  B11 = 5;  B12 = 4;
    B20 = 3;  B21 = 2;  B22 = 1;

    #10 enable = 1;

    #400;
    display_result();
    $finish;
  end

endmodule
