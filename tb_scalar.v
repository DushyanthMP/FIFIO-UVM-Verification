// ------------------------------------------------------------
// Tiny testbench
// - Writes some values, reads some back, exercises full/empty.
// - Dumps VCD so you can view in GTKWave (optional).
// ------------------------------------------------------------
module tb;
    parameter DATA_WIDTH = 8;
    parameter ADDR_WIDTH = 3; // DEPTH = 8 for quick test

    logic clk = 0;
    logic rst_n = 0;
    logic wr_en = 0;
    logic [DATA_WIDTH-1:0] wr_data = 0;
    wire wr_full;
    logic rd_en = 0;
    wire [DATA_WIDTH-1:0] rd_data;
    wire rd_empty;
    wire [ADDR_WIDTH:0] occupancy;

    // DUT
    fifo #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) dut (
        .clk(clk), .rst_n(rst_n),
        .wr_en(wr_en), .wr_data(wr_data), .wr_full(wr_full),
        .rd_en(rd_en), .rd_data(rd_data), .rd_empty(rd_empty),
        .occupancy(occupancy)
    );

    // clock 10ns period
    always #5 clk = ~clk;

    // VCD dump
    initial begin
        $dumpfile("fifo_tb.vcd");
        $dumpvars(0,tb);
    end

    integer i;

    initial begin
        $display("\n--- Simple FIFO single-file run ---\n");

        // reset
        rst_n = 0;
        #20;
        rst_n = 1;
        #10;

        // Write 5 items
        $display("Writing 5 items");
        for (i = 1; i <= 5; i = i + 1) begin
            @(negedge clk);
            wr_en = 1;
            wr_data = i;
            @(negedge clk);
            wr_en = 0;
            #1 $display("t=%0t wrote %0d occ=%0d full=%b", $time, wr_data, occupancy, wr_full);
        end

        // Read 3 items
        $display("Reading 3 items");
        for (i = 1; i <= 3; i = i + 1) begin
            @(negedge clk);
            rd_en = 1;
            @(negedge clk);
            rd_en = 0;
            #1 $display("t=%0t read %0d occ=%0d empty=%b", $time, rd_data, occupancy, rd_empty);
        end

        // Simultaneous write+read for 4 cycles
        $display("Simultaneous write+read 4 cycles");
        for (i = 0; i < 4; i = i + 1) begin
            @(negedge clk);
            wr_en = 1; wr_data = 20 + i;
            rd_en = 1;
            @(negedge clk);
            wr_en = 0; rd_en = 0;
            #1 $display("t=%0t wrote=%0d read=%0d occ=%0d", $time, wr_data, rd_data, occupancy);
        end

        // Fill until full
        $display("Fill until full");
        i = 0;
        while (!wr_full) begin
            @(negedge clk);
            wr_en = 1;
            wr_data = 100 + i;
            @(negedge clk);
            wr_en = 0;
            #1 $display("t=%0t wrote %0d occ=%0d full=%b", $time, wr_data, occupancy, wr_full);
            i = i + 1;
            if (i > 50) begin $display("Loop safety break"); break; end
        end

        // Attempt extra write (should not accept)
        @(negedge clk);
        wr_en = 1; wr_data = 8'hFF;
        @(negedge clk);
        wr_en = 0;
        #1 $display("Attempt extra write: occ=%0d full=%b", occupancy, wr_full);

        // Drain FIFO
        $display("Draining FIFO");
        while (!rd_empty) begin
            @(negedge clk);
            rd_en = 1;
            @(negedge clk);
            rd_en = 0;
            #1 $display("t=%0t drained read %0d occ=%0d", $time, rd_data, occupancy);
        end

        $display("\n--- Test finished ---\n");
        #20;
        $finish;
    end
endmodule
