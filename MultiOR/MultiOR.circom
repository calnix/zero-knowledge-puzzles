pragma circom 2.1.8;
include "../node_modules/circomlib/circuits/comparators.circom";

// Write a circuit that returns true when at least one
// element is 1. It should return false if all elements
// are 0. It should be unsatisfiable if any of the inputs
// are not 0 or not 1.

template MultiOR(n) {
    signal input in[n];
    signal output out;


    // constrain inputs to be only 1 or 0
    for (var i = 0; i < n; i++) {
        // in[i] must be either 1 or 0
        in[i] * (1 - in[i]) === 0;
    }

    // transformation
    signal s[n];
    // flip the first
    s[0] <== 1 - in[0];

    // flip term & multiply w/ prev. term
    for(var i = 1; i < n; i++){
        s[i] <== (1 - in[i]) * s[i - 1];
    }

    out <== 1 - s[n-1];
}

component main = MultiOR(4);

/*
Notes on Multi-OR

if you have a series of multiplications, within which there is a 0: x *x *x * 0 * x* x,
the entire series returns 0.

what multi-or is saying is that: x * x * 1 * x * x,
the entire series returns 1. 

     in --> 1 - in
[0,0,0] --> [1,1,1]
[1,1,1] --> [0,0,0]
[1,0,0] --> [0,1,1]   ** 0*1*1 = 0 

if we had at least one `1`, then there will be at least one `0`, upon transformation.
If we multiply the inputs after transformation, we would get 0.

Then if we minus the result from 1, (1-0), we will get 1.

"return 1, if at least 1 of the inputs is 1"

[0,0,0] --> [1,1,1], 1*1*1 = 1. 1-1 = 0
- if we had all inputs as `0`, then they will be transformed to `1`
- multiplying the resulting inputs give us 1
- Then if we minus the result from 1, (1-1), we will get 0.

"return 0, if all the elements are 0."


*/