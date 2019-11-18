package algorithms;

// Given strings S and T, find the minimum (contiguous) substring W of S, so that T is a subsequence of W.
// If there is no such window in S that covers all characters in T, return the empty string "". If there 
// are multiple such minimum-length windows, return the one with the left-most starting index.
//
// Example 1:
// Input: 
// S = "abcdebdde", T = "bde"
// Output: "bcde"

public class LC76_Minimum_Window_Substring {
	public String minWindow(String s, String t) {
		if (s == null || t == null || s.length() == 0 || t.length() == 0) {
			return "";
		}
		
		int matchCount = 0;		// count of matched characters in substring
		String solution = "";
		int[] sArray = new int[256];
		int[] tArray = new int[256];	// table to lookup chars appeared in s and t

		for (char c: t.toCharArray()) {
			tArray[(int)c]++;
		}
		
		int left = findNextTCharInS(0, s, tArray);
		int right = left;
		
		while (right < s.length()) {	// move right pointer
			int rightCharIndex = (int)s.charAt(right);
			if (sArray[rightCharIndex] < tArray[rightCharIndex]) {
				matchCount++;
			}
			sArray[rightCharIndex]++;
			
			while (left < s.length() && matchCount == t.length()) {	// move left pointer
				if (solution.isEmpty() || solution.length() > right - left + 1) {
					solution = s.substring(left, right + 1);
				}
				int leftCharIndex = (int)s.charAt(left);
				if (sArray[leftCharIndex] <= tArray[leftCharIndex]) {
					matchCount--;
				}
				left = findNextTCharInS(left + 1, s, tArray);
				sArray[leftCharIndex]--;
			}
			right = findNextTCharInS(right + 1, s, tArray);
		}
		return solution;
	}
	
	private int findNextTCharInS(int start, String s, int[] tArray) {
		while (start < s.length()) {
			char c = s.charAt(start);
			if (tArray[(int)c] > 0) {
				return start;
			}
			start++;
		}
		return start;
	}
	
	public static void main(String[] args) {
		LC76_Minimum_Window_Substring testInstance = new LC76_Minimum_Window_Substring();
		String s1 = "abcdebdde", t1 = "bde";	// deb
		String s2 = "ADOBECODEBANC", t2 = "ABC";	// BANC
		System.out.println(testInstance.minWindow(s1, t1));
		System.out.println(testInstance.minWindow(s2, t2));
	}

}
