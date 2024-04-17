pragma circom 2.1.8;
include "../node_modules/circomlib/circuits/comparators.circom";

/*
Create a circuit that takes private input of 5 variables as an array and a public input k. 
 prove that k is the median of the list without showing the list.  
 That means, you prove the list is sorted (use exercise 1), and that the middle signal equals k. 
 
 Deploy and verify this as a smart contract on whatever chain you prefer and show a transaction that it works.
*/


template HasAtLeastOne() {
    signal input in[5];
    signal input k;
    signal output out;

    //median of 5 is the 3rd term; assuming sorted

    //1. sort array
    
}