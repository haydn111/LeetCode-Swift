
// Given a string array words, find the maximum value of length(word[i]) * length(word[j]) where the two words do not share common letters. You may assume that each word will contain only lower case letters. If no such two words exist, return 0.

// Example 1:

// Input: ["abcw","baz","foo","bar","xtfn","abcdef"]
// Output: 16 
// Explanation: The two words can be "abcw", "xtfn".

// Example 2:

// Input: ["a","ab","abc","d","cd","bcd","abcd"]
// Output: 4 
// Explanation: The two words can be "ab", "cd".

// Example 3:

// Input: ["a","aa","aaa","aaaa"]
// Output: 0 
// Explanation: No such pair of words


class Solution {
    // Turn each string into a 26-bit binary number with LSB = string.contans("a") and MSB = string.contains("z"). Then for every string pair we can know if they share any character by testing num1 & num2 == 0 in O(1)
    // We can further optimize by sort the input words from longest to shortest. Then in each round we can stop after find first pair of words without same character.
    func maxProduct(_ words: [String]) -> Int {
        let sortedWords = words.sorted(by: {
            return $0.count >= $1.count
        })
        print(sortedWords)
        var hashedWords = sortedWords.map { word -> UInt32 in
            var i: UInt32 = 0
            for c in word {
                i |= 1 << (c.ascii! - 97)
            }
            return i
        }

        var maxLen = 0
        for i in 0..<hashedWords.count {
            if (sortedWords[i].count * sortedWords[i].count <= maxLen) { break } // prunning
            for j in i + 1 ..< hashedWords.count {
                if hashedWords[i] & hashedWords[j] == 0 {
                    maxLen = max(maxLen, sortedWords[i].count * sortedWords[j].count)
                    break   // prunning
                }
            }
        }
        return maxLen
    }
}

extension Character {
    var ascii: UInt32? {
        return String(self).unicodeScalars.filter { $0.isASCII }.first?.value
    }
}