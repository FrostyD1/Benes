module priorityEncoder_tb;
  reg [3:0] in1;
  wire [1:0] value;
  

  Priority_4_Encoder u1(
    .in1(in1),
    .value(value)
  );
  
  initial begin
    // 波形输出



    in1 = 4'b0000; #10;
    in1 = 4'b0001; #10;
    in1 = 4'b0010; #10;
    in1 = 4'b0011; #10;
    in1 = 4'b0100; #10;
    in1 = 4'b0101; #10;
    in1 = 4'b0110; #10;
    in1 = 4'b0111; #10
    in1 = 4'b1000; #10;
    in1 = 4'b1001; #10;
    in1 = 4'b1010; #10;
    in1 = 4'b1011; #10;
    in1 = 4'b1100; #10;
    in1 = 4'b1101; #10;
    in1 = 4'b1110; #10;
    in1 = 4'b1111; #10
    
        
    $finish;
  end
  
  // 输出结果�??�??
  initial begin
    $monitor("Time=%0t in1=%b value=%b", $time, in1, value);
  end
  endmodule