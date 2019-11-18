package algorithms;

import java.util.ArrayList;
import java.util.List;

// Given a string and an integer K, return a list of substring with exactly k distinct characters.

public class Substring_w_K_Distinct_Chars {
	public static void main(String[] args) {
        System.out.println(slidingWindow("awaglknagawybagwkwagl",6));
	}

	// time: O(n)
    static List<String> slidingWindow(String s, int k) {
	    List<String> solution = new ArrayList<>();
	    int[] lookup = new int[26];     // assume only lower-case letters!!!
	    int left = 0, right = k - 1;
	    for (int i = 0; i < k; i++) {   // process first k chars
	        int c = (int)s.charAt(i) - (int)'a';
	        lookup[c]++;
        }

        while (right < s.length()) {
	        if (isDistinct(lookup)) {
	            solution.add(s.substring(left, right + 1));
            }
            int leftIndex = (int)s.charAt(left) - (int)'a';
            lookup[leftIndex]--;
            left++;
            right++;
            if (right < s.length()) {
                int nextRightIndex = (int) s.charAt(right) - (int) 'a';
                lookup[nextRightIndex]++;
            }
        }
        return solution;
    }

    private static boolean isDistinct(int[] lookup) {
	    for (int i = 0; i < lookup.length; i++) {
	        if (lookup[i] > 1) {
	            return false;
            }
        }
        return true;
    }
}
