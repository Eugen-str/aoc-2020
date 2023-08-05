#include <stdio.h>
#include <string.h>
#include <stdbool.h>

#define MAX_X 100
#define MAX_Y 100

int count_occupied(char input[][MAX_X], int x, int y){
    int result = 0;
    for(int i = -1; i <= 1; i++){
        for(int j = -1; j <= 1; j++){
            if(input[x+i][y+j] == '#' && x + i >= 0 && y + j >= 0 && !(i == 0 && j == 0)){
                result++;
            }
        }
    }
    return result;
}

bool check_repeat(char first[][MAX_X], char second[][MAX_X], int length){
    for(int i = 0; i < length; i++){
        if(strcmp(first[i], second[i]) != 0){
            return false;
        }
    }

    return true;
}

int solution1(char input[][MAX_X], int length, int line_length){
    char original[MAX_Y][MAX_X];
    int count = 0;
    do{
        for(int i = 0; i < length; i++){
            strcpy(original[i], input[i]);
        }

        for(int i = 0; i < length; i++){
            for(int j = 0; j < line_length; j++){
                if(original[i][j] == 'L' && count_occupied(original, i, j) == 0){
                    input[i][j] = '#';
                }
                if(original[i][j] == '#' && count_occupied(original, i, j) >= 4){
                    input[i][j] = 'L';
                }
            }
        }
    }while(!check_repeat(input, original, length));

    for(int i = 0; i < length; i++){
        for(int j = 0; j < line_length; j++){
            if(input[i][j] == '#')
                count++;
        }
    }
    return count;
}

int main(){
    FILE* fp;
    char input[MAX_Y][MAX_X];
    char buff[MAX_X];

    fp = fopen("input.txt", "r");

    int lines = 0;
    while(fgets(buff, MAX_X, fp) != NULL){
        strcpy(input[lines], buff);
        lines++;
    }

    int line_length = 0;
    while(input[0][line_length + 1] != '\0'){
        line_length++;
    }
    /*
    printf("lines : %d\nline len : %d\n", lines, line_length);
    for(int i = 0; i < lines; i++){
        printf("%s", input[i]);
    }
    */
    printf("Solution 1 : %d\n", solution1(input, lines, line_length));
    return 0;
}
