`timescale 1ns / 1ps


module RELAY_MODULE #(
    parameter CLK_FREQ = 50_000_000,        // Clock frequency in Hz
    parameter ON_DURATION_SEC = 2,          // Relay ON time after IR = 0
    parameter DEBOUNCE_MS = 1000              // Debounce duration in milliseconds
)(
    input  wire clk,
    input  wire reset,
    input  wire ir_sensor_raw,              // Raw IR input
    output reg  relay_out
);

    // Derived constants
    localparam DEBOUNCE_COUNT = (CLK_FREQ / 1000) * DEBOUNCE_MS;
    localparam DELAY_COUNT    = CLK_FREQ * ON_DURATION_SEC;

    // Debounce registers
    reg [31:0] debounce_cnt = 0;
    reg ir_sensor_sync      = 0;
    reg ir_sensor_prev      = 0;

    // Relay timer
    reg [31:0] counter = 0;
    reg active         = 0;
    wire ir_pin;
    
 

    // Debounce logic: filters unstable IR signal
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            debounce_cnt   <= 0;
            ir_sensor_sync <= 0;
            ir_sensor_prev <= 0;
        end else begin
            if (ir_sensor_raw != ir_sensor_prev) begin
                debounce_cnt <= 0;
                ir_sensor_prev <= ir_sensor_raw;
            end else if (debounce_cnt < DEBOUNCE_COUNT) begin
                debounce_cnt <= debounce_cnt + 1;
            end else begin
                ir_sensor_sync <= ir_sensor_prev;
            end
        end
    end

    // Main relay control with timer
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            relay_out <= 1;
            counter   <= 0;
            active    <= 0;
        end else begin
            if (ir_sensor_sync) begin
                active    <= 1;
                counter   <= DELAY_COUNT;
                relay_out <= 0;
            end else if (active) begin
                if (counter > 0) begin
                    counter <= counter - 1;
                    relay_out <= 0;
                end else begin
                    active    <= 0;
                    relay_out <= 1;
                end
            end else begin
                relay_out <= 1;
            end
        end
    end

endmodule











/*module relay_module #(
    parameter CLK_FREQ = 50_000_000,       // Clock frequency in Hz
    parameter ON_DURATION_SEC = 2          // Delay after hand removal (in seconds)
)(
    input  wire clk,         // System clock
    input  wire reset,       // Asynchronous reset
    input  wire ir_sensor,   // IR sensor input (active-high)
    output reg  relay_out    // Output to relay module
);

    // Calculating the delay count
    localparam integer DELAY_COUNT = CLK_FREQ * ON_DURATION_SEC;

    reg [15:0] counter;
    reg active;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter    <= 0;
            relay_out  <= 0;
            active     <= 0;
        end
        else begin
            if (ir_sensor) begin
                // IR detected: turn ON relay and reset counter
                active    <= 1;
                counter   <= DELAY_COUNT;
                relay_out <= 1;
            end
            else if (active) begin
                if (counter > 0) begin
                    counter <= counter - 1;
                    relay_out <= 1;
                end else begin
                    // Timeout reached: turn OFF relay
                    active    <= 0;
                    relay_out <= 0;
                end
            end
            else begin
                relay_out <= 0; // Making off
            end
        end
    end

endmodule  */
