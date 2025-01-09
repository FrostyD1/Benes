`timescale 1ns / 1ps
module benes_8_complete_tb;
    reg clk, rst, start;
    reg [2:0] mp0, mp1, mp2, mp3, mp4, mp5, mp6, mp7;
    wire [19:0] state;
    integer file_perm, file_state, scan_file, total_tests, passed_tests;
    reg [19:0] expected_state;
    reg [7:0] line_count;
    
    Benes_8 m2(
        .mp0(mp0),
        .mp1(mp1),
        .mp2(mp2),
        .mp3(mp3),
        .mp4(mp4),
        .mp5(mp5),
        .mp6(mp6),
        .mp7(mp7),
        .state(state),
        .clk(clk),
        .areset(rst),
        .start(start)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #50 clk = ~clk;
    end

    // Test execution
    initial begin
        // Initialize variables
        start = 0;
        rst = 1;
        total_tests = 0;
        passed_tests = 0;
        line_count = 0;
        
        // Open files
        file_perm = $fopen("C:/Users/WDY731208/Benes/permutation.txt", "r");
        file_state = $fopen("C:/Users/WDY731208/Benes/state_matrices.txt", "r");
        
        if (file_perm == 0 || file_state == 0) begin
            $display("Error opening files!");
            $finish;
        end
        
        // Initial reset
        #100 rst = 0;
        
        while (!$feof(file_perm)) begin
            // Read permutation data
            scan_file = $fscanf(file_perm, "%d %d %d %d %d %d %d %d\n",
                              mp0, mp1, mp2, mp3, mp4, mp5, mp6, mp7);
            
            // Read expected state
    scan_file = $fscanf(file_state, "%b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b\n",
                        expected_state[19], expected_state[18], expected_state[17], expected_state[16],
                        expected_state[15], expected_state[14], expected_state[13], expected_state[12],
                        expected_state[11], expected_state[10], expected_state[9], expected_state[8],
                        expected_state[7], expected_state[6], expected_state[5], expected_state[4],
                        expected_state[3], expected_state[2], expected_state[1], expected_state[0]);

            
            line_count = line_count + 1;
            total_tests = total_tests + 1;
            
            // Start the test
            #100 start = 1;
            #100 start = 0;
            
            // Wait for 10 clock cycles
            #1000;
            
            // Verify result
            if (state !== expected_state) begin
                $display("Error at line %d:", line_count);
                $display("Expected state: %h", expected_state);
                $display("Got state: %h", state);
                $display("Input permutation: %d %d %d %d %d %d %d %d",
                        mp0, mp1, mp2, mp3, mp4, mp5, mp6, mp7);
                $display("Current accuracy: %0d%%", (passed_tests * 100) / total_tests);
                $stop;
            end else begin
                passed_tests = passed_tests + 1;
                $display("Test %d passed", line_count);
            end
            
            // Reset for next test
            rst = 1;
            #100 rst = 0;
        end
        
        // Close files
        $fclose(file_perm);
        $fclose(file_state);
        
        // Display final results
        $display("All tests completed!");
        $display("Final accuracy: %0d%%", (passed_tests * 100) / total_tests);
        $display("Total tests: %0d", total_tests);
        $display("Passed tests: %0d", passed_tests);
        $finish;
    end
    
endmodule