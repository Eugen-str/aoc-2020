#include <stdio.h>

long unsigned int solution1(long unsigned int *numbers, int length){
    for(int i = 0; i < length - 1; ++i){
        for(int j = i + 1; j < length; ++j){
            if(2020 - numbers[i] == numbers[j])
                return numbers[i] * numbers[j];
        }
    }
    return -1;
}

long unsigned int solution2(long unsigned int *numbers, int length){
    for(int i = 0; i < length - 2; ++i){
        for(int j = i + 1; j < length - 1; ++j){
            for(int k = j + 1; k < length; ++k){
                if(numbers[i] + numbers[j] + numbers[k] == 2020)
                    return numbers[i] * numbers[j] * numbers[k];
            }
        }
    }
    return -1;
}

int main(){
    FILE *f = fopen("input.txt", "r");

    long unsigned int input[1024];

    int len = 0;
    do{
        fscanf(f, "%lu", &input[len]);
        len++;
    }while(!feof(f));

    fclose(f);
    printf("Solution 1 : %lu\n", solution1(input, len - 1));
    printf("Solution 2 : %lu\n", solution2(input, len - 1));

    return 0;
}
