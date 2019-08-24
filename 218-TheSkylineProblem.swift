// https://leetcode.com/problems/the-skyline-problem/description/

// The geometric information of each building is represented by a triplet of integers [Li, Ri, Hi], where Li and Ri are the x coordinates of the left and right edge of the ith building, respectively, and Hi is its height. It is guaranteed that 0 ≤ Li, Ri ≤ INT_MAX, 0 < Hi ≤ INT_MAX, and Ri - Li > 0. You may assume all buildings are perfect rectangles grounded on an absolutely flat surface at height 0.

// For instance, the dimensions of all buildings in Figure A are recorded as: [ [2 9 10], [3 7 15], [5 12 12], [15 20 10], [19 24 8] ] .

// The output is a list of "key points" (red dots in Figure B) in the format of [ [x1,y1], [x2, y2], [x3, y3], ... ] that uniquely defines a skyline. A key point is the left endpoint of a horizontal line segment. Note that the last key point, where the rightmost building ends, is merely used to mark the termination of the skyline, and always has zero height. Also, the ground in between any two adjacent buildings should be considered part of the skyline contour.

// For instance, the skyline in Figure B should be represented as:[ [2 10], [3 15], [7 12], [12 0], [15 10], [20 8], [24, 0] ].

// Notes:

// The number of buildings in any input list is guaranteed to be in the range [0, 10000].
// The input list is already sorted in ascending order by the left x position Li.
// The output list must be sorted by the x position.
// There must be no consecutive horizontal lines of equal height in the output skyline. For instance, [...[2 3], [4 5], [7 5], [11 5], [12 7]...] is not acceptable; the three lines of height 5 should be merged into one in the final output as such: [...[2 3], [4 5], [12 7], ...]

// O(nlogn) Sweeping line algorithm with a Max Heap
class Building {
    enum EventType: Int {
        case enter = 1
        case exit = 0
    }
    var x: Int, height: Int, type: EventType
    init(_ x: Int, _ h: Int, _ t: EventType) {
        self.x = x; self.height = h; self.type = t
    }
}

class Solution {
    func getSkyline(_ buildings: [[Int]]) -> [[Int]] {
        // first preprocess budgs into the format (x, height, type), enter = 1, leave = 0
        var budgs = [Building]()
        for budg in buildings {
            budgs.append(Building(budg[0], budg[2], .enter))
            budgs.append(Building(budg[1], budg[2], .exit))
        }
        budgs = budgs.sorted(by: {
            if $0.x == $1.x {
                if $0.type != $1.type {
                    return $0.type.rawValue < $1.type.rawValue  // exit before enter
                } else if $0.type == .enter {
                    return $0.height < $1.height    // multiple enters at the same x, lowest enters first
                } else { // $0.type == .exit
                    return $0.height > $1.height    // multiple exits at the same x, hightest exits first
                }
            } else {
                return $0.x < $1.x  // sort by x position
            }
        })

        var result = [[Int]]()
        var heap = MaxHeap()    // supports insert, deleteMax in O(logn), getMax in O(1), remove in O(n)
        heap.insert(0)
        for budg in budgs {
            var record = false
            if budg.type == .enter {
                if budg.height > heap.getMax() { 
                    record = true
                }
                heap.insert(budg.height)
            } else {    // .exit
                if budg.height == heap.getMax() { 
                    record = true
                }
                heap.remove(budg.height)
            }
            if record {
                if let lastBudg = result.last, lastBudg[0] == budg.x {
                    result.removeLast()
                }
                if let lastBudg = result.last, lastBudg[1] == heap.getMax() {
                    continue
                }
                result.append([budg.x, heap.getMax()])
            }
        }
        return result
    }
}

class MaxHeap {
    var nums = [Int]()
    
    func insert(_ n: Int) {
        nums.append(n)
        // shift up
        var i = nums.count - 1
        while let parent = parent(of: i), nums[parent] < n {
            nums.swapAt(i, parent)
            i = parent
        }
    }
    
    func remove(_ n: Int) {
        guard var i = nums.index(of: n) else { return }
        nums.swapAt(i, nums.count - 1)
        nums.removeLast()
        // shift down
        var left = leftChild(of: i)
        var right = rightChild(of: i)
        while (left != nil && nums[i] < nums[left!]) || 
                (right != nil && nums[i] < nums[right!]) {
            var max = maxChild(left, right)!
            nums.swapAt(i, max) 
            i = max
            left = leftChild(of: i)
            right = rightChild(of: i)
        }
    }
    
    func getMax() -> Int {
        return nums[0]
    }
    
    private func parent(of i: Int) -> Int? {
        return (i - 1) / 2 >= 0 ? (i - 1) / 2 : nil
    }
    
    private func leftChild(of i: Int) -> Int? {
        return 2 * i + 1 < nums.count ? 2 * i + 1 : nil
    }
    
    private func rightChild(of i: Int) -> Int? {
        return 2 * i + 2 < nums.count ? 2 * i + 2 : nil
    }  
    
    private func maxChild(_ i1: Int?, _ i2: Int?) -> Int? {
        if i1 == nil { return i2 }
        if i2 == nil { return i1 }
        return nums[i1!] > nums[i2!] ? i1! : i2!
    }
}

// O(n^2) solution based on merging interval
func getSkyline(_ buildings: [[Int]]) -> [[Int]] {
    if buildings.count == 0 { return [] }
    var sortedBudgs = buildings.sorted(by: { $0[0] < $1[0] })
    var i = 0
    while i < sortedBudgs.count - 1 {
        let budg1 = sortedBudgs[i], budg2 = sortedBudgs[i + 1]
        let x11 = budg1[0], x12 = budg1[1], h1 = budg1[2]
        let x21 = budg2[0], x22 = budg2[1], h2 = budg2[2]
        if x12 <= x21 { // no intersection
            if x12 < x21 {  // there is space between budg1 and budg2
                sortedBudgs.insert([x12, x21, 0], at: i + 1)
                i += 2
            } else { i += 1 } 
        } else {    // has intersection
            if x12 >= x22 { // budg1 contains budg2
                if h2 > h1 {
                    sortedBudgs[i] = [x11, x21, h1]
                    // sortedBudgs[i + 1] = [x21, x22, h2]
                    var start = i + 2 
                    while start < sortedBudgs.count && sortedBudgs[start][0] < x22 { start += 1 }
                    sortedBudgs.insert([x22, x12, h1], at: start)
                    i += 1
                } else {    // budg2 completely inside budg1
                    sortedBudgs.remove(at: i + 1)
                }
            } else {    // budg1 and budg2 has some overlap
                if h2 > h1 {
                    sortedBudgs[i] = [x11, x21, h1]
                    // sortedBudgs[i + 1] = [x21, x22, h2]
                    i += 1
                } else {
                    sortedBudgs[i] = [x11, x12, h1]
                    sortedBudgs.remove(at: i + 1)
                    var start = i + 1
                    while start < sortedBudgs.count && sortedBudgs[start][0] < x12 { start += 1 }
                    sortedBudgs.insert([x12, x22, h2], at: start)
                }
            }
        }
    }
    var result = [[Int]]()
    var prevHeight = -1
    for i in 0..<sortedBudgs.count {
        if sortedBudgs[i][2] == prevHeight || sortedBudgs[i][1] == sortedBudgs[i][0] { continue }
        result.append([sortedBudgs[i][0], sortedBudgs[i][2]])
        prevHeight = sortedBudgs[i][2]
    }
    result.append([sortedBudgs.last![1], 0])    // append right edge of last building
    return result
}

print(getSkyline([[2,4,70],[3,8,30],[6,100,41],[7,15,70],[10,30,102],[15,25,76],[60,80,91],[70,90,72],[85,120,59]]))
