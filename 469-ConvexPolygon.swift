// Given a list of points that form a polygon when joined sequentially, find if this polygon is convex (Convex polygon definition).

// Note:

// There are at least 3 and at most 10,000 points.
// Coordinates are in the range -10,000 to 10,000.
// You may assume the polygon formed by given points is always a simple polygon (Simple polygon definition). In other words, we ensure that exactly two edges intersect at each vertex, and that edges otherwise don't intersect each other.
// Example 1:

// [[0,0],[0,1],[1,1],[1,0]]
// Answer: True

// Example 2:

// [[0,0],[0,10],[10,10],[10,0],[5,5]]
// Answer: False



/*
判断是否为凸多边形
For each vertex v(i), find the normal vector (cross product) of vector v(i)->v(i+1) and v(i+1)->v(i+2). If all the normal vectors have the same sign (some can be 0) on z direction, it is a convex polygon 

Cross product: v1 x v2 = (y1z2 - y2z1)i - (x1z2 - x2z1)j + (x1y2 - x2y1)k 
*/

func isConvex(_ points: [[Int]]) -> Bool {
    var lastZ = 0, n = points.count
    for i in 0...n {
        let x1 = points[(i + 1) % n][0] - points[i % n][0]
        let y1 = points[(i + 1) % n][1] - points[i % n][1]
        let x2 = points[(i + 2) % n][0] - points[(i + 1) % n][0]
        let y2 = points[(i + 2) % n][1] - points[(i + 1) % n][1]
        // z component of v1 x v2
        let z = x1 * y2 - x2 * y1
        if z * lastZ < 0 { return false }
        lastZ = z
    }
    return true
}
