package algorithms;

// Given a string s, find the longest palindromic substring in s. You may assume that the maximum length of s is 1000.

// Example:
// Input: "babad"
// Output: "bab"
// Note: "aba" is also a valid answer.

// Example:
// Input: "cbbd"
// Output: "bb"

public class LC5_Longest_Palindromic_Substring {

    // DP: time = O(n^2), space = O(n^2)
    public String longestPalindrome_dp(String s) {
        if (s == null || s.length() <= 1) {
            return s;
        }

        String solution = "";
        boolean[][] dp = new boolean[s.length()][s.length()];

        for (int j = 0; j < s.length(); j++) {
            for (int i = 0; i <=j; i++) {
                dp[i][j] = s.charAt(i) == s.charAt(j) && ((j - i <= 2) || dp[i + 1][j - 1]);
                if (dp[i][j] && j - i + 1 > solution.length()) {
                    solution = s.substring(i, j + 1);
                }
            }
        }
        return solution;
    }

    // 中心扩散: time = O(n^2), space = O(1)
    public String longestPalindrome_2(String s) {
        if (s == null || s.length() <= 1) {
            return s;
        }
        String solution = "";

        for (int i = 0; i < s.length(); i++) {
            String s1 = helper(s, i, i);     // odd length palindrome
            String s2 = helper(s, i, i + 1); // even length palindrome
            String s3 = s1.length() >= s2.length() ? s1 : s2;
            if (s3.length() > solution.length()) {
                solution = s3;
            }
        }
        return solution;
    }

    private String helper(String s, int left, int right) {
        String currentSubstring = "";
        while (left >= 0 && right < s.length() && s.charAt(left) == s.charAt(right)) {
            currentSubstring = s.substring(left, right + 1);
            left--;
            right++;
        }
        return currentSubstring;
    }
}