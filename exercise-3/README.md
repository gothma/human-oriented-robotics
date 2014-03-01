# Exercise 3
## Exercise 3.1 Joint Distribution

Proof in 5 steps:

1. Insert first in second formula
2. Remove $$$p(x_K|pa_K)$$$ from the product
3. Factor out the product out of the k-th sum
4. $$$\sum_{x_K}p(x_K|pa_K)$$$ is isolated and can be removed
5. Repeat for all the other sums

## Exercise 3.2

## a)

    A --> B
    |     |
    V     V
    C --> D
    |
    V
    E

### b)

1. $$$p(x_1)p(x_2)p(x_3)p(x_4)p(x_5|x_1, x_2, x_3, x_4)p(x_6|x_2, x_3)p(x_7|x_1, x_3, x_4)p(x_8|x_5,x_6)p(x_9|x_5,x_6,x_7)$$$
2. $$$p(x_1)p(x_2)p(x_3)p(x_4|x_1,x_2,x_3)p(x_5|x_2)p(x_6|x_4,x_5)p(x_7|x_5)p(x_8|x_4,x_5)p(x_9|x_6,x_8)p(x_{10}|x_7,x_8)$$$

## Exercise 3.3

1. No markov chain
2. 2nd order
3. 1st order
4. No markov chain