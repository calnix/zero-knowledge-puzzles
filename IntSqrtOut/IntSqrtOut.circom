pragma circom 2.1.8;
include "../node_modules/circomlib/circuits/comparators.circom";

// Be sure to solve IntSqrt before solving this 
// puzzle. Your goal is to compute the square root
// in the provided function, then constrain the answer
// to be true using your work from the previous puzzle.
// You can use the Bablyonian/Heron's or Newton's
// method to compute the integer square root. Remember,
// this is not the modular square root.


function intSqrtFloor(n) {
    // compute the floor of the
    // integer square root of x

    // how to revert if n = 0 ?
    if (n < 0) { return 0}

    // Starting point: Assuming the sqrt of n is n only 
    var x;
    x = n;

    var root;
    while (true) {
        
        // Calculate more closed x 
        root = 0.5 * (x + (n / x)) 
 
        // Check for closeness 
        if (root - x < l) {return x}
        if (x - root < l) {return x}

        // Update root 
        x = root
 
        return root  
    }

}

template IntSqrtOut(n) {
    signal input in;
    signal output out;

    out <-- intSqrtFloor(x);
    // constrain out using your
    // work from IntSqrt


}

component main = IntSqrtOut(252);


/*
    In IntSqrt we were given both the square root and the original value.
    
    In IntSqrtOut, we are only given the original value. 
    We need to 

*/