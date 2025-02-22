module tb_multiplierbinary;

    // Declare inputs as reg type
    reg ldA, ldQ, clrA, ldM, clrQ, clrff, sftA, sftQ, addsub, decr, ldcnt, clk, start;
    reg [15:0] data_in;
    
    // Declare outputs as wire type
    wire qm1, eqz, done;

    // Instantiate the multiplierbinary module
    multiplierbinary uut (
        .ldA(ldA), .ldQ(ldQ), .clrA(clrA), .ldM(ldM), .clrQ(clrQ), .clrff(clrff),
        .sftA(sftA), .sftQ(sftQ), .addsub(addsub), .decr(decr), .ldcnt(ldcnt),
        .data_in(data_in), .clk(clk), .qm1(qm1), .eqz(eqz)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;  // Clock period of 10 time units (50MHz)
    end

    // Test stimulus
    initial begin
        // Initialize signals
        clk = 0;
        ldA = 0;
        ldQ = 0;
        clrA = 0;
        ldM = 0;
        clrQ = 0;
        clrff = 0;
        sftA = 0;
        sftQ = 0;
        addsub = 0;
        decr = 0;
        ldcnt = 0;
        start = 0;
        data_in = 16'b0;

        // Apply reset and start signal
        #10;
        clrA = 1;
        clrQ = 1;
        clrff = 1;
        start = 1;
        #10;
        clrA = 0;
        clrQ = 0;
        clrff = 0;

        // Test case: Multiplying 3 (data_in = 16'd3) and 5 (M = 16'd5)
        data_in = 16'd3;  // Load 3 into the multiplier
       #10;
        data_in = 16'd5;  // Load 5 into the multiplicand
       qm1=1;

        // Start multiplication
        start = 1;
        ldcnt=1;
        decr=1;
        #10;
        
        
        // Wait for multiplication to complete
        #100;

        // Check the result (The expected result is 3 * 5 = 15)
        #10;
        $display("Multiplying 3 and 5");
        $display("Output qm1 = %b, eqz = %b, done = %b", qm1, eqz, done);
        
        // Observe result after a few cycles
        #10;
        $display("Expected output: 15");

        // End the simulation
        $finish;
    end
endmodule
