// In a 2D grid from (0, 0) to (N-1, N-1), every cell contains a 1, except those cells in the given list mines which are 0. What is the largest axis-aligned plus sign of 1s contained in the grid? Return the order of the plus sign. If there is none, return 0.

// An "axis-aligned plus sign of 1s of order k" has some center grid[x][y] = 1 along with 4 arms of length k-1 going up, down, left, and right, and made of 1s. This is demonstrated in the diagrams below. Note that there could be 0s or 1s beyond the arms of the plus sign, only the relevant area of the plus sign is checked for 1s.

// Examples of Axis-Aligned Plus Signs of Order k:

// Order 1:
// 000
// 010
// 000

// Order 2:
// 00000
// 00100
// 01110
// 00100
// 00000

// Order 3:
// 0000000
// 0001000
// 0001000
// 0111110
// 0001000
// 0001000
// 0000000
// Example 1:

// Input: N = 5, mines = [[4, 2]]
// Output: 2
// Explanation:
// 11111
// 11111
// 11111
// 11111
// 11011
// In the above grid, the largest plus sign can only be order 2.  One of them is marked in bold.

// Example 2:

// Input: N = 2, mines = []
// Output: 1
// Explanation:
// There is no plus sign of order 2, but there is of order 1.
// Example 3:

// Input: N = 1, mines = [[0, 0]]
// Output: 0
// Explanation:
// There is no plus sign, so return 0.

struct Node {
    var l = 0, r = 0, u = 0, d = 0
    init() {}
}

class Solution {
    var mines = [[Int]]()
    
    func orderOfLargestPlusSign(_ N: Int, _ mines: [[Int]]) -> Int {
        var grid = Array(repeating: Array(repeating: 1, count: N), count: N)
        // process mines
        for mine in mines {
            grid[mine[0]][mine[1]] = 0
        }
        
        var data = Array(repeating: Array(repeating: Node(), count: N), count: N)
        
        // move horizontally
        for i in 0 ..< N {
            // left to right, to update all l values
            for j in 0 ..< N {
                if grid[i][j] == 1 { 
                    if j == 0 { data[i][j].l = 1 }
                    else { data[i][j].l = data[i][j - 1].l + 1 }
                }
            }
            
            // right to left, to update all r values
            for j in stride(from: N - 1, through: 0, by: -1) {
                if grid[i][j] == 1 { 
                    if j == N - 1 { data[i][j].r = 1 }
                    else { data[i][j].r = data[i][j + 1].r + 1 }
                }
            }            
        }
        
        // move vertically 
        for j in 0 ..< N {
            // top to bottom to update u values
            for i in 0 ..< N {
                if grid[i][j] == 1 { 
                    if i == 0 { data[i][j].u = 1 }
                    else { data[i][j].u = data[i - 1][j].u + 1 }
                }
            }

            // bottom to top to update d values
            for i in stride(from: N - 1, through: 0, by: -1) {
                if grid[i][j] == 1 { 
                    if i == N - 1 { data[i][j].d = 1 }
                    else { data[i][j].d = data[i + 1][j].d + 1 }
                }
            }
        }

        
        var maxOrder = 0
        for i in 0 ..< N {
            for j in 0 ..< N {
                let d = data[i][j]
                // print(i, j, "|", d.l, d.r, d.u, d.d)
                maxOrder = max(maxOrder, min(d.l, d.r, d.u, d.d))
            }
        }
        
        
        return maxOrder
    }
    
}