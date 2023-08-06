#include <stdio.h>
#include <string.h>
#include <stdbool.h>

#define MAX_X 100
#define MAX_Y 100

int lines;
int line_length;

int count_result(char input[][MAX_X]){
    int count = 0;

    for(int i = 0; i < lines; i++){
        for(int j = 0; j < line_length; j++){
            if(input[i][j] == '#')
                count++;
        }
    }

    return count;
}

bool check_repeat(char first[][MAX_X], char second[][MAX_X]){
    for(int i = 0; i < lines; i++){
        if(strcmp(first[i], second[i]) != 0){
            return false;
        }
    }

    return true;
}

int count_occupied_1(char input[][MAX_X], int x, int y){
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

int solution1(char input[][MAX_X]){
    char original[MAX_Y][MAX_X];

    do{
        for(int i = 0; i < lines; i++){
            strcpy(original[i], input[i]);
        }

        for(int i = 0; i < lines; i++){
            for(int j = 0; j < line_length; j++){
                if(original[i][j] == 'L' && count_occupied_1(original, i, j) == 0){
                    input[i][j] = '#';
                }
                if(original[i][j] == '#' && count_occupied_1(original, i, j) >= 4){
                    input[i][j] = 'L';
                }
            }
        }
    }while(!check_repeat(input, original));

    return count_result(input);
}

int count_occupied_2(char input[][MAX_X], int x, int y){
    int count = 0;
    int directions[8][2] = {{1,1}, {-1, -1}, {1, -1}, {-1, 1}, {0, 1}, {0, -1}, {1, 0}, {-1, 0}};

    for(int d = 0; d < 8; d++){
        int i = x + directions[d][0];
        int j = y + directions[d][1];
        while(i >= 0 && i <= lines && j >= 0 && j <= line_length){
            if(input[i][j] == '#'){
                count++;
                break;
            }
            else if(input[i][j] == 'L'){
                break;
            }
            i+= directions[d][0];
            j+= directions[d][1];
        }
    }

    return count;
}

int solution2(char input[][MAX_X]){
    char original[MAX_Y][MAX_X];

    do{
        for(int i = 0; i < lines; i++){
            strcpy(original[i], input[i]);
        }

        for(int i = 0; i < lines; i++){
            for(int j = 0; j < line_length; j++){
                if(original[i][j] == 'L' && count_occupied_2(original, i, j) == 0){
                    input[i][j] = '#';
                }
                if(original[i][j] == '#' && count_occupied_2(original, i, j) >= 5){
                    input[i][j] = 'L';
                }
            }
        }
    }while(!check_repeat(input, original));

    return count_result(input);
}

int main(){
    FILE* fp;
    char input[MAX_Y][MAX_X];
    char buff[MAX_X];

    fp = fopen("input.txt", "r");

    lines = 0;
    while(fgets(buff, MAX_X, fp) != NULL){
        strcpy(input[lines], buff);
        lines++;
    }

    line_length = 0;
    while(input[0][line_length + 1] != '\0'){
        line_length++;
    }

    char input_copy[MAX_Y][MAX_X];
    for(int i = 0; i < lines; i++){
        strcpy(input_copy[i], input[i]);
    }

    printf("Solution 1 : %d\n", solution1(input_copy));
    printf("Solution 2 : %d\n", solution2(input));
    return 0;
}
