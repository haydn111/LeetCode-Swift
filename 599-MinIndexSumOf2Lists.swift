// Suppose Andy and Doris want to choose a restaurant for dinner, and they both have a list of favorite restaurants represented by strings.

// You need to help them find out their common interest with the least list index sum. If there is a choice tie between answers, output all of them with no order requirement. You could assume there always exists an answer.

// Example 1:
// Input:
// ["Shogun", "Tapioca Express", "Burger King", "KFC"]
// ["Piatti", "The Grill at Torrey Pines", "Hungry Hunter Steakhouse", "Shogun"]
// Output: ["Shogun"]
// Explanation: The only restaurant they both like is "Shogun".

// Example 2:
// Input:
// ["Shogun", "Tapioca Express", "Burger King", "KFC"]
// ["KFC", "Shogun", "Burger King"]
// Output: ["Shogun"]
// Explanation: The restaurant they both like and have the least index sum is "Shogun" with index sum 1 (0+1).

// Note:
// The length of both lists will be in the range of [1, 1000].
// The length of strings in both lists will be in the range of [1, 30].
// The index is starting from 0 to the list length minus 1.
// No duplicates in both lists.

func findRestaurant(_ list1: [String], _ list2: [String]) -> [String] {
    var dict = [String: Int]()  // dict of name and index
    var i = 0
    while i < list1.count {
        dict[list1[i]] = i
        i += 1
    }
    
    var minIndexSum = Int.max
    var result = [String]()
    i = 0
    while i < list2.count {
        if let indexInList1 = dict[list2[i]] {
            if i + indexInList1 == minIndexSum {
                result.append(list2[i])
            }
            if i + indexInList1 < minIndexSum {
                minIndexSum = i + indexInList1
                result = [list2[i]]
            }
        }
        i += 1
    }
    return result
}