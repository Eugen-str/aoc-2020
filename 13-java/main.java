import java.io.*;
import java.util.*;
import java.util.stream.*;

class Main{
    static int solution1(int timestamp, List<Integer> busIds){
        int minTime = timestamp, smId = 0;

        for(int i = 0; i < busIds.size(); i++){
            int x = busIds.get(i) - timestamp % busIds.get(i);
            if(x < minTime){
                minTime = x;
                smId = busIds.get(i);
            }
        }
        return minTime * smId;
    }

    //Brute force solution, takes way too long for the actual input...
    static long solution2(List<Integer> schedule){
        int x = schedule.get(0);
        for(long ts = 0; ts < Long.MAX_VALUE; ts += x){
            boolean condition = true;
            for(int i = 0; i < schedule.size(); i++){
                if((ts + i) % schedule.get(i) != 0){
                    condition = false;
                    break;
                }
            }
            if(condition)
                return ts;
        }
        return -1;
    }

    public static void main(String[] args) throws IOException{
        try(var file = new BufferedReader(new FileReader("sample.txt"))){
            String[] txtInput = file
                .lines()
                .collect(Collectors.toList())
                .toArray(new String[0]);

            int timestamp = Integer.parseInt(txtInput[0]);
            List<Integer> busIds1 = Arrays
                .stream(txtInput[1].split(","))
                .filter(n -> !n.equals("x"))
                .map(Integer::parseInt)
                .collect(Collectors.toList());

            List<Integer> busIds2 = Arrays
                .stream(txtInput[1].split(","))
                .map(n -> n.equals("x") ? 1 : Integer.parseInt(n))
                .collect(Collectors.toList());

            System.out.println("Solution 1 : " + solution1(timestamp, busIds1));
            System.out.println("Solution 2 : " + solution2(busIds2));
        }
    }
}
