#include<stdio.h>

int main()
{
	int A[]={5,1,2,7};
	int B[] = {1,2,7,12,15,16,16,18};

	int size = sizeof(A)/sizeof(int);
	
	int sizeB = sizeof(B)/sizeof(int);
	//int size = 9;
	int i,j,k,flagl=0,count=0;

	


	for(i=0;i<size;i++)
	{	
		count=0;
		flagl=0;

		for(j=0;j<i;j++)/* Making Left Scan in an array before i th element */
		{
			if(A[i]==A[j])
			{
				flagl=1;
			}
		}
		if(flagl==0)  /* Making Right Scan in an array after i th element */
		{ 
					
					for(k=0;k<sizeB;k++)
						if(A[i] == B[k])
							count++;
			
		}

		if(flagl == 0 && count == 0)
		{
			printf("%d\n",A[i]);
		}
	}

}
