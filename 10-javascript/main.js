const fs = require("fs");

function solution1(input){
    let count_one = 0
    let count_three = 0

    for(let i = 0; i < input.length - 1; i++){
        if(input[i] + 1 == input[i + 1]){
            count_one++;
        }
        else if(input[i] + 3 == input[i + 1]){
            count_three++;
        }
    }
    
    return count_one * count_three;
}

//dynamic programming magic
function solution2(input){
    let dp = [];
    dp.push(1);
    
    for (var i = 1; i < input.length; ++i) {
        dp[i] = 0;
        for (var j = i - 1; j >= 0 && input[i] - input[j] <= 3; --j) {
            dp[i] += dp[j];
        }
    }

    return dp.pop();
}

function main(){
    let input = fs.readFileSync("input.txt")
        .toString()
        .trim()
        .split('\n')
        .map(x => {
            return parseInt(x);
        });
    input.push(0);

    input.sort(function(a, b){return a - b})
         .push(input[input.length - 1] + 3);
    
    console.log(`Solution 1 :`, solution1(input));
    console.log(`Solution 2 :`, solution2(input));
}

main()
