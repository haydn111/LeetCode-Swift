// Given a picture consisting of black and white pixels, and a positive integer N, find the number of black pixels located at some specific row R and column C that align with all the following rules:

// Row R and column C both contain exactly N black pixels.
// For all rows that have a black pixel at column C, they should be exactly the same as row R
// The picture is represented by a 2D char array consisting of 'B' and 'W', which means black and white pixels respectively.

// Example:

// Input:                                            
// [['W', 'B', 'W', 'B', 'B', 'W'],    
//  ['W', 'B', 'W', 'B', 'B', 'W'],    
//  ['W', 'B', 'W', 'B', 'B', 'W'],    
//  ['W', 'W', 'B', 'W', 'B', 'W']] 

// N = 3
// Output: 6
// Explanation: All the bold 'B' are the black pixels we need (all 'B's at column 1 and 3).
//         0    1    2    3    4    5         column index                                            
// 0    [['W', 'B', 'W', 'B', 'B', 'W'],    
// 1     ['W', 'B', 'W', 'B', 'B', 'W'],    
// 2     ['W', 'B', 'W', 'B', 'B', 'W'],    
// 3     ['W', 'W', 'B', 'W', 'B', 'W']]    
// row index

// Take 'B' at row R = 0 and column C = 1 as an example:
// Rule 1, row R = 0 and column C = 1 both have exactly N = 3 black pixels. 
// Rule 2, the rows have black pixel at column C = 1 are row 0, row 1 and row 2. They are exactly the same as row R = 0.

// Note:

// The range of width and height of the input 2D array is [1,200].

// Still use rows and cols array but each element become an array
//     rows[i] = array of j such that picture[i][j] are blacks
//     col[j] = array of i such that picture[i][j] are blacks
// Use a hash map to count the identical rows. The key is the string of a row and the value is a collection of same rows.
// After traverse the matrix once we can use the above information to get answer.
func findBlackPixel(_ picture: [[Character]], _ N: Int) -> Int {
    if picture.count == 0 || picture[0].count == 0 { return 0 }
    var blkCoordinates = [(Int, Int)]()
    
    var rows = [[Int]](repeating: [Int](), count: picture.count)
    var cols = [[Int]](repeating: [Int](), count: picture[0].count)
    var rowsDict = [String: Set<Int>]()
    for i in 0..<picture.count {
        let key = String(picture[i])
        if rowsDict[key] == nil { rowsDict[key] = Set() }
        rowsDict[key]!.insert(i)
        for j in 0..<picture[0].count {
            if picture[i][j] == "B" {
                rows[i].append(j)
                cols[j].append(i)
                blkCoordinates.append((i, j))
            }
        }
    }

    var result = 0
    for (i, j) in blkCoordinates {
        if rows[i].count == N && cols[j].count == N {
            var sameRow = true, rowKey = String(picture[i])
            for row in cols[j] {
                if !rowsDict[rowKey]!.contains(row) { sameRow = false; break }
            }
            if sameRow { result += 1 }
        }
    }
    return result
}
