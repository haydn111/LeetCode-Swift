// Given an array nums of n integers, are there elements a, b, c in nums such that a + b + c = 0? Find all unique triplets in the array which gives the sum of zero.

// Note:

// The solution set must not contain duplicate triplets.

// Example:

// Given array nums = [-1, 0, 1, 2, -1, -4],

// A solution set is:
// [
//   [-1, 0, 1],
//   [-1, -1, 2]
// ]

class Solution {
    var myNums = [Int]()
    // use two pointers for two sum
    func threeSum(_ nums: [Int]) -> [[Int]] {
        var solution = [[Int]]()
        myNums = nums.sorted()    // nlgn
    
        var base = 0
        while base < myNums.count {
            var left = base + 1
            var right = myNums.count - 1

            let comp = 0 - myNums[base]
            while left < right {
                if myNums[left] + myNums[right] == comp {
                    solution.append([myNums[base], myNums[left], myNums[right]])
                    right = movePrev(from: right)
                    left = moveNext(from: left)
                } else if myNums[left] + myNums[right] > comp {
                    right = movePrev(from: right)
                } else {    // myNums[left] + myNums[right] < comp
                    left = moveNext(from: left)
                }
            }
            base = moveNext(from: base)
        }
        return solution
    }
    
    func moveNext(from i: Int) -> Int {
        var next = i + 1
        while next < myNums.count && myNums[next] == myNums[i] {
            next += 1
        }
        return next
    }
    
    func movePrev(from i: Int) -> Int {
        var prev = i - 1
        while prev >= 0 && myNums[prev] == myNums[i] {
            prev -= 1
        }
        return prev
    }

    // use dictionary for two sum
    func threeSum(_ nums: [Int]) -> [[Int]] {
        var solution = [[Int]]()
        myNums = nums.sorted()    // nlgn

        var base = 0
        while base < myNums.count {
            var store = Set<Int>()  // store the value have seen
            var used = Set<Int>()   // solution used.
            var sum = 0 - myNums[base]
            for i in base + 1..<myNums.count {
                if store.contains(sum - myNums[i]) &&
                    !used.contains(myNums[i]) && !used.contains(sum - myNums[i]) {
                    solution.append([myNums[base], myNums[i], sum - myNums[i]])
                    used.insert(myNums[i])
                    used.insert(sum - myNums[i])
                }
                store.insert(myNums[i])
            }
            base = moveNext(from: base)
        }
        return solution
    }
}