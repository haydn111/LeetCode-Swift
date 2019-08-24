// Write an efficient algorithm that searches for a value in an m x n matrix. This matrix has the following properties:

// Integers in each row are sorted in ascending from left to right.
// Integers in each column are sorted in ascending from top to bottom.
// Example:

// Consider the following matrix:

// [
//   [1,   4,  7, 11, 15],
//   [2,   5,  8, 12, 19],
//   [3,   6,  9, 16, 22],
//   [10, 13, 14, 17, 24],
//   [18, 21, 23, 26, 30]
// ]
// Given target = 5, return true.

// Given target = 20, return false.

func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
    if matrix.count == 0 || matrix[0].count == 0 { return false }
    for row in matrix {
        if row.first! <= target && target <= row.last! { 
            if findNumInRow(row, target) { return true }
        }
    }
    return false
}

func findNumInRow(_ row: [Int], _ target: Int) -> Bool {
    var l = 0, h = row.count - 1
    while l <= h {
        let mid = (l + h) / 2
        if row[mid] == target { return true }
        else if row[mid] < target { l = mid + 1 }
        else { h = mid - 1 }
    }
    return false
}
