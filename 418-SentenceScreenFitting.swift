// Given a rows x cols screen and a sentence represented by a list of words, findhow many times the given sentence can be fitted on the screen.

// Note:

// A word cannot be split into two lines.
// The order of words in the sentence must remain unchanged.
// Two consecutive words in a line must be separated by a single space.
// Total words in the sentence won't exceed 100.
// Length of each word won't exceed 10.
// 1 ≤ rows, cols ≤ 20,000.

// Example 1:

// Input:
// rows = 2, cols = 8, sentence = ["hello", "world"]

// Output: 
// 1

// Explanation:
// hello---
// world---

// The character '-' signifies an empty space on the screen.

// Example 2:

// Input:
// rows = 3, cols = 6, sentence = ["a", "bcd", "e"]

// Output: 
// 2

// Explanation:
// a-bcd- 
// e-a---
// bcd-e-

// The character '-' signifies an empty space on the screen.

// Example 3:

// Input:
// rows = 4, cols = 5, sentence = ["I", "had", "apple", "pie"]

// Output: 
// 1

// Explanation:
// I-had
// apple
// pie-I
// had--

// The character '-' signifies an empty space on the screen


// 思路：一道google的面试题．直接的方法是每次扫描一行，尝试能放几个，这样时间复杂度会高一点．另外一种方法是把所有的字符串都加起来，然后每次看如果位移一整行的距离是否正好落在这个字符串的空格位置，如果不是的话就退后，直到遇到一个空格．

// O(w * mn / s), w is # of words in sentence, m, n is size of screen, s is total # of char in sentence.
func wordsTyping(_ s: [String], rows: Int, columns: Int) -> Int {
    var numOfCopies = 0, ptr = 0
    for i in 0..<rows {
        var lineRemaining = columns
        while lineRemaining >= s[ptr].count {
            lineRemaining -= s[ptr].count + 1
            ptr += 1
            if ptr >= s.count {
                ptr = 0
                numOfCopies += 1
            }
        }
    }
    return numOfCopies
}
