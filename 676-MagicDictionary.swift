// Implement a magic directory with buildDict, and search methods.

// For the method buildDict, you'll be given a list of non-repetitive words to build a dictionary.

// For the method search, you'll be given a word, and judge whether if you modify exactly one character into another character in this word, the modified word is in the dictionary you just built.

// Example 1:
// Input: buildDict(["hello", "leetcode"]), Output: Null
// Input: search("hello"), Output: False
// Input: search("hhllo"), Output: True
// Input: search("hell"), Output: False
// Input: search("leetcoded"), Output: False
// Note:
// You may assume that all the inputs are consist of lowercase letters a-z.
// For contest purpose, the test data is rather small by now. You could think about highly efficient algorithm after the contest.
// Please remember to RESET your class variables declared in class MagicDictionary, as static/class variables are persisted across multiple test cases. Please see here for more details.

class MagicDictionary {
    var dict = [String: [(Int, Character)]]()
    
    // For each word, for each char, remove the char and put the rest of the word as key, a pair of (index of the removal, removed char) into the hash map
    func buildDict(_ strings: [String]) {
        for s in strings {
            for i in 0..<s.count {
                var str = s, index = str.index(str.startIndex, offsetBy: i), char = str[index]
                str.removeSubrange(index...index)
                if dict[str] == nil { dict[str] = [] }
                dict[str]!.append((i, char))
            }
        }
    }
    
    // During search, generate the keys as in step 1. When we see there's pair of same index but different char in the value array, we know the answer is true
    func search(_ s: String) -> Bool {
        for i in 0..<s.count {
            var str = s, index = str.index(str.startIndex, offsetBy: i), char = str[index]
            str.removeSubrange(index...index)
            if let changes = dict[str] {
                for (j, c) in changes {
                    if i == j && char != c { return true }
                }
            }
        }
        return false
    }
}

buildDict(["hello"])
print(search("healo"))  // t
print(search("hlllo"))  // t
print(search("hello"))  // f
print(search("hell"))   // f
print(search("helloo")) // f
