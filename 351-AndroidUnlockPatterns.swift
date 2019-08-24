// Given an Android 3x3 key lock screen and two integers m and n, where 1 ≤ m ≤ n ≤ 9, count the total number of unlock patterns of the Android lock screen, which consist of minimum of m keys and maximum n keys.

// Rules for a valid pattern:

// Each pattern must connect at least m keys and at most n keys.
// All the keys must be distinct.
// If the line connecting two consecutive keys in the pattern passes through any other keys, the other keys must have previously selected in the pattern. No jumps through non selected key is allowed.
// The order of keys used matters.
 

// Explanation:

// | 1 | 2 | 3 |
// | 4 | 5 | 6 |
// | 7 | 8 | 9 |
 

// Invalid move: 4 - 1 - 3 - 6 
// Line 1 - 3 passes through key 2 which had not been selected in the pattern.

// Invalid move: 4 - 1 - 9 - 2
// Line 1 - 9 passes through key 5 which had not been selected in the pattern.

// Valid move: 2 - 4 - 1 - 3 - 6
// Line 1 - 3 is valid because it passes through key 2, which had been selected in the pattern

// Valid move: 6 - 5 - 4 - 1 - 9 - 2
// Line 1 - 9 is valid because it passes through key 5, which had been selected in the pattern.

// Example:
// Given m = 1, n = 1, return 9.

var jumps = [[Int]]()
var M = 0, N = 0
func numberOfPatterns(_ m: Int, _ n: Int) -> Int {
    M = m; N = n
    jumps = [[Int]](repeating: [Int](repeating: 0, count: 10), count: 10)
    jumps[1][3] = 2; jumps[3][1] = 2
    jumps[4][6] = 5; jumps[6][4] = 5
    jumps[7][9] = 8; jumps[9][7] = 8
    jumps[1][7] = 4; jumps[7][1] = 4
    jumps[2][8] = 5; jumps[8][2] = 5
    jumps[3][9] = 6; jumps[9][3] = 6
    jumps[1][9] = 5; jumps[9][1] = 5; jumps[3][7] = 5; jumps[7][3] = 5;
    var visited = Set<Int>(), result = 4 * searchPath(from: 1, 1, &visited)
    visited = Set<Int>(); result += 4 * searchPath(from: 2, 1, &visited)
    visited = Set<Int>(); result += searchPath(from: 5, 1, &visited)
    return result
}

func searchPath(from: Int, _ count: Int, _ visited: inout Set<Int>) -> Int {
    if count > N { return 0 }
    var result = 0
    if count >= M && count <= N { result += 1 }
    visited.insert(from)
    for i in 1...9 {
        if !visited.contains(i) &&
            (jumps[from][i] == 0 || visited.contains(jumps[from][i])) {
            result += searchPath(from: i, count + 1, &visited)
        }
    }
    visited.remove(from)
    return result
}
