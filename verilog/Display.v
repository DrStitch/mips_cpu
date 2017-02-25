`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/02/24 09:26:14
// Design Name: 
// Module Name: Display
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Display(
    input clk,
    input [31:0] numbers,
    output [7:0] digit_Location, digit_States
    );

      function [7:0] numberToDigit;
      input [3:0] number;
        case (number) 
          0: numberToDigit = 8'b00000011;
          1: numberToDigit = 8'b10011111;
          2: numberToDigit = 8'b00100101;
          3: numberToDigit = 8'b00001101;
          4: numberToDigit = 8'b10011001;
          5: numberToDigit = 8'b01001001;
          6: numberToDigit = 8'b01000001;
          7: numberToDigit = 8'b00011111;
          8: numberToDigit = 8'b00000001;
          9: numberToDigit = 8'b00001001;
          10: numberToDigit = 8'b00010001;
          11: numberToDigit = 8'b11000001;
          12: numberToDigit = 8'b01100011;
          13: numberToDigit = 8'b10000101;
          14: numberToDigit = 8'b01100001;
          15: numberToDigit = 8'b01110001;
        endcase
    endfunction
  
  // it shows the location of the number should be shown
    reg [2:0] location_showed = 0;
  // the BCD code of the number should be shown
    wire [3:0] number_showed;
    wire [31:0] number_shift;
  
    assign number_shift = numbers << (location_showed * 4);
    assign number_showed = number_shift[31:28];
    assign digit_Location = ~(8'b10000000 >> location_showed);
    assign digit_States = numberToDigit(number_showed);
  
    always @(posedge clk) begin
      location_showed = location_showed + 1;
    end
endmodule
