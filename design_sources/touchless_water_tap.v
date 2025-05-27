`timescale 1ns / 1ps

module touchless_water_tap (
    input wire clk,
    input wire reset,
    input wire ir_pin,
    output wire relay_out
);

    wire ir_sensor_raw;

    IR_SENSOR sensor_inst (
        .ir_pin(ir_pin),
        .led_out(ir_sensor_raw)
    );

    RELAY_MODULE relay_inst (
        .clk(clk),
        .reset(reset),
        .ir_sensor_raw(ir_sensor_raw),
        .relay_out(relay_out)
    );

endmodule
