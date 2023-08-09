import java.io.*;
import java.util.*;
import java.util.stream.*;

class Main{
    static int solution1(int timestamp, int[] busIds){
        int minTime = timestamp, smId = 0;

        for(int i = 0; i < busIds.length; i++){
            int x = busIds[i] - timestamp % busIds[i];
            if(x < minTime){
                minTime = x;
                smId = busIds[i];
            }
        }
        return minTime * smId;
    }

    //Chinese remainder theorem solution
    public static long solution2(String[] buses) {
        Map<Long, Long> mods = new HashMap<>();
        for(int idx = 0; idx < buses.length; idx++){
            if(!buses[idx].equals("x")){
                long bus = Long.parseLong(buses[idx]);
                mods.put(bus, (bus - idx % bus) % bus);
            }
        }

        long iterator = 0;
        long increment = 1;
        for(long bus: mods.keySet()){
            while (iterator % bus != mods.get(bus)) {
                iterator += increment;
            }
            increment *= bus;
        }
        return iterator;
    }

    public static void main(String[] args) throws IOException{
        try(var file = new BufferedReader(new FileReader("input.txt"))){
            String[] txtInput = file
                .lines()
                .collect(Collectors.toList())
                .toArray(new String[0]);

            int timestamp = Integer.parseInt(txtInput[0]);
            int[] busIds1 = Arrays
                .stream(txtInput[1].split(","))
                .filter(n -> !n.equals("x"))
                .mapToInt(Integer::parseInt)
                .toArray();

            String[] busIds2 = Arrays
                .stream(txtInput[1].split(","))
                .collect(Collectors.toList())
                .toArray(new String[0]);

            System.out.println("Solution 1 : " + solution1(timestamp, busIds1));
            System.out.println("Solution 2 : " + solution2(busIds2));
        }
    }
}
