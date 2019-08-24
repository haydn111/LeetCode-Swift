// Given a 01 matrix M, find the longest line of consecutive one in the matrix. The line could be horizontal, vertical, diagonal or anti-diagonal.

// Example:

// Input:
// [[0,1,1,0],
//  [0,1,1,0],
//  [0,0,0,1]]
// Output: 3
// Hint: The number of elements in the given matrix will not exceed 10,000.

// 思路：

// 没有什么好的技巧，逐行找，逐列找，然后正对角线找，反对角线找。算法的时间复杂度是O(mn)，空间复杂度是O(1)，其中m和n分别是矩阵的行个数和列个数。


func longestLine(_ m: [[Int]]) -> Int {
    if m.count == 0 || m[0].count == 0 { return 0 }
    
    var maxLine = 0, x = 0, y = 0, count = 0
    // find in rows
    while x < m.count {
        y = 0; count = 0
        while y < m[0].count {
            if m[x][y] == 1 {
                count += 1
                maxLine = max(maxLine, count)
            }
            else { count = 0 }
            y += 1
        }
        x += 1
    }
    
    // find in columns
    x = 0; y = 0
    while y < m[0].count {
        x = 0; count = 0
        while x < m.count {
            if m[x][y] == 1 {
                count += 1
                maxLine = max(maxLine, count)
            }
            else { count = 0 }
            x += 1
        }
        y += 1
    }
    
    // find in diagnoal, from bottom left to top right
    var xStart = 0, yStart = 1
    while xStart < m.count {
        x = xStart; y = 0; count = 0    // start at m[r][0]
        while x >= 0 && y < m[0].count {
            if m[x][y] == 1 {
                count += 1
                maxLine = max(maxLine, count)
            }
            else { count = 0 }
            x -= 1; y += 1
        }
        xStart += 1
    }
    
    while yStart < m[0].count {
        x = m.count - 1; y = yStart; count = 0  // start at m[last][c]
        while x >= 0 && y < m[0].count {
            if m[x][y] == 1 {
                count += 1
                maxLine = max(maxLine, count)
            }
            else { count = 0 }
            x -= 1; y += 1
        }
        yStart += 1
    }
    
    // find anti-diagnoal, from bottom right to top left
    xStart = 0; yStart = m[0].count - 2
    while xStart < m.count {
        x = xStart; y = m[0].count - 1; count = 0
        while x >= 0 && y >= 0 {
            if m[x][y] == 1 {
                count += 1
                maxLine = max(maxLine, count)
            }
            else { count = 0 }
            x -= 1; y -= 1
        }
        xStart += 1
    }
    
    while yStart >= 0 {
        x = m.count - 1; y = yStart; count = 0
        while x >= 0 && y >= 0 {
            if m[x][y] == 1 {
                count += 1
                maxLine = max(maxLine, count)
            }
            else { count = 0 }
            x -= 1; y -= 1
        }
        yStart -= 1
    }
    return maxLine
}
