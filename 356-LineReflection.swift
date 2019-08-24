// Given n points on a 2D plane, find if there is such a line parallel to y-axis that reflect the given set of points.

// Example 1:
// Given points = [[1,1],[-1,1]], return true.

// Example 2:
// Given points = [[1,1],[-1,-1]], return false.

// Follow up:
// Could you do better than O(n2)?

// Hint:

// Find the smallest and largest x-value for all points.
// If there is a line then it should be at y = (minX + maxX) / 2.
// For each point, make sure that it has a reflected point in the opposite side.


// 首先我们找到所有点的横坐标的最大值和最小值，那么二者的平均值就是中间直线的横坐标，或者求所有横坐标的平均值也可得出分割线横坐标
// 然后我们遍历每个点，如果都能找到直线对称的另一个点，则返回true，反之返回false
func isReflected(_ points: [[Int]]) -> Bool {
    let centerX = points.reduce(0, { $0 + $1[0] }) / points.count
    var dict = [Int: Set<Int>]()    // y: Set of x
    for p in points {
        if p[0] == centerX { continue } // ignore any points on the reflection line
        if dict[p[1]] == nil { dict[p[1]] = Set() }
        dict[p[1]]!.insert(p[0])
    }
    
    for y in dict.keys {
        var xs = dict[y]!
        if xs.count % 2 != 0 { return false }   // not even number of pts for the y
        while xs.count > 0 {
            let x1 = xs.first!, x2 = 2 * centerX - x1
            if !xs.contains(x2) { return false }
            xs.remove(x1); xs.remove(x2)
        }
    }
    return true
}
