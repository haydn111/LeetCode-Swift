// On a 2D plane, we place stones at some integer coordinate points.  Each coordinate point may have at most one stone.
// Now, a move consists of removing a stone that shares a column or row with another stone on the grid.
// What is the largest possible number of moves we can make?

// Example 1:

// Input: stones = [[0,0],[0,1],[1,0],[1,2],[2,1],[2,2]]
// Output: 5

// Example 2:

// Input: stones = [[0,0],[0,2],[1,1],[2,0],[2,2]]
// Output: 3

// Example 3:

// Input: stones = [[0,0]]
// Output: 0

// Note:
//     1 <= stones.length <= 1000
//     0 <= stones[i][j] < 10000

struct Stone: Hashable {
    let x: Int
    let y: Int
    
    static func == (lhs: Stone, rhs: Stone) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
}

var neighborX = [Int: [Stone]]()
var neighborY = [Int: [Stone]]()
var stoneCollection = Set<Stone>()

func removeStones(_ stones: [[Int]]) -> Int {
    // build graph
    for s in stones {
        let stone = Stone(x: s[0], y: s[1])
        stoneCollection.insert(stone)
        
        if neighborX[stone.x] == nil {
            neighborX[stone.x] = [Stone]()
        }
        neighborX[stone.x]?.append(stone)
        
        if neighborY[stone.y] == nil {
            neighborY[stone.y] = [Stone]()
        }
        neighborY[stone.y]?.append(stone)
    }

    // count islands
    var islandCount = 0
    for s in stones {
        let stone = Stone(x: s[0], y: s[1])
        if stoneCollection.contains(stone) {
            removeAllConnectedStones(from: &stoneCollection, at: stone)
            islandCount += 1
        }
    }
    return stones.count - islandCount
}

func removeAllConnectedStones(from stoneCollection: inout Set<Stone>, at stone: Stone) {
    if let _ = stoneCollection.remove(stone) {
        if let horizontalNeighbors = neighborX[stone.x] {
            for s in horizontalNeighbors {
                removeAllConnectedStones(from: &stoneCollection, at: s)
            }
        }
        if let verticalNeighbors = neighborY[stone.y] {
            for s in verticalNeighbors {
                removeAllConnectedStones(from: &stoneCollection, at: s)
            }
        }
    }
}
