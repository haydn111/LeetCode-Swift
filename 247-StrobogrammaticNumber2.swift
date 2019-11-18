// A strobogrammatic number is a number that looks the same when rotated 180 degrees (looked at upside down).

// Find all strobogrammatic numbers that are of length = n.

// For example,
// Given n = 2, return ["11","69","88","96"].

// Hint:
// Try to use recursion and notice that it should recurse with n - 2 instead of n - 1.

// 思路: 可以像是一层层的给字符串从里向外穿衣服一样DFS生成所有的解.
// 其中翻转之后和自身相等有0, 1, 8, 在n为奇数的情况下最里面的一个数可以为这三个数的任意一个. 
// 外边就一次给两端添加一个对称的字符: 11, 69, 88, 96
// 如果是最外层的话需要注意不能是为0.

var sgDigits: [String] = ["0", "1", "8"]
var sgPairs: [(String, String)] = [("0", "0"), ("1", "1"), ("6", "9"), ("8", "8"), ("9", "6")]

func findStrobogrammatic(_ n: Int, outside: Bool) -> [String] { // set outside to true when running.
    if n == 0 { return [String]() }
    if n == 1 { return sgDigits }
    var results = [String](), innerResults = findStrobogrammatic(n - 2, outside: false)
    var pairs = sgPairs
    if outside { pairs.removeFirst() }
    for (start, end) in pairs {
        results += innerResults.map { start + $0 + end }
    }
    return results
}