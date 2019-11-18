package algorithms;

import java.util.ArrayList;
import java.util.List;

// 一个string. string里每个character代表一个movie shot, 要把这些character做partition
// 组成一个movie scene, 要求每个partition里的character 只能在这个partition里出现。比如说.
// "abacdfeffhijkik"
// 我们可以分成三份 "abacd | feffh | ijkik"
// 输出是每个partition的size组成的list.
// 这题可以遍历一次string用一个map记录每个character出现的次数。重新遍历 一次string,
// 用target sum记录当前partition里所有character应该出现的总次数， 如果当前的character是第一次出现，
// 就把 target sum加上对应char出现的次数，同时用begin和end记录当前的partition, 如果partition的size
// 等于target sum 就算找到 一个partition.


public class Distinct_Subsequence_Partition {
    public static void main(String[] args) {
        Distinct_Subsequence_Partition testInstance = new Distinct_Subsequence_Partition();
        String l = "abacdfeffhijkik";
//        String l = "abacdfeff";
        List<String> result = testInstance.partitions(l);
        System.out.println(result);
    }


    boolean isPartition(String partition, String rest) {
        for (int i = 0; i < partition.length(); i++) {
            if (rest.indexOf(partition.charAt(i)) >= 0) {
                return false;
            }
        }
        return true;
    }

    int nextPartition(String list) {
        if (list.length() == 1) {
            return 0;
        }
        for (int i = 0; i <= list.length() - 3; i++) {
            if (isPartition(list.substring(0, i + 1), list.substring(i + 1, list.length())) &&
                    !isPartition(list.substring(0, i + 2), list.substring(i + 2, list.length()))) {
                return i;
            }
        }
        if (isPartition(list.substring(0, list.length() - 1), list.substring(list.length() - 1, list.length()))) {
            return list.length() - 2;
        }
        return list.length() - 1;
    }

    List<String> partitions(String list) {
        int nextPartitionPoint = nextPartition(list);
        if (nextPartitionPoint == list.length() - 1) {
            ArrayList<String> result = new ArrayList<>();
            result.add(list);
            return result;
        }
        else {
            List<String> result = new ArrayList<>();
            result.add(list.substring(0, nextPartitionPoint + 1));
            List<String> rest = partitions(list.substring(nextPartitionPoint + 1, list.length()));
            for (String s: rest) {
                result.add(s);
            }
            return result;
        }
    }
}
