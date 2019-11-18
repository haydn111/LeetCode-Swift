package algorithms;

public class LC727_Minimum_Window_Subsequence {
	private int findNextTCharInS(int start, char tChar, String s) {
		while (start < s.length()) {
			char c = s.charAt(start);
			if (c == tChar) {
				return start;
			}
			start++;
		}
		return s.length();	// cannot find tChar
	}
	
	public String minWindow(String s, String t) {
		if (s == null || t == null || s.length() == 0 || t.length() == 0) {
			return "";
		}
		
		int matchCount = 0;		// count of matched characters in substring
		String solution = "";
		int tPtr = 1;	// points to current char in T
		int left = findNextTCharInS(0, t.charAt(0), s);
		int right = left;
		
		while (left < s.length() && right < s.length()) {
			
			while (tPtr < t.length()) {
				right = findNextTCharInS(right + 1, t.charAt(tPtr), s);
				if (right < t.length() && t.charAt(right) == t.charAt(tPtr)) {
					matchCount++;
				}
			}
			tPtr = 1;
			
			if (matchCount == t.length()) {
				if (solution.isEmpty() || solution.length() > right - left + 1) {
					solution = s.substring(left, right + 1);
				}
				left = findNextTCharInS(left + 1, t.charAt(0), s);
			}
		}

		return solution;
	}

	
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
