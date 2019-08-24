package algorithms;

import java.util.HashSet;
import java.util.List;

public class LC139_Word_Break {
// Given a non-empty string s and a dictionary wordDict containing a list of non-empty words, determine if s can be
// segmented into a space-separated sequence of one or more dictionary words. You may assume the dictionary does not
// contain duplicate words.
//
//    For example, given
//    s = "leetcode",
//    dict = ["leet", "code"].
//
//    Return true because "leetcode" can be segmented as "leet code".

    // DP
    // 1. State: a boolean [n + 1] array. [i] means if substring of first i characters is true
    // 2. Init: [0] = true. String of nothing is in dictionary.
    // 3. Function: let j: 0 -> i - 1. [i] = true if [0, j] is true and [j, i] is in dictionary
    static boolean wordBreak(String s, List<String> wordDict) {
        if (s == null || wordDict == null) {
            return false;
        }

        // use a HashSet to remove duplicated dictionary words.
        HashSet<String> dict = new HashSet<>();
        for (String str: wordDict) {
            dict.add(str);
        }

        boolean[] dp = new boolean[s.length() + 1];
        dp[0] = true;
        for (int i = 1; i <= s.length(); i++) {
            for (int j = 0; j < i; j++) {
                String subS = s.substring(j, i);
                dp[i] = dp[j] && dict.contains(subS);
                if (dp[i]) {
                    break;
                }
            }
        }
        return  dp[s.length()];
    }

    // Use recursion
    static boolean recursion(String s, List<String> wordDict) {
        if (s == null || wordDict == null) {
            return false;
        }

        if (wordDict.contains(s)) {
            return true;
        }

        for (int i = 1; i < s.length(); i++) {
            String first = s.substring(0, i + 1);
            if (wordDict.contains(first)) {
                String rest = s.substring(i + 1, s.length());
                if (recursion(rest, wordDict)) {
                    return true;
                }
            }
        }
        return false;
    }

    public static void main(String args[]) {
        System.out.println(wordBreak("leetcode", List.of("leet", "code")));
        System.out.println(recursion("leetcode", List.of("leet", "code")));
    }
}
