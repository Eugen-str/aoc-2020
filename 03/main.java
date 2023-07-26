import java.io.*;
import java.util.*;
import java.util.stream.*;

class Main{
    static int solution(String[] input, int dx, int dy){
        int result = 0;
        int x = 0;
        int count = 0;

        for(String line: input){
            if(line.charAt(x % line.length()) == '#' && (count % dy == 0)){
                result++;
            }
            if(count % dy == 0){
                x += dx;
            }

            count++;
        }
        return result;
    }

    static int solution1(String[] input){
        return solution(input, 3, 1);
    }

    static long solution2(String[] input){
        int[][] slopes = {
            {1, 1},
            {3, 1},
            {5, 1},
            {7, 1},
            {1, 2},
        };

        long result = 1;
        for(int[] slope: slopes){
            result *= solution(input, slope[0], slope[1]);
        }

        return result;
    }

    public static void main(String[] args) throws IOException{
        var path = "input.txt";

        String[] input = null;
        try(var file = new BufferedReader(new FileReader(path))){
            input = file
                .lines()
                .collect(Collectors.toList())
                .toArray(new String[0]);
        }

        System.out.println(solution2(input));
    }
}
