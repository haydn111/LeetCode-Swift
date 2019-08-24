// Given an array of strings, group anagrams together.

// Example:

// Input: ["eat", "tea", "tan", "ate", "nat", "bat"],
// Output:
// [
//   ["ate","eat","tea"],
//   ["nat","tan"],
//   ["bat"]
// ]
// Note:

// All inputs will be in lowercase.
// The order of your output does not matter.

func groupAnagrams(_ strs: [String]) -> [[String]] {
    var anagrams = [String: [String]]()
    for str in strs {
        let sortedStr = String(str.sorted())
        if anagrams[sortedStr] == nil { anagrams[sortedStr] = [String]() }
        anagrams[sortedStr]!.append(str)
    }
    return anagrams.map { key, value in return value }
}
