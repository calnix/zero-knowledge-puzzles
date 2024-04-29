pragma circom 2.1.8;
include "../node_modules/circomlib/circuits/comparators.circom";

// Use the same constraints from IntDiv, but this
// time assign the quotient in `out`. You still need
// to apply the same constraints as IntDiv

template IntDivOut(n) {
    signal input numerator;
    signal input denominator;
    signal output out;

    // compute division
    signal quotient;    
    quotient <-- numerator \ denominator;

    // assign return value to be quotient
    // returning a value only applies from circuit to circuit. not the outside world
    out <== quotient;
}

component main = IntDivOut(252);



/*

Compute then constrain.

    here we are not checking if someone else did division correctly.
    rather, we are executing the division and checking against the provided output.

*/
