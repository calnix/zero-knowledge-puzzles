pragma circom 2.1.8;
include "../node_modules/circomlib/circuits/comparators.circom";

// Write a circuit that constrains the 4 input signals to be
// sorted. Sorted means the values are non decreasing starting
// at index 0. The circuit should not have an output.

template IsSorted() {
    signal input in[4];

    signal a;
    a <== GreaterEqThan(2)([in[0], in[1]]);

    signal b;
    b <== GreaterEqThan(2)([in[1], in[2]]);

    signal c;
    c <== GreaterEqThan(2)([in[2], in[3]]);

    // why constaint to 1?
    a === 1;
    b === 1;
    a === 1;
}

component main = IsSorted();


/*
Is the list sorted: compare each item's neighbors.
How to generalise this?

*/