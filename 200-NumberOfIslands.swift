// Given a 2d grid map of '1's (land) and '0's (water), count the number of islands. An island is surrounded by water and is formed by connecting adjacent lands horizontally or vertically. You may assume all four edges of the grid are all surrounded by water.

// Example 1:

// Input:
// 11110
// 11010
// 11000
// 00000

// Output: 1

// Example 2:

// Input:
// 11000
// 11000
// 00100
// 00011

// Output: 3

class Solution {
    func numIslands(_ grid: [[Character]]) -> Int {
        if grid.count == 0 || grid[0].count == 0 { return 0 }
        var count = 0
        var myGrid = grid
        for i in 0...myGrid.count - 1 {
            for j in 0...myGrid[i].count - 1 {
                if myGrid[i][j] == "1" {
                    count += 1
                    bfs(&myGrid, i, j)
                }
            }
        }
        return count
    }
    
    func bfs(_ grid: inout [[Character]], _ i: Int, _ j: Int) { // eat an island using bfs
        if !isValid(grid, i, j) || grid[i][j] == "0" { return }
        grid[i][j] = "0"
        bfs(&grid, i - 1, j)
        bfs(&grid, i + 1, j)
        bfs(&grid, i, j - 1)
        bfs(&grid, i, j + 1)
    }
    
    func isValid(_ grid: [[Character]], _ i: Int, _ j: Int) -> Bool {
        return i >= 0 && i < grid.count && j >= 0 && j < grid[i].count
    }
}