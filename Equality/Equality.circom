pragma circom 2.1.4;

// Input 3 values using 'a'(array of length 3) and check if they all are equal.
// Return using signal 'c'.
// Return 1 if equal, 0 is not equal.

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

   component isz1 = IsZero();
   component isz2 = IsZero();
   component isz3 = IsZero();

   // IsZero returns 1 if equal. 0 if not equal
   a[0] - a[1] ==> isz1.in;
   a[1] - a[2] ==> isz2.in;
   a[0] - a[2] ==> isz3.in;

   // if diff non-zero -> not equal
   // can i just use assign to inter and out? all the necessary constraints are above anw
   inter <== isz1.out * isz2.out; 
   out <== inter * isz3.out;
      
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

cannot do a + b == 2c, since a,b,c could be distinct but honor the equality
E.g.
   a + b == 2c          (mod 7)
   3 + 4 == 2(4)
       8 == 8           (mod 7)

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

/*
   signal input a[3];  
   signal output out;
   var x = 1;

   //component isz1 = IsZero();
   //component isz2 = IsZero();
   //component isz3 = IsZero();

   // if all 3 diff = 0 -> equal 
   a[0] - a[1] === 0;
   a[1] - a[2] === 0;
   a[0] - a[2] === 0;

   // if diff non-zero -> not equal
   if((a[0] - a[1]) > 0){
      x = 0;
   }
   
   if((a[1] - a[2]) > 0){
      x = 0;
   }

   if((a[0] - a[2]) > 0){
      x = 0;
   }

  out <-- x;
*/