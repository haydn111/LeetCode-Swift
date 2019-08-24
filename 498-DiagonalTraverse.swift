// 498. Diagonal Traverse
// DescriptionHintsSubmissionsDiscussSolution
// Given a matrix of M x N elements (M rows, N columns), return all elements of the matrix in diagonal order as shown in the below image.

// Example:
// Input:
// [
//  [ 1, 2, 3 ],
//  [ 4, 5, 6 ],
//  [ 7, 8, 9 ]
// ]
// Output:  [1,2,4,7,5,3,6,8,9]
// Order: [0, 0], [0, 1], [1, 0], [2, 0], [1, 1], [0, 2], [1, 2], [2, 1], [2, 2]
// Explanation:

// Note:
// The total number of elements of the given matrix will not exceed 10,000.

// Walk patterns:

// If out of bottom border (row >= m) then row = m - 1; col += 2; change walk direction.
// if out of right border (col >= n) then col = n - 1; row += 2; change walk direction.
// if out of top border (row < 0) then row = 0; change walk direction.
// if out of left border (col < 0) then col = 0; change walk direction.
// Otherwise, just go along with the current direction.
// Time complexity: O(m * n), m = number of rows, n = number of columns.
// Space complexity: O(1).

func findDiagonalOrder(_ matrix: [[Int]]) -> [Int] {
    if matrix.count == 0 || matrix[0].count == 0 { return [] }
    let directions = [1: [-1, 1], -1: [1, -1]]
    var total = matrix.count * matrix[0].count, count = 0, result = [Int]()
    var row = 0, col = 0, direction = 1
    while count < total {
        result.append(matrix[row][col])
        
        // move
        row += directions[direction]![0]; col += directions[direction]![1]
        
        // bound check
        if row >= matrix.count { row = matrix.count - 1; col += 2; direction *= -1 }
        if col >= matrix[0].count { col = matrix[0].count - 1; row += 2; direction *= -1 }
        if row < 0 { row = 0; direction *= -1 }
        if col < 0 { col = 0; direction *= -1 }
        
        count += 1
    }
    
    return result
}
