#include<stdio.h>
int n;
int state[7], array[7];
void fullarray(int index){
	int i;
	if(index>=n){
		for(i=0;i<n;i++){
			printf("%d ", array[i]);
		}
		printf("\n");
	}
	else{
		for(i=0;i<n;i++){
			if(state[i]==0){
				array[index]=i+1;
				state[i]=1;
				fullarray(index+1);
				state[i]=0;
			}
		}
	}
	return;
}
int main(){
	scanf("%d", &n);
	fullarray(0);
	return 0;
}
