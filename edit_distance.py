# Uses python3
def edit_distance(s, t):
    #write your code here
    #s="editing"


	sLen,tLen=len(s),len(t)

	DistM = [[0 for x in range(tLen+1)] for y in range(sLen+1)] 

	for i in range(sLen+1):
		DistM[i][0]=i

	for j in range(tLen+1):
		DistM[0][j]=j   


	for j in range(1,(tLen+1)): 
	    for i in range(1,(sLen+1)): 
	        Ins= DistM[i][j-1]+1
	        Del= DistM[i-1][j]+1
	        Mtch= DistM[i-1][j-1]
	        Mis= DistM[i-1][j-1]+1
	        #print(f'i{i} j{j}')
	        if s[i-1]==t[j-1]:
	            DistM[i][j]=min(Ins,Del,Mtch)
	        else:
	            DistM[i][j]=min(Ins,Del,Mis)
	            

	return DistM[sLen][tLen]   

if __name__ == "__main__":
    print(edit_distance(input(), input()))
