#include<stdio.h>
int maze[7][7];
int end[2];
int m, n;
int posspath = 0;;
int dirct[4][2] = {{0, 1}, {0, -1}, {1, 0}, {-1, 0},};
int find_path(int x, int y){
	int nex_x, nex_y;
	int i = 0;
	maze[x][y] = 1;
	if(x==end[0]&&y==end[1]){
		printf("(%d, %d)\n", x, y);
		posspath += 1;
	}
	else{
		for(i=0;i<4;i++){
			nex_x = x + dirct[i][0];
			nex_y = y + dirct[i][1];
			if(pathable(nex_x, nex_y)){
				find_path(nex_x, nex_y);
				maze[nex_x][nex_y] = 0;
				printf("(%d, %d)\n", x, y);
			}	
		}
	}
	return 1;
}
int pathable(int x, int y){
	int flag = 1;
	if(x>=m||y>=n||x<0||y<0){
		flag = 0;
	}
	if(maze[x][y]){
		flag = 0;
	}
	return flag;	
}
 
int main(){
	int i, j;
	int start[2];
	int x, y;
	scanf("%d", &m);
	scanf("%d", &n);
	for(i=0;i<m;i++){
		for(j=0;j<n;j++){
			scanf("%d", &maze[i][j]);
		}
	}
	scanf("%d", &start[0]);
	scanf("%d", &start[1]);
	scanf("%d", &end[0]);
	scanf("%d", &end[1]);
	start[0] = start[0] - 1;
	start[1] = start[1] - 1;
	end[0] = end[0] -1;
	end[1] = end[1] -1;
	for(i=0;i<m;i++){
		for(j=0;j<n;j++){
			printf("%d ", maze[i][j]);
		}
		printf("\n");
	}
	find_path(start[0],start[1]);
	printf("%d", posspath);
	return 0;
}
