// Given a collection of integers that might contain duplicates, nums, return all possible subsets (the power set).

// Note: The solution set must not contain duplicate subsets.

// Example:

// Input: [1,2,2]
// Output:
// [
//   [2],
//   [1],
//   [1,2,2],
//   [2,2],
//   [1,2],
//   []
// ]


/// Recursion
func subsetsWithDup(_ nums: [Int]) -> [[Int]] {
    return subsets(nums.sorted())
}

func subsets(_ nums: [Int]) -> [[Int]] {
    if nums.count == 0 {
        return [[]]
    }
    var mNums = nums
    var prefix = [mNums.removeFirst()]
    while let first = mNums.first, first == prefix.first! {
        prefix.append(first)
        mNums.removeFirst()
    }
    
    let restResult = subsets(mNums)
    var result = restResult
    // for this prefix of the same number, 
    // add 0, 1, 2, ..., all of the same number to solution
    for i in 1 ... prefix.count {
        result += restResult.map { [Int](prefix.prefix(i)) + $0 }
    }

    return result
}


/// Iteration
func subsetsWithDup(_ nums: [Int]) -> [[Int]] {
    var sortedNums = nums.sorted()
    var result = [[Int]()]
    while sortedNums.count > 0 {
        // treat series of dup numbers as a group
        var curr = sortedNums.removeFirst()
        var count = 1
        while sortedNums.count > 0 && sortedNums.first! == curr {
            sortedNums.removeFirst()
            count += 1
        }
        
        // for this group of curr, we could add 0, 1, 2, ..., all of the same number in this group
        var currResult = result
        for i in 1...count {
            let part = Array(repeating: curr, count: i)
            currResult += result.map { $0 + part }
        }
        
        result = currResult
    }
    return result
}    
