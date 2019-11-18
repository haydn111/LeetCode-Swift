// Remove the minimum number of invalid parentheses in order to make the input string valid. Return all possible results.

// Note: The input string may contain letters other than the parentheses ( and ).

// Examples:
// "()())()" -> ["()()()", "(())()"]
// "(a)())()" -> ["(a)()()", "(a())()"]
// ")(" -> [""]

// Time: O(2^(l + r))
extension String {
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
    mutating func remove(at i: Int) {
        let index = self.index(self.startIndex, offsetBy: i)
        if index != self.endIndex { self.remove(at: index) }
    }
}

var solutions = [String]()
func removeInvalidParentheses(_ s: String) -> [String] {
    // 1st pass: mark how many left and right parentheses needs to remove: l + 1 for each left, l - 1 for each right, r + 1 for each right when l == 0
    // => needs to remove l left and r right to make it valid
    var l = 0, r = 0
    for i in 0..<s.count {
        if String(s[i]) == "(" { l += 1 }
        if String(s[i]) == ")" {
            if l == 0 { r += 1 } else { l -= 1 }
        }
    }
    searchAndDelete(s, 0, l, r)
    return solutions
}

func isValid(_ s: String) -> Bool {
    var count = 0
    for i in 0..<s.count {
        if String(s[i]) == "(" { count += 1 }
        if String(s[i]) == ")" { count -= 1 }
        if count < 0 { return false }
    }
    return count == 0
}

// DFS
// from the head of string, start at each char: first recursively delete r right parentheses, then recursively delete l left parentheses. validate string when l == r == 0

func searchAndDelete(_ string: String, _ index: Int, _ l: Int, _ r: Int) {
    if l == 0 && r == 0 || string.count == 0 {
        if isValid(string) && !solutions.contains(string) { solutions += [string] }
        return
    }
    
    for i in index..<string.count {
        // if there's multiple of same parentheses in a row, only try delete the first one.
        // this greatly optimize the running time. If there are more than one ")"s only try delete first one.
        if i != index && string[i] == string[i - 1] { continue }
        
        if String(string[i]) == "(" || String(string[i]) == ")" {
            var s = string

            if String(s[i]) == ")" && r > 0 {
                s.remove(at: i)
                searchAndDelete(s, i, l, r - 1)
            }
            else if String(s[i]) == "(" && l > 0 {
                s.remove(at: i)
                searchAndDelete(s, i, l - 1, r)
            }
        }
    }
}
