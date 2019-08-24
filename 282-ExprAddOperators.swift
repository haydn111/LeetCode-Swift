// Given a string that contains only digits 0-9 and a target value, return all possibilities to add binary operators (not unary) +, -, or * between the digits so they evaluate to the target value.

// Example 1:

// Input: num = "123", target = 6
// Output: ["1+2+3", "1*2*3"] 
// Example 2:

// Input: num = "232", target = 8
// Output: ["2*3+2", "2+3*2"]
// Example 3:

// Input: num = "105", target = 5
// Output: ["1*0+5","10-5"]
// Example 4:

// Input: num = "00", target = 0
// Output: ["0+0", "0-0", "0*0"]
// Example 5:

// Input: num = "3456237490", target = 9191
// Output: []

extension String {
    subscript(range: CountableClosedRange<Int>) -> Substring {
        return self[index(startIndex, offsetBy: range.lowerBound)...index(startIndex, offsetBy: range.upperBound)]
    }
}

class Solution {
    var solution = [String]()
    var numberGiven = ""
    var targetResult = 0

    func dfs(expr: String, position: Int, prevResult: Int, result: Int) {
        if position == numberGiven.count {
            if result == targetResult { solution.append(expr) }
            return
        }

        for i in position..<numberGiven.count {
            let currString = String(numberGiven[position...i])
            guard i == position || !currString.hasPrefix("0") else { break }    // current number can be 0 but cannot be 0x...
            guard let currNum = Int(currString) else {
                fatalError("\(numberGiven[position...i]) cannot convert to Int")
            }
            if position == 0 {  // first number in expr, treat as +
                dfs(expr: currString, position: i + 1, prevResult: currNum, result: currNum)
            } else {    // can be either +, - or *
                dfs(expr: expr + "+" + currString, position: i + 1, prevResult: currNum, result: result + currNum)
                dfs(expr: expr + "-" + currString, position: i + 1, prevResult: -currNum, result: result - currNum)
                dfs(expr: expr + "*" + currString, position: i + 1, prevResult: prevResult * currNum, result: result - prevResult + prevResult * currNum)   // prevResult record consecutive multiplications
            }
        }
    }

    func addOperators(_ num: String, _ target: Int) -> [String] {
        if num.count == 0 { return [] }
        numberGiven = num
        targetResult = target
        dfs(expr: "", position: 0, prevResult: 0, result: 0)
        return solution
    }
}