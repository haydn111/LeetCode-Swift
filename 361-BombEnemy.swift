// Given a 2D grid, each cell is either a wall 'Y', an enemy 'X' or empty '0' (the number zero), return the maximum enemies you can kill using one bomb.
// The bomb kills all the enemies in the same row and column from the planted point until it hits the wall since the wall is too strong to be destroyed.
// Note that you can only put the bomb at an empty cell.

// Example:

// For the given grid

// 0 X 0 0
// X 0 Y X
// 0 X 0 0

// return 3. (Placing a bomb at (1,1) kills 3 enemies)

// Time complexity has to be O(mn)

struct BombPoint {  // USE STRUCT!!!
    var horizontal = 0, vertical = 0
    var sum: Int { return horizontal + vertical }
}

func maxKilledEnemies(_ grid: [[Character]]) -> Int {
    if grid.count == 0 || grid[0].count == 0 { return 0 }
    var dataGrid = [[BombPoint]](repeating: [BombPoint](repeating: BombPoint(), count: grid[0].count), count: grid.count)
    
    // left to right to fill horizontal
    for i in 0..<dataGrid.count {
        var enemyKilled = 0, lastWall = -1   // last wall seen in this row
        for j in 0..<dataGrid[i].count {
            if grid[i][j] == "Y" {
                // between last wall and this wall, update # of enemy is killed
                for k in lastWall + 1 ..< j {
                    dataGrid[i][k].horizontal = enemyKilled
                }
                enemyKilled = 0
                lastWall = j
            }
            else if grid[i][j] == "X" { enemyKilled += 1 }
        }
        // update between lastWall and end of row
        for k in lastWall + 1 ..< dataGrid[i].count {
            dataGrid[i][k].horizontal = enemyKilled
        }
    }
    
    // up to bottom to fill vertical
    for j in 0..<dataGrid[0].count {
        var enemyKilled = 0, lastWall = -1   // last wall seen in this column
        for i in 0..<dataGrid.count {
            if grid[i][j] == "Y" {
                // between last wall and this wall, update # of enemy killed
                for k in lastWall + 1 ..< i {
                    dataGrid[k][j].vertical = enemyKilled
                }
                enemyKilled = 0
                lastWall = i
            }
            else if grid[i][j] == "X" { enemyKilled += 1 }
        }
        // update between lastWall and end of column
        for k in lastWall + 1 ..< dataGrid.count {
            dataGrid[k][j].vertical = enemyKilled
        }
    }
    
    var maxEnemies = 0
    // traverse data grid and find max
    for i in 0..<dataGrid.count {
        for j in 0..<dataGrid[i].count {
            maxEnemies = max(maxEnemies, dataGrid[i][j].sum)
        }
    }
    return maxEnemies
}
