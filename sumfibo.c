#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
	
	if(argc != 2){
		printf("error: Exactly one argument must be provided\n");
		return 1;
	}
		
	char *endptr;
   	long n = strtol(argv[1], &endptr, 10);

	if (endptr == argv[1] || *endptr != '\0') {
    		fprintf(stderr, "error: The argument must be an integer between 0 and 20\n");
    		return 1;
	}

	// For out-of-range input
	if (n < 0 || n > 20) {
    		fprintf(stderr, "error: The argument must be an integer between 0 and 20\n");
    		return 1;
	}
	
	if(n >= 0 && n <= 20){
		
		int f = 0;
		int a = 1; 
		int next;
		int sum = 0;

		for(int i = 0; i <= n; i++){
			if(i > 0){
				sum += f;
			}
			
			if(n == f){
				printf("%d", f);
				return 0;
			}else if(n == a){
				printf("%d", a);
				return 0;
			}

			next = a + f;
			f = a;
			a = next;

		}

		printf("%d", sum);
		return 0;
	}else{
		printf("error: the argument must be an integer between 0 and 20.\n");
		return 1;
	}	

}

