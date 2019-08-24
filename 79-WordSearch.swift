// Given a 2D board and a word, find if the word exists in the grid.

// The word can be constructed from letters of sequentially adjacent cell, where "adjacent" cells are those horizontally or vertically neighboring. The same letter cell may not be used more than once.

// Example:

// board =
// [
//   ['A','B','C','E'],
//   ['S','F','C','S'],
//   ['A','D','E','E']
// ]

// Given word = "ABCCED", return true.
// Given word = "SEE", return true.
// Given word = "ABCB", return false.

extension String {
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
}

class Solution {
    var target = ""
    var words = [String]()
    var found = false
    
    func exist(_ board: [[Character]], _ word: String) -> Bool {
        if board.count == 0 { return  false }
        if word.count == 0 { return true }
        target = word
        var starts = [(Int, Int)]()
        for i in 0..<board.count {
            for j in 0..<board[0].count {
                if board[i][j] == word.first {
                    starts.append((i, j))
                }
            }
        }
        
        for (i, j) in starts {
            bfs(i, j, 0, board)
        }

        return found
    }
    
    func bfs(_ x: Int, _ y: Int, _ i: Int, _ board: [[Character]]) {
        if found { return }
        if i == target.count - 1 { 
            found = true 
            return
        }
        var char = board[x][y]
        var myBoard = board
        myBoard[x][y] = "&"
        if x - 1 >= 0 && myBoard[x - 1][y] == target[i + 1] { dfs(x - 1, y, i + 1, myBoard) }
        if x + 1 < myBoard.count && myBoard[x + 1][y] == target[i + 1] { dfs(x + 1, y, i + 1, myBoard) }
        if y - 1 >= 0 && myBoard[x][y - 1] == target[i + 1] { dfs(x, y - 1, i + 1, myBoard) }
        if y + 1 < myBoard[0].count && myBoard[x][y + 1] == target[i + 1] { dfs(x, y + 1, i + 1, myBoard) }
        
    }
}