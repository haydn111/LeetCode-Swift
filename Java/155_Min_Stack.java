package algorithms;

import java.util.Stack;

public class LC155_Min_Stack {
    public class DualStackSolution {
        private Stack<Integer> stack;
        private Stack<Integer> minStack;

        public DualStackSolution() {
            stack = new Stack<>();
            minStack = new Stack<>();
        }

        public void push(int x) {
            stack.push(x);
            if (minStack.isEmpty()) {
                minStack.push(x);
            }
            else {
                int min = minStack.peek();
                if (x <= min) {
                    minStack.push(x);
                }
            }
        }

        public void pop() {
            int x = stack.pop();
            if (!minStack.isEmpty() && x == minStack.peek()) {
                minStack.pop();
            }
        }

        public int top() {
            return stack.peek();
        }

        public int getMin() {
            return minStack.peek();
        }
    }

    public class SingleStackSolution {
        private Stack<Integer> stack;
        int min;

        public SingleStackSolution() {
            stack = new Stack<>();
        }

        public void push(int x) {
            if (x <= min) {
                stack.push(min);
                min = x;
            }
            stack.push(x);
        }

        public void pop() {
            if (stack.pop() == min) {
                min = stack.pop();
            }
        }

        public int top() {
            return stack.peek();
        }

        public int getMin() {
            return min;
        }
    }
}
