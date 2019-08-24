// Given a string, sort it in decreasing order based on the frequency of characters.

// Example 1:

// Input:
// "tree"

// Output:
// "eert"

// Explanation:
// 'e' appears twice while 'r' and 't' both appear once.
// So 'e' must appear before both 'r' and 't'. Therefore "eetr" is also a valid answer.
// Example 2:

// Input:
// "cccaaa"

// Output:
// "cccaaa"

// Explanation:
// Both 'c' and 'a' appear three times, so "aaaccc" is also a valid answer.
// Note that "cacaca" is incorrect, as the same characters must be together.
// Example 3:

// Input:
// "Aabb"

// Output:
// "bbAa"

// Explanation:
// "bbaA" is also a valid answer, but "Aabb" is incorrect.
// Note that 'A' and 'a' are treated as two different characters.


// Count the occurance of each char with hash map. Create a buckets array. buckets[i] = chars with i occurance. Then append chars to buckets[i]. Finally get construct the result string from back of the buckets.
func frequencySort(_ s: String) -> String {
    var dict = [Character: Int](), buckets = [String](repeating: "", count: s.count + 1),result = ""
    for char in s {
        if dict[char] == nil { dict[char] = 0 }
        dict[char]! += 1
    }
    for char in dict.keys {
        buckets[dict[char]!] += String(repeating: char, count: dict[char]!)
    }
    for i in stride(from: buckets.count - 1, through: 0, by: -1) {
        result += buckets[i]
    }
    return result
}
