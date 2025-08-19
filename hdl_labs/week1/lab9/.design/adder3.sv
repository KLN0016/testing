`timescale 1ns / 1ps

module adder(
    input  logic a,      // First input bit
    input  logic b,      // Second input bit
    input  logic cin,    // Carry-in bit
    output logic sum,    // Sum output
    output logic cout    // Carry-out bit
);
    // Internal wires
    logic xor1_out, and1_out, and2_out, or1_out;
    
    // Gate-level implementation
    nor nor1(xor1_out, a, b);          // a XOR b
    xor xor2(sum, xor1_out, cin);      // (a XOR b) XOR cin
    
    and and1(and1_out, a, b);          // a AND b
    and and2(and2_out, cin, xor1_out); // cin AND (a XOR b)
    
    or  or1(cout, and1_out, and2_out); // (a AND b) OR (cin AND (a XOR b))
endmodule
