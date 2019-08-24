// Given a sorted array of integers nums and integer values a, b and c. Apply a function of the form f(x) = ax^2 + bx + c to each element x in the array.

// The returned array must be in sorted order.

// Expected time complexity: O(n)

// Example:

// nums = [-4, -2, 2, 4], a = 1, b = 3, c = 5,
// Result: [3, 9, 15, 33]

// nums = [-4, -2, 2, 4], a = -1, b = 3, c = 5
// Result: [-23, -5, 1, 7]

// Use the property of parabola
func sortTransformedArray(_ nums: [Int], _ a: Int, _ b: Int, _ c: Int) -> [Int] {
    var transformed = nums.map { a * $0 * $0 + b * $0 + c }
    var result = [Int]()
    while transformed.count > 0 {
        var item = 0
        if (a > 0 && transformed.first! > transformed.last!) ||
            (a < 0 && transformed.first! < transformed.last!) {
            item = transformed.removeFirst()
        } else { item = transformed.removeLast() }
        result.append(item)
    }
    return a > 0 ? result.reversed() : result
}