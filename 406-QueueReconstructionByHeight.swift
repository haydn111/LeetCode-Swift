// Suppose you have a random list of people standing in a queue. Each person is described by a pair of integers (h, k), where h is the height of the person and k is the number of people in front of this person who have a height greater than or equal to h. Write an algorithm to reconstruct the queue.

// Note:
// The number of people is less than 1,100.


// Example

// Input:
// [[7,0], [4,4], [7,1], [5,0], [6,1], [5,2]]

// Output:
// [[5,0], [7,0], [5,2], [6,1], [4,4], [7,1]]

// 按照ｈ降序排序，但是如果ｈ相等则按照ｋ升序排序．然后开一个新数组，因为数组按照降序排序，所以每次只需要将元素插入到新数组的k的位置即可．时间复杂度O(n*2)，
    func reconstructQueue(_ people: [[Int]]) -> [[Int]] {
        var sortedPeople = people.sorted(by: {
            if $0[0] == $1[0] {
                return $0[1] < $1[1]
            } else { return $0[0] > $1[0] }
        })
        // var result = Array(repeating: [Int](), count: people.count)
        var result = [[Int]]()
        for person in sortedPeople {
            result.insert(person, at: person[1])
        }
        return result
    }