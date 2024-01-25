#include <stdio.h>
#include <stdbool.h>
#include <string.h>

bool is_palindrome(char *str) {
    char *left = str;
    char *right = str + strlen(str) - 1;
    while (left < right) {
        if (*left != *right) return false;
        left++;
        right--;
    }
    return true;
}

/**
 * Main function. Checks if the provided argument is a palindrome.
 */
int main(int argc, char *argv[]) {
    if (argc > 1 && is_palindrome(argv[1])) {
        printf("%s\n", argv[1]);
    } else {
        printf(argc == 1 ? "Usage: %s <string>\n" : "?\n", argv[0]);
    }
    return 0;
}

// Donc le programme va de l'addresse memoire du premier charactere au dernier et se promene jusqu au milieu pour savoir si l array contient un palindrome.  
 
