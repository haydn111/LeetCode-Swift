// Given a string containing digits from 2-9 inclusive, return all possible letter combinations that the number could represent.

// A mapping of digit to letters (just like on the telephone buttons) is given below. Note that 1 does not map to any letters.

// Example:

// Input: "23"
// Output: ["ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf"].

let dict: [Character: String] = [
    "2": "abc",
    "3": "def",
    "4": "ghi",
    "5": "jkl",
    "6": "mno",
    "7": "pqrs",
    "8": "tuv",
    "9": "wxyz"
]

func letterCombinations(_ digits: String) -> [String] {
    if digits.count == 0 { return [] }
    
    let digit = digits.first!
    if digits.count == 1 { 
        return dict[digit]!.characters.map { String($0) } 
    }
    
    var rest = digits
    rest.removeFirst()
    
    return dict[digit]!.characters.flatMap { char in
        letterCombinations(rest).map { restChars in
            String(char) + restChars
        }
    }
}
