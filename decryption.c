#include <stdio.h>
#include <ctype.h>

int main(int argc, char *argv[]) {
    	
	
		

	

	if (argc != 3) {
        	fprintf(stderr, "Usage: %s <inputfile> <outputfile>\n", argv[0]);
        	return 1;
    	}

    	FILE *inputFile = fopen(argv[1], "r");
    	if (inputFile == NULL) {
        	fprintf(stderr, "Error opening file %s for reading.\n", argv[1]);
        	return 1;
    	}

    	FILE *outputFile = fopen(argv[2], "w");
    	if (outputFile == NULL) {
        	fprintf(stderr, "Error opening file %s for writing.\n", argv[2]);
        	fclose(inputFile);
        	return 1;
    	}

	
	char ch;
	int bond = 3;  

	while((ch = fgetc(inputFile)) != EOF) {

		if (isalpha(ch)){
			
			if (isupper(ch)) {
				
				int calcul = (((ch - 'A') + bond)% 26);
                                char resultat = calcul + 'A';
                                fputc(resultat, outputFile);
				
			} else {			

				int calcul = (((ch - 'a') + bond)% 26); 
				char resultat = calcul + 'a';
				fputc(resultat, outputFile); 	
			
                	}
         
			
		}
			
		
	}

	fclose(inputFile);
	fclose(outputFile);


    	return 0;
}

