// Given n pairs of parentheses, write a function to generate all combinations of well-formed parentheses.

// For example, given n = 3, a solution set is:

// [
//   "((()))",
//   "(()())",
//   "(())()",
//   "()(())",
//   "()()()"
// ]

// 1. Every postion can be left or right parenthes
// 2. At any point of time, # of right parenthes <= # of left parenthes

// 采用递归方式，添加左括号的条件是左括号数量小于 n，添加右括号的条件是右括号数小于左括号数

func generateParenthesis(_ n: Int) -> [String] {
    return generator(n, n)
}

func generator(_ lCount: Int, _ rCount: Int) -> [String] {
    if rCount == 0 && lCount == 0 { return [""] }
    var result = [String]()
    if lCount > 0 { result += generator(lCount - 1, rCount).map { "(" + $0 } }
    if rCount > lCount { result += generator(lCount, rCount - 1).map { ")" + $0 } }
    return result
}