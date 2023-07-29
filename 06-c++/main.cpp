#include <iostream>
#include <vector>
#include <string>
#include <unordered_set>
#include <unordered_map>
#include <fstream>

using namespace std;

int solution1(const vector<string>& input){
    unordered_set<char> uniqueChars{};

    for(const string& line: input){
        for(char c: line){
            uniqueChars.insert(c);
        }
    }

    return uniqueChars.size();
}

int solution2(const vector<string>& input){
    unordered_map<char, int> countChars{};
    int result = 0;

    for(const string& line: input){
        for(char c: line){
            countChars[c]++;
        }
    }

    for(const auto& x: countChars){
        if(input.size() == x.second){
            result++;
        }
    }

    return result;
}

int main() {
    ifstream input("input.txt");

    int result1 = 0;
    int result2 = 0;

    string line;
    vector<string> lines{};

    while(getline(input, line)){
        if(!line.empty()){
            lines.push_back(line);
        }
        else{
            result1 += solution1(lines);
            result2 += solution2(lines);
            lines.clear();
        }
    }
    result1 += solution1(lines);
    result2 += solution2(lines);

    cout << "\nSolution 1 : " << result1 << "\n";
    cout << "Solution 2 : " << result2 << "\n\n";

    input.close();
    return 0;
}
