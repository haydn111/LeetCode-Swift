// Given a sorted array, two integers k and x, find the k closest elements to x in the array. The result should also be sorted in ascending order. If there is a tie, the smaller elements are always preferred.

// Example 1:
// Input: [1,2,3,4,5], k=4, x=3
// Output: [1,2,3,4]
// Example 2:
// Input: [1,2,3,4,5], k=4, x=-1
// Output: [1,2,3,4]
// Note:
// The value k is positive and will always be smaller than the length of the sorted array.
// Length of the given array is positive and will not exceed 104
// Absolute value of elements in the array and x will not exceed 104

func findClosestElements(_ arr: [Int], _ k: Int, _ x: Int) -> [Int] {
    if x <= arr.first! { return [Int](arr[0..<k]) }
    if x >= arr.last! { return [Int](arr[arr.count - k ... arr.count - 1]) }
    
    // find the largest index less than x
    var l = 0, r = arr.count - 1
    while l < r {
        let mid = l + (r - l) / 2
        if arr[mid] < x && arr[mid + 1] >= x { l = mid; break }
        else if arr[mid] >= x { r = mid - 1 }
        else { l = mid + 1 }
    }
    
    // use 2 pointers to pick x #s closest to x
    r = l + 1
    var result = [Int]()
    for _ in 0..<k {
        if l >= 0 && r < arr.count {
            if abs(arr[l] - x) <= abs(arr[r] - x) {
                result.insert(arr[l], at: 0)
                l -= 1
            } else {
                result.append(arr[r])
                r += 1
            }
        } else if l >= 0 {
            result.insert(arr[l], at: 0)
            l -= 1
        } else if r < arr.count {
            result.append(arr[r])
            r += 1
        }
    }
    return result
}
