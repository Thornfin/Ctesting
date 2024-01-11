#include <stdio.h>

int main(void) {
	int n; 
	int f;
	int c = 0;
	int a = 1;
	
	printf("Entree un nombre 0 et 20\n");
			
	scanf("%d", &n);
	
	printf("%d", n);
	if(n < 0){
		
		printf("Le n est trop petit.\n");
		return 1;
	
	}else if(n > 20){
	
		printf("le n est trop grand.\n");

		return 1; 	
	
	}else{
		for(int i = 0;i <= 20; i++){
						

			if(i <= 1){
				f = i;
			}
			
			f = a + c;
			c = a;
			a = f;
			
			
			if( i >= n){
				printf("%d, ", f);
			}				
		
		}	
	
	}
	

}

