#!/usr/local/bin/python3

'''
Kl Divergence code and 
example of assymetry 
# Entropy of X with respect to y
How well y approx x
KL(X||Y) = -Integral(fX(x)*(logfY(x)- logfY(x)) )d(x)

Can be symmetric for example, with norm dists with 
same variance but different means
'''
from scipy.integrate import quad
from scipy.stats import gamma,expon,norm
from scipy import inf


def KL(X,Y,a=0,b=1):

    '''
    distributions X and Y
    '''

    fn = lambda x: -X.pdf(x) * (Y.logpdf(x) -X.logpdf(x))
    fnIntg= quad(fn,a,b)
    return fnIntg

def main():
    
    print(KL(expon,gamma(a=2),a=0,b=inf))
    print(KL(gamma(a=2),expon,a=0,b=inf))
    print(KL(norm(1,1),norm(2,1),a=-inf,b=inf))
    print(KL(norm(2,1),norm(1,1),a=-inf,b=inf))


if __name__=="__main__":
    main()
    
