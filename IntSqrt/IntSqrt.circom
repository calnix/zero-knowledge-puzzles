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

    // if a = 0:
    //          a * a = 0 = b | floor(sqrt(0)) = 0
    //          underflow:  a - 1 = 0 - 1 => p - 1
    /*  
        underflow will occur when in[0] is 0. 
        The check (in[0] - 1) * (in[0] - 1) < in[1], will fail. 

        It will eval to:
            (p - 1) * (p - 1), which is larger in[1].
        
        Remember for in[0] to be 0, the square has to be 0, therefore in[1] = 0.
    */

    // if a = (p - 1):  
    //              meaning a takes the max vaule possible of the module order. e.g. If mod 5, a = 4.
    //              When checking (a + 1)(a + 1) > b:
    //                  (p - 1 + 1)(p - 1 + 1) = p * p > b

    //              However, under mod p, p is 0. Therefore, we are left with: 
    //                  p * p > b => 0 * 0 > b
    //              This would not hold.

    // ** Input vaildation: floor term cannot be 0 or (p-1) **

    signal isItZero;
    isItZero <== IsZero()(in[0]);
    // constraint output of IsZero to be 0.
    // therefore if in[0] cannot be 0.
    isItZero === 0; 

    // in circom, p = 21888242871839275222246405745257275088548364400416034343698204186575808495617
    signal isItMaxRemainder;
    isItMaxRemainder <== IsEqual()([in[0], (21888242871839275222246405745257275088548364400416034343698204186575808495617 - 1)]);
    isItMaxRemainder === 0;

    // (b - 1)(b - 1) < in[1]
    signal inter1;
    signal res1;
    inter1 <-- (in[0] - 1) * (in[0] - 1);   
    // ENSURE THAT (b - 1)(b - 1) < in[1]
    res1 <== LessThan(252)([inter1, in[1]]);
    res1 === 1;

    // (b + 1)(b + 1) > a
    signal inter2;
    signal res2;
    inter2 <-- (in[0] + 1) * (in[0] + 1);
    // ENSURE THAT in[1] < (b + 1)(b + 1)
    res2 <== LessThan(252)([in[1], inter2]);
    res2 === 1;
}

component main = IntSqrt(252);
