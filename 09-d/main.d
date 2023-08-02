import std.stdio;
import std.file;
import std.string;
import std.conv;
import std.algorithm.iteration;
import std.algorithm.searching;

ulong solution1(ulong[] input, int preamble){
    for(int pos = preamble; pos < input.length; pos++){
        bool check = false;
        
        for(int i = pos - preamble; i < pos - 1; i++){
            for(int j = i + 1; j < pos; j++){
                if(input[i] + input[j] == input[pos]){
                    check = true;
                }
            }
        }
        if(!check){
            return input[pos];
        }
    }

    return -1;
}

ulong solution2(ulong[] input, ulong target){
    for(int i = 0; i < input.length; i++){
        ulong[] list;
        for(int j = i; sum(list) < target; j++){
            list ~= input[j];
        }
        if(sum(list) == target){
            return minElement(list) + maxElement(list);
        }
    }
    return -1;
}

int main(){
    ulong[] input;
    foreach(line; readText("input.txt").splitLines()){
        input ~= to!ulong(line);
    }

    ulong s1 = solution1(input, 25);
    writeln("Solution 1 : ", s1);
    writeln("Solution 2 : ", solution2(input, s1));
    return 0;
}
