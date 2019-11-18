package algorithms;

import java.util.Stack;

public class LC20_Validate_Parentheses {

//    Given a string containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input string is valid.
//
//    The brackets must close in the correct order, "()" and "()[]{}" are all valid but "(]" and "([)]" are not.

    static boolean isValid(String s) {
        Stack<Character> stack = new Stack<>();
        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (c == '(' || c == '[' || c == '{') {
                stack.push(c);
            }
            else if (c == ')') {
                if (stack.peek() == '(') {
                    stack.pop();
                }
                else {
                    return false;
                }
            }
            else if (c == ']') {
                if (stack.peek() == '[') {
                    stack.pop();
                }
                else {
                    return false;
                }
            }
            else if (c == '}') {
                if (stack.peek() == '{') {
                    stack.pop();
                }
                else {
                    return false;
                }
            }
        }
        return stack.isEmpty();
    }

    public static void main(String[] args) {
        String testCase = "{[()[]{}]}";
        System.out.println(isValid(testCase));
    }
}
