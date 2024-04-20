pragma circom 2.1.8;
include "../node_modules/circomlib/circuits/comparators.circom";

// Create a circuit that is satisfied if
// in[0] is the floor of the integer integer
// sqrt of in[1]. For example:
// 
// int[2, 5] accept
// int[2, 5] accept
// int[2, 9] reject
// int[3, 9] accept
//
// If b is the integer square root of a, then
// the following must be true:
//
// (b)(b) = a
// (b - 1)(b - 1) < a
// (b + 1)(b + 1) > a
// 
// be careful when verifying that you 
// handle the corner case of overflowing the 
// finite field. You should validate integer
// square roots, not modular square roots

template IntSqrt(n) {
    signal input in[2];

    // in[0] * in[0] = in[1]
    in[1] === in[0] * in[0];

    // (b - 1)(b - 1) < in[1]
    signal inter1;
    signal res1;
    inter1 <-- (in[0] - 1) * (in[0] - 1);
    
    res1 <== LessThan(252)([inter1, in[1]]);
    res1 === 1;


    // (b + 1)(b + 1) > a
    signal inter2;
    signal res2;
    inter2 <-- (in[0] + 1) * (in[0] + 1);

    res2 <== LessThan(252)([in[1], inter2]);
    res2 === 1;
}

component main = IntSqrt(252);
