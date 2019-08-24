// Given a matrix consists of 0 and 1, find the distance of the nearest 0 for each 1.

// The distance between two adjacent cells is 1.

// Example 1: 
// Input:
// 0 0 0
// 0 1 0
// 0 0 0

// Output:
// 0 0 0
// 0 1 0
// 0 0 0

// Example 2: 
// Input:
// 0 0 0
// 0 1 0
// 1 1 1

// Output:
// 0 0 0
// 0 1 0
// 1 2 1

// Note:
// The number of elements of the given matrix will not exceed 10,000.
// There are at least one 0 in the given matrix.
// The cells are adjacent in only four directions: up, down, left and right.


// For our BFS routine, we keep a queue of (row, col, distance), q to maintain the queue of cells to be examined next and its distance.
// We start by adding all the cells with 0s to q.
// Intially, distance for each 0 cell is 0 and distance for each 1 is INT_MAX, which is updated during the BFS.
// Pop the cell from queue, and examine its neighbours. If the new calculated distance for neighbour {i,j} is smaller, we add {i, j, dist} to q and update result[i][j].

func updateMatrix(_ matrix: [[Int]]) -> [[Int]] {
    if matrix.count == 0 || matrix[0].count == 0 { return matrix }
    var result = matrix, queue = [(Int, Int, Int)]()    // row, col, distance
    for i in 0..<result.count {
        for j in 0..<result[i].count {
            if result[i][j] == 1 { result[i][j] = Int.max }
            else { queue.append((i, j, 0)) }
        }
    }

    while queue.count > 0 {
        var (row, col, dist) = queue.removeFirst()
        // look at neighbors
        updateDistance(row - 1, col, dist + 1, &result, &queue)
        updateDistance(row + 1, col, dist + 1, &result, &queue)
        updateDistance(row, col - 1, dist + 1, &result, &queue)
        updateDistance(row, col + 1, dist + 1, &result, &queue)
    }
    return result
}

func updateDistance(_ row: Int, _ col: Int, _ dist: Int, _ result: inout [[Int]], _ queue: inout [(Int, Int, Int)]) {
    if row >= 0 && row < result.count && col >= 0 && col < result[row].count && dist < result[row][col] {
        result[row][col] = dist
        queue.append((row, col, dist))
    }
}
