#include<stdio.h>
int main(){
	int a[1001] = {0};
	a[0] = 1;
	int n;
	int k;
	int i;
	scanf("%d", &n); 
	int cnt = 0;
	for(i=2;i<=n;i++){
		int c_in = 0;
		int tem = 0;
		int j = 0;
		int m = 1000;
		while(!a[m--]);
		printf("%d\n", m);
		while(j<m+3){
			tem = c_in;
			c_in = (a[j]*i + c_in)/10;
			a[j] = (a[j]*i + tem)%10;
			j++;
		}		 	
	}
	    k = 1001;
		while(!a[k]){
			k--;
		}
		while(k>=0){
			printf("%d",a[k]);
			k--;
		}
	return 0;
}
