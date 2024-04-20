pragma circom 2.1.8;

// Create a circuit that takes an array of signals `in` and
// returns 1 if all of the signals are 1. If any of the
// signals are 0 return 0. If any of the signals are not
// 0 or 1 the circuit should not be satisfiable.
template MultiAND(n) {
    signal input in[n];
    signal output out;

    // constraint all inputs to be 1 or 0
    for (var i = 0; i < n; i++) {
        // in[i] must be either 1 or 0
        in[i] * (1 - in[i]) === 0;
    }

    // multiply inputs 
    signal s[n];

    s[0] <== in[0];
    for(var i = 1; i < n; i++){
        s[i] <== s[i - 1] * in[i];
    }
  
    // constraint out value to be RHS
    out <== s[n-1];
    
}

component main = MultiAND(4);

// if all the values can only be 1 or 0, then when multiplying them together, we should only get 1 or 0 as output values.
// 1) constraint input values to be 1 or 0
// 2) multiply. if all are 1, output is 1. if there is at least a single zero term, output is zero.




/*
INCORRECT:

- cannot use a for loop to obtain multiplication result

template MultiAND(n) {
    signal input in[n];
    signal output out;

    // constraint all inputs to be 1 or 0
    for (var i = 0; i < n; i++) {
        // in[i] must be either 1 or 0
        in[i] * (1 - in[i]) === 0;
    }

    var collector = 1;
    for (var i = 0; i < n; i++) {
        collector = in[i] * collector;
    }

    // multiply them together
    out <== collector;
}

*/


/*
ALT SOLUTION: NON_GENERAL

template Mul() {
    signal input in[2];
    signal output out;

    out <== in[0] * in[1];
}

template MultiAND(n) {
    signal input in[n];
    signal output out;

    // constraint all inputs to be 1 or 0
    for (var i = 0; i < n; i++) {
        // in[i] must be either 1 or 0
        in[i] * (1 - in[i]) === 0;
    }

    // multiply them together 
    signal a;
    signal b;
    // declare anon component
    a <== Mul()([in[0], in[1]]);
    b <== a * in[2];

    // constraint out value to be RHS
    out <== b * in[3];
    
}


*/