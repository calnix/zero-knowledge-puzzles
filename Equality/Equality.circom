pragma circom 2.1.4;

// Input 3 values using 'a'(array of length 3) and check if they all are equal.
// Return using signal 'c'.

template IsZero() {

  signal input in;
  signal output out;

  signal inv;

  inv <-- in != 0 ? 1/in : 0;

  out <== -in*inv +1;
  in*out === 0;

}

template Equality() {
   // Your Code Here..
   
   signal input a[3];  
   signal output out;

   signal inter;


   
   component isz = IsZero();
   //if equal: a + b == 2c
   //inter is 0 or someValue

   isz.in <== a[2] + a[1] - (a[0] * 2);

   out <== isz.out;
      

}

// out = 1, if equal

component main = Equality();

/*
a,b,c could be equidistant
   a----b----c

such tt b - a == c - b, when a !+ b != c

therefore, cannot do the following:
   isZero <== (a -b -c)
 
 will result in false positive.


*/


/*
template Equality() {
   // Your Code Here..
   
   signal input a[3];  
   signal output c;

   signal inter;


   component isz = IsZero();
   component isz2 = IsZero();

   // assign and constraint
   // if equal, diff shld be 0
   isz.in <== a[2] - a[1];

   isz2.in <== a[2] - a[0] + isz.out;

   c <== isz2.out;

}

*/