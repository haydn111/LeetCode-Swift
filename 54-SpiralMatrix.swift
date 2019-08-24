// Given a matrix of m x n elements (m rows, n columns), return all elements of the matrix in spiral order.

// Example 1:

// Input:
// [
//  [ 1, 2, 3 ],
//  [ 4, 5, 6 ],
//  [ 7, 8, 9 ]
// ]
// Output: [1,2,3,6,9,8,7,4,5]
// Example 2:

// Input:
// [
//   [1, 2, 3, 4],
//   [5, 6, 7, 8],
//   [9,10,11,12]
// ]
// Output: [1,2,3,4,8,12,11,10,9,5,6,7]

func spiralOrder(_ matrix: [[Int]]) -> [Int] {
    if matrix.count == 0 || matrix[0].count == 0 { return [] }
    let directions = [0: [0, 1], 1: [1, 0], 2: [0, -1], 3: [-1, 0]] // right, down, left, up
    var total = matrix.count * matrix[0].count, count = 0, result = [Int]()
    var rowL = 0, rowH = matrix.count - 1, colL = 0, colH = matrix[0].count - 1 // bounds on 4 sides
    var row = 0, col = 0, direction = 0
    while count < total {
        result.append(matrix[row][col])

        // move
        row += directions[direction % 4]![0]; col += directions[direction % 4]![1]

        // bound check
        if col > colH { col = colH; row += 1; direction += 1; rowL += 1 }   // right -> down
        if row > rowH { row = rowH; col -= 1; direction += 1; colH -= 1 }   // down -> left
        if col < colL { col = colL; row -= 1; direction += 1; rowH -= 1 }   // left -> up
        if row < rowL { row = rowL; col += 1; direction += 1; colL += 1 }   // up -> right

        count += 1
    }
    return result
}
