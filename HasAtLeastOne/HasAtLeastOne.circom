pragma circom 2.1.8;

// Create a circuit that takes an array of signals `in[n]` and
// a signal k. The circuit should return 1 if `k` is in the list
// and 0 otherwise. This circuit should work for an arbitrary
// length of `in`.

template HasAtLeastOne(n) {
    signal input in[n];
    signal input k;
    signal output out;

    // compare each term against k
    signal s[n];
    for (var i = 0; i < n; i++) {
       s[i] <== IsEqual()([in[i], k]);
    }

    // s[n] is an array of 1 and 0
    // if s[n] contains a 1, return 1 (k exists). else return 0.
    // see MultiOR.circom

    signal m[n];
    m[0] <== 1 - s[0];

    // flip term & multiply w/ prev. term
    for(var i = 1; i < n; i++){
        m[i] <== (1 - s[i]) * m[i - 1];
    }

    out <== 1 - m[n-1];
}

component main = HasAtLeastOne(4);


/*

if k exists in the array, return 1.
else return 0.

---------------------------------------------------------

Alternative method, without use of component:
(this only works if inputs are 1 and 0)

x * y * z = 0
(x -k)(y - k)(z -k) = 0

for RHS to be 0, one of the roots must be equal to k. e.g. x = k.
see intro of lesson 2.

*/