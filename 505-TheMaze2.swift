// There is a ball in a maze with empty spaces and walls. The ball can go through empty spaces by rolling up, down, left or right, but it won't stop rolling until hitting a wall. When the ball stops, it could choose the next direction.

// Given the ball's start position, the destination and the maze, find the shortest distance for the ball to stop at the destination. The distance is defined by the number of empty spaces traveled by the ball from the start position (excluded) to the destination (included). If the ball cannot stop at the destination, return -1.

// The maze is represented by a binary 2D array. 1 means the wall and 0 means the empty space. You may assume that the borders of the maze are all walls. The start and destination coordinates are represented by row and column indexes.

// Example 1

// Input 1: a maze represented by a 2D array

// 0 0 1 0 0
// 0 0 0 0 0
// 0 0 0 1 0
// 1 1 0 1 1
// 0 0 0 0 0

// Input 2: start coordinate (rowStart, colStart) = (0, 4)
// Input 3: destination coordinate (rowDest, colDest) = (4, 4)

// Output: 12
// Explanation: One shortest way is : left -> down -> left -> down -> right -> down -> right.
// The total distance is 1 + 1 + 3 + 1 + 2 + 2 + 2 = 12.

// Example 2

// Input 1: a maze represented by a 2D array

// 0 0 1 0 0
// 0 0 0 0 0
// 0 0 0 1 0
// 1 1 0 1 1
// 0 0 0 0 0

// Input 2: start coordinate (rowStart, colStart) = (0, 4)
// Input 3: destination coordinate (rowDest, colDest) = (3, 2)

// Output: -1
// Explanation: There is no way for the ball to stop at the destination.

// Note:

// There is only one ball and one destination in the maze.
// Both the ball and the destination exist on an empty space, and they will not be at the same position initially.
// The given maze does not contain border (like the red rectangle in the example pictures), but you could assume the border of the maze are all walls.
// The maze contains at least 2 empty spaces, and both the width and height of the maze won't exceed 100.

var maze = [[Int]]()
var directions = [[0, 1], [1, 0], [0, -1], [-1, 0]]

func shortestDistance(_ maze: [[Int]], _ start: [Int], _ destination: [Int]) -> Int {
    self.maze = maze
    var minDist = Int.max
    for direction in directions {
        var visited = Array(repeating: Array(repeating: Int.max, count: maze[0].count), count: maze.count)
        var stop = Array(repeating: Array(repeating: false, count: maze[0].count), count: maze.count)
        dfs(start, direction, destination, 0, &visited, &stop)
        if stop[destination[0]][destination[1]] {
            minDist = min(minDist, visited[destination[0]][destination[1]])
        }
    }
    return minDist == Int.max ? -1 : minDist
}

func dfs(_ curr: [Int], _ dir: [Int], _ dest: [Int], _ distance: Int, _ visited: inout [[Int]], _ stop: inout [[Bool]]) {
    if !isValid(curr) || visited[curr[0]][curr[1]] < distance { return }
    visited[curr[0]][curr[1]] = distance
    if isValid([curr[0] + dir[0], curr[1] + dir[1]]) {  // move forward
        dfs([curr[0] + dir[0], curr[1] + dir[1]], dir, dest, distance + 1, &visited, &stop)
    } else {    // hit a wall, change direction
        stop[curr[0]][curr[1]] = true
        if curr[0] == dest[0] && curr[1] == dest[1] { return }
        for direction in directions {
            if direction[0] != dir[0] && direction[1] != dir[1] && isValid([curr[0] + direction[0], curr[1] + direction[1]]) {
                dfs(curr, direction, dest, distance, &visited, &stop)
            }
        }
    }
}

func isValid(_ curr: [Int]) -> Bool {
    return curr[0] >= 0 && curr[0] < maze.count && curr[1] >= 0 && curr[1] < maze[0].count && maze[curr[0]][curr[1]] == 0
}
