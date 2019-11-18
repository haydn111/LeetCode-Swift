package algorithms;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;

public class LC140_Word_Break_II {

//    Given a non-empty string s and a dictionary wordDict containing a list of non-empty words, add spaces in s to
//    construct a sentence where each word is a valid dictionary word. You may assume the dictionary does not contain
//    duplicate words. Return all such possible sentences.
//
//    For example, given
//    s = "catsanddog",
//    dict = ["cat", "cats", "and", "sand", "dog"].
//    A solution is ["cats and dog", "cat sand dog"].

    HashMap<String, List<String>> solved = new HashMap<>(); // store solved string and avoid rework on same string.

    public List<String> wordBreak(String s, List<String> wordDict) {
        HashSet<String> dict = new HashSet<>();
        for (String str: wordDict) {
            dict.add(str);
        }

        return wordBreakHelper(s, dict);
    }

    List<String> wordBreakHelper(String s, HashSet<String> dict) {
        if (solved.containsKey(s)) {
            return solved.get(s);
        }
        if (s.length() == 0) {
            return null;
        }

        List<String> result = new ArrayList<>();
        for (int i = 0; i < s.length(); i ++) {
            String first = s.substring(0, i + 1);
            if (dict.contains(first)) {
                String rest = s.substring(i + 1, s.length());
                List<String> partialRes = wordBreakHelper(rest, dict);
                if (partialRes == null) {
                    result.add(first);
                }
                else {
                    for (String str: partialRes) {
                        result.add(first + " " + str);
                    }
                }
            }
        }
        solved.put(s, result);
        return result;
    }

    public static void main(String args[]) {
        LC140_Word_Break_II testInstance = new LC140_Word_Break_II();
        String s = "abcdef";
        List<String> dict = List.of("ab", "cd", "ef", "bcd", "abcd", "cdef", "def", "abcdef");
        System.out.println(testInstance.wordBreak(s, dict));
    }
}
