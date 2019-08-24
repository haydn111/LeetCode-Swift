// Given a picture consisting of black and white pixels, find the number of black lonely pixels.

// The picture is represented by a 2D char array consisting of 'B' and 'W', which means black and white pixels respectively.

// A black lonely pixel is character 'B' that located at a specific position where the same row and same column don't have any other black pixels.

// Example:

// Input: 
// [['W', 'W', 'B'],
//  ['W', 'B', 'W'],
//  ['B', 'W', 'W']]

// Output: 3
// Explanation: All the three 'B's are black lonely pixels.
// Note:

// The range of width and height of the input 2D array is [1,500].


// 思路：
// 可以记录下每个黑点的位置，以及每行、每列出现的黑点的个数。然后遍历每个黑点，如果发现它所在的行和列的黑点数都为1，那么它就是孤立黑点了。

func findLonelyPixel(_ picture: [[Character]]) -> Int {
    if picture.count == 0 || picture[0].count == 0 { return 0 }
    var blkCoordinates = [(Int, Int)]()
    
    var rows = [Int](repeating: 0, count: picture.count)
    var cols = [Int](repeating: 0, count: picture[0].count)
    for i in 0..<picture.count {
        for j in 0..<picture[0].count {
            if picture[i][j] == "B" {
                rows[i] += 1
                cols[j] += 1
                blkCoordinates.append((i, j))
            }
        }
    }    

    var result = 0
    for (i, j) in blkCoordinates {
        if rows[i] == 1 && cols[j] == 1 { result += 1 }
    }
    return result
}
