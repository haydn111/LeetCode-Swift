// Given two words (beginWord and endWord), and a dictionary's word list, find the length of shortest transformation sequence from beginWord to endWord, such that:

// Only one letter can be changed at a time.
// Each transformed word must exist in the word list. Note that beginWord is not a transformed word.
// Note:

// Return 0 if there is no such transformation sequence.
// All words have the same length.
// All words contain only lowercase alphabetic characters.
// You may assume no duplicates in the word list.
// You may assume beginWord and endWord are non-empty and are not the same.

// Example 1:

// Input:
// beginWord = "hit",
// endWord = "cog",
// wordList = ["hot","dot","dog","lot","log","cog"]

// Output: 5

// Explanation: As one shortest transformation is "hit" -> "hot" -> "dot" -> "dog" -> "cog",
// return its length 5.

// Example 2:

// Input:
// beginWord = "hit"
// endWord = "cog"
// wordList = ["hot","dot","dog","lot","log"]

// Output: 0

// Explanation: The endWord "cog" is not in wordList, therefore no possible transformation.

let letters = "abcdefghijklmnopqrstuvwxyz"
    
// Optimized solution: 
// - Only build the neighbors for current word
// - Remove word from wordList once visited
// - Start search from both ends

func ladderLength(_ beginWord: String, _ endWord: String, _ wordList: [String]) -> Int {
    var ws = Set(wordList)
    if !ws.contains(endWord) { return 0 }
    var endWords = [endWord, beginWord]
    var wordSet = [ws, ws]
    var visited = [Set<String>(), Set<String>()]
    var path = [ [beginWord: (1, "")], [endWord: (1, "")] ]    // [s: (length of shortest path from begin to s, prev string in shortest path)]
    var queue = [[beginWord], [endWord]]

    while queue[0].count > 0 && queue[1].count > 0 {
        for k in 0...1 {
            let word = queue[k].removeFirst()
            visited[k].insert(word)
            wordSet[k].remove(word)

            // one end reaches the other end
            if endWords[k] == word { 
                let (length, _) = path[k][word]!
                return length
            }
            
            // two ends intersects
            if visited[(k + 1) % 2].contains(word) {
                let (lengthFromOtherEnd, _) = path[(k + 1) % 2][word]!
                let (lengthFromThisEnd, _) = path[k][word]!
                return lengthFromThisEnd + lengthFromOtherEnd - 1
            }

            // build neighbors
            var neighbors = [String]()
            for i in 0..<word.count {
                for letter in letters {
                    var w = Array(word)
                    if w[i] != letter {
                        w[i] = letter
                        if wordSet[k].contains(String(w)) { neighbors.append(String(w)) }
                    }
                }
            }

            for neighbor in neighbors {
                    queue[k].append(neighbor) 
                    let (currLen, _) = path[k][word]!
                    if let (nextLen, _) = path[k][neighbor] {
                        if currLen + 1 < nextLen { path[k][neighbor] = (currLen + 1, word) }
                    } else {
                        path[k][neighbor] = (currLen + 1, word)
                    }
            }
        }
    }
    return 0
}
