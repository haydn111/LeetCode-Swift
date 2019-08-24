// Given an array of words and a width maxWidth, format the text such that each line has exactly maxWidth characters and is fully (left and right) justified.

// You should pack your words in a greedy approach; that is, pack as many words as you can in each line. Pad extra spaces ' ' when necessary so that each line has exactly maxWidth characters.

// Extra spaces between words should be distributed as evenly as possible. If the number of spaces on a line do not divide evenly between words, the empty slots on the left will be assigned more spaces than the slots on the right.

// For the last line of text, it should be left justified and no extra space is inserted between words.

// Note:
// A word is defined as a character sequence consisting of non-space characters only.
// Each word's length is guaranteed to be greater than 0 and not exceed maxWidth.
// The input array words contains at least one word.

// Example 1:

// Input:
// words = ["This", "is", "an", "example", "of", "text", "justification."]
// maxWidth = 16
// Output:
// [
//    "This    is    an",
//    "example  of text",
//    "justification.  "
// ]

// Example 2:

// Input:
// words = ["What","must","be","acknowledgment","shall","be"]
// maxWidth = 16
// Output:
// [
//   "What   must   be",
//   "acknowledgment  ",
//   "shall be        "
// ]
// Explanation: Note that the last line is "shall be    " instead of "shall     be",
//              because the last line must be left-justified instead of fully-justified.
//              Note that the second line is also left-justified becase it contains only one word.

func fullJustify(_ words: [String], _ maxWidth: Int) -> [String] {
    var myWords = words
    var result = [String]()
    while myWords.count > 0 {
        // gather words in a line
        var line = [String]()
        var lineCount = 0
        while let word = myWords.first, word.count + lineCount + line.count <= maxWidth {
            line.append(word)
            lineCount += word.count
            myWords.removeFirst()
        }
        
        // process line
        if myWords.count == 0 || line.count == 1 {   // special case. left justified
            var lineString = line.joined(separator: " ")
            lineString += String(repeating: " ", count: maxWidth - lineCount - (line.count - 1))
            result.append(lineString)
        } else {    // fully justified. line has at least 2 words
            let numOfSpace = maxWidth - lineCount
            let gap = String(repeating: " ", count: (numOfSpace) / (line.count - 1))
            let prefixSize = numOfSpace % (line.count - 1)  // if space can't be even then gaps in prefix can have an additional space
            let linePrefix = line[0...prefixSize].joined(separator: gap + " ")
            let lastSpaceCount = maxWidth - linePrefix.count - line[line.count - 1].count
            let lineString = linePrefix + gap + line[prefixSize + 1...line.count - 1].joined(separator: gap)
            result.append(lineString)
        }
    }
    return result
}