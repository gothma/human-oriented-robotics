# Exercise 1: Getting started
All done

# Exercise 2: Vectors and Matrices

## Vectors


    >> cumsum(a)

    ans =

     1     3     6    10    15

    >> diff(b)
    
    ans =
    1
    2
    3
    4
  
## More vector operations

    >> a*a
    Error using  * 
    Inner matrix dimensions must agree.
         
`*` is using matrix multiplication which only works if the number of columns of the first matrix equals to the number of rows of the second matrix

    >> a.*a

    ans =

     1     4     9    16    25

    >> a.^3

    ans =

     1     8    27    64   125
     
    >> a * b

    ans =

        85
        
    >> M = a' * b'

    M =

         0     1     3     6    10
         0     2     6    12    20
         0     3     9    18    30
         0     4    12    24    40
         0     5    15    30    50
         
## Workspaces

    >> whos
    Name      Size            Bytes  Class

    M         5x5               200  double              
    a         1x5                40  double              
    ans       5x5               200  double              
    b         5x1                40  double  
    
## Matrices

    >> M(2,:)

    ans =

         0     2     6    12    20

    >> M(:,4)

    ans =

         6
        12
        18
        24
        30

    >> M(1:2:5,3:5)

    ans =

         3     6    10
         9    18    30
        15    30    50


## Matrix operations
   
    >> inv(M)
    Warning: Matrix is singular to working precision. 

    ans =

       Inf   Inf   Inf   Inf   Inf
       Inf   Inf   Inf   Inf   Inf
       Inf   Inf   Inf   Inf   Inf
       Inf   Inf   Inf   Inf   Inf
       Inf   Inf   Inf   Inf   Inf
       
Die Matrix ist singulär dh. nicht invertierbar. Dies liegt darin, dass die Zeilen- und Spaltenvektoren nicht linear unabhängig sind, was daraus resultiert, dass Zeilen- und Spaltenvektoren Vielfache von `a'` und `b'` sind.
 
## Relational operators
 
    >> M(M > 9) = -1

    M =

         0     1     3     6    -1
         0     2     6    -1    -1
         0     3     9    -1    -1
         0     4    -1    -1    -1
         0     5    -1    -1    -1
         
## Sizes

    >> size(a)

    ans =

         1     5

    >> size(b)

    ans =

         5     1

    >> size(M)

    ans =

         5     5

    >> ones(size(M))

    ans =

         1     1     1     1     1
         1     1     1     1     1
         1     1     1     1     1
         1     1     1     1     1
         1     1     1     1     1
     
    >> randn(size(M))

    ans =

        1.0347    0.8884    1.4384   -0.1022   -0.0301
        0.7269   -1.1471    0.3252   -0.2414   -0.1649
       -0.3034   -1.0689   -0.7549    0.3192    0.6277
        0.2939   -0.8095    1.3703    0.3129    1.0933
       -0.7873   -2.9443   -1.7115   -0.8649    1.1093
       
# Exercise 5

