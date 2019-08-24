// Given a grid where each entry is only 0 or 1, find the number of corner rectangles.

// A corner rectangle is 4 distinct 1s on the grid that form an axis-aligned rectangle. Note that only the corners need to have the value 1. Also, all four 1s used must be distinct.

// Example 1:
// Input: grid = 
// [[1, 0, 0, 1, 0],
//  [0, 0, 1, 0, 1],
//  [0, 0, 0, 1, 0],
//  [1, 0, 1, 0, 1]]
// Output: 1
// Explanation: There is only one corner rectangle, with corners grid[1][2], grid[1][4], grid[3][2], grid[3][4].

// Example 2:
// Input: grid = 
// [[1, 1, 1],
//  [1, 1, 1],
//  [1, 1, 1]]
// Output: 9
// Explanation: There are four 2x2 rectangles, four 2x3 and 3x2 rectangles, and one 3x3 rectangle.

// Example 3:
// Input: grid = 
// [[1, 1, 1, 1]]
// Output: 0
// Explanation: Rectangles must have four distinct corners.

// Note:
// The number of rows and columns of grid will each be in the range [1, 200].
// Each grid[i][j] will be either 0 or 1.
// The number of 1s in the grid will be at most 6000.

// Naive brute force solution O(n^3)
func countCornerRectangles(_ grid: [[Int]]) -> Int {
    if grid.count <= 1 || grid[0].count <= 1 { return 0 }
    var xDict [Int: Int](), yDict = [Int: Int]()
    var count = 0
    for i in 1 ..< grid.count {     // row of rect's top border
        for j in i + 1 ..< grid.count {  // row of rect's bottom border
            for k in 0 ..< grid[0].count {  // sliding vertical position
                var n = 0
                if grid[i][k] == 1 && grid[j][k] == 1 { // a vertical line from row i to row j found
                    n += 1
                }
            }
            count += n * (n - 1) / 2    // select two distict lines from n lines
        }
    }
    return count
}