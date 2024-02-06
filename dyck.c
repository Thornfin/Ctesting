#include <stdio.h>
#include <ctype.h>


void printRectangle(int width, int height) {
    char rectangle[height][width]; // Declare a 2D array (grid)

    // Fill the array with '*'
    for (int i = 0; i < height; i++) {
        for (int j = 0; j < width; j++) {
            rectangle[i][j] = '*';
        }
    }

    // Print the array
   // for (int i = 0; i < height; i++) {
     //   for (int j = 0; j < width; j++) {
       //     printf("%c ", rectangle[i][j]);
       // }
       // printf("\n"); // Newline after each row
   // }
}


int main(int argc, char *argv[]) {
	if(argc != 4){
			printf("Ressayer..."); 		
			return 1; 
	}
	
	
	char lettre1 = *argv[1];
	char lettre2 = *argv[2];  	
	char *mot = argv[3]; 

	char space = '*';

	int counter1 = 0;
	int counter2 = 0;
	
	int size = 0; 

	int counterMax = 0; 

	for(int i = 0; mot[i] != '\0'; i++){
	
			if(mot[i] == lettre1 ){
				if(mot[i] == lettre1 && mot[i - 1] != lettre1 || mot[i] == lettre1 && mot[i + 1] != lettre1 && mot[i + 1] != '\0'){
                                        counter1 = 0;
                                }

				
				counter1++;

				if(mot[i] == mot[i + 1] && counter1 > counterMax ||mot[i] == mot[i - 1] && counter1 > counterMax  ){
					counterMax = counter1;
				}
				size++; 

			}
			
			else if(mot[i] == lettre2){
				
				if(mot[i] == lettre2 && mot[i - 1] != lettre2 || mot[i] == lettre2 && mot[i + 1] != lettre2 && mot[i + 1] != '\0'){
					counter2 = 0; 
				}
				
				counter2++;

				 if(mot[i] == mot[i + 1] && counter2 > counterMax || mot[i] == mot[i - 1] && counter2 > counterMax ){
                                        counterMax = counter2;
                                }

				size++; 
			}

			
	}

	printf("le counter Max est %d  \n",counterMax); 	
	
	printRectangle(size,counterMax); 		

	

	return 0; 

	
}

