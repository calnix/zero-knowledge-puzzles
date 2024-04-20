pragma circom 2.1.8;
include "../node_modules/circomlib/circuits/comparators.circom";

// Create a circuit that is satisfied if `numerator`,
// `denominator`, `quotient`, and `remainder` represent
// a valid integer division. You will need a comparison check, so
// we've already imported the library and set n to be 252 bits.
//
// Hint: integer division in Circom is `\`.
// `/` is modular division
// `%` is integer modulus

template IntDiv(n) {
    signal input numerator;
    signal input denominator;
    signal input quotient;
    signal input remainder;

    // (quotient * divisor) + remainder = dividend
    // num/den = q + r -> num = (q * den) + r

    // constraint forwards
    numerator === (quotient * denominator) + remainder;
    
    // constraint remainders
    signal a;
    a <== LessThan(n)([remainder, denominator]);
    a === 1;
}

component main = IntDiv(252);

/*

the forward constraint on its own is insufficient

why?

a === (q * b) + r

free to submit convenient values of r and a to appease equality.

example:

24 === (3 * 4) + 12
24 === 12 + 12 

Therefore, must constraint r to be less than the dividend/numerator. 
This will result in the shrinking of solution set.

*/