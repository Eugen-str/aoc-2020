#include <iostream>
#include <string>
#include <fstream>
#include <vector>

using namespace std;

long long int solution1(string line){
    long long int sum = 0;
    char op = '+';
    int parenCount = 0, parenPos = 0;
    for(int i = 0; i < line.length(); i++){
        char c = line[i];
        if(parenCount != 0 && c != '(' && c != ')'){
			continue;
		}
        switch (c) {
            case '(':
                parenCount++;
                if(parenCount == 1){
                    parenPos = i + 1;
                }
                break;
            case ')':
                parenCount--;
                if(parenCount == 0){
                    int expr = solution1(line.substr(parenPos, i - parenPos));
                    if(op == '+'){
                        sum += expr;
                    }
                    else if(op == '-'){
                        sum -= expr;
                    }
                    else if(op == '*'){
                        sum *= expr;
                    }
                }
                break;
            case ' ':
                continue;
            case '+':
                op = '+';
                break;
            case '-':
                op = '-';
                break;
            case '*':
                op = '*';
                break;
            default:
                if(op == '+'){
                    int x = c - '0';
                    sum += x;
                }
                else if(op == '-'){
                    int x = c - '0';
                    sum -= x;
                }
                else if(op == '*'){
                    int x = c - '0';
                    sum *= x;
                }
                break;
        }
    }
    /*if(parenCount != 0){
        return 0;
    }*/
    return sum;
}

long long int solution2(string line){
    long long int factorSum = 0;
    char op = '+';
    vector<long long int> factors;
    int parenCount = 0, parenPos = 0;
    for(int i = 0; i < line.length(); i++){
        char c = line[i];
        if(parenCount != 0 && c != '(' && c != ')'){
			continue;
		}
        switch (c) {
            case '(':
                parenCount++;
                if(parenCount == 1){
                    parenPos = i + 1;
                }
                break;
            case ')':
                parenCount--;
                if(parenCount == 0){
                    long long int expr = solution2(line.substr(parenPos, i - parenPos));
                    if(op == '+'){
                        factorSum += expr;
                    }
                    else if(op == '-'){
                        factorSum -= expr;
                    }
                }
                break;
            case ' ':
                continue;
            case '+':
                op = '+';
                break;
            case '-':
                op = '-';
                break;
            case '*':
                factors.push_back(factorSum);
                factorSum = 0;
                break;
            default:
                if(op == '+'){
                    int x = c - '0';
                    factorSum += x;
                }
                else if(op == '-'){
                    int x = c - '0';
                    factorSum -= x;
                }
                break;
        }
    }
    factors.push_back(factorSum);
    long long int product = 1;
    for(long long int f : factors){
        product *= f;
    }
    return product;
}

int main(){
    ifstream input("input.txt");
    
    string line;
    long long int result1 = 0, result2 = 0;
    while(getline(input, line)){
        result1 += solution1(line);
        result2 += solution2(line);
    }

    cout << "Solution 1 : " << result1 << endl;
    cout << "Solution 2 : " << result2 << endl;
    return 0;
}
// 290 546 039 947 219
// 290 726 428 573 651
// 9223372036854775807 <- max