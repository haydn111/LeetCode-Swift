// We are stacking blocks to form a pyramid. Each block has a color which is a one letter string, like `'Z'`.

// For every block of color `C` we place not in the bottom row, we are placing it on top of a left block of color `A` and right block of color `B`. We are allowed to place the block there only if `(A, B, C)` is an allowed triple.

// We start with a bottom row of bottom, represented as a single string. We also start with a list of allowed triples allowed. Each allowed triple is represented as a string of length 3.

// Return true if we can build the pyramid all the way to the top, otherwise false.

// Example 1:
// Input: bottom = "XYZ", allowed = ["XYD", "YZE", "DEA", "FFF"]
// Output: true
// Explanation:
// We can stack the pyramid like this:
//     A
//    / \
//   D   E
//  / \ / \
// X   Y   Z

// This works because ('X', 'Y', 'D'), ('Y', 'Z', 'E'), and ('D', 'E', 'A') are allowed triples.

// Example 2:
// Input: bottom = "XXYX", allowed = ["XXX", "XXY", "XYX", "XYY", "YXZ"]
// Output: false
// Explanation:
// We can't stack the pyramid to the top.
// Note that there could be allowed triples (A, B, C) and (A, B, D) with C != D.

// Note:
// bottom will be a string with length in range [2, 8].
// allowed will have length in range [0, 200].
// Letters in all strings will be chosen from the set {'A', 'B', 'C', 'D', 'E', 'F', 'G'}.


// First build a 3d map to store all allowed strings. Then for each bottom level, build all its possible next level. Recursively test each next level. If one of them can reach level 1 then we can stack to the top.
// Note we need two dfs functions. One builds the next level 2d char array from allowed map. The other builds all possible next level strings.
var allowedMap = [Character: [Character: [Character]]]()
func pyramidTransition(_ bottom: String, _ allowed: [String]) -> Bool {
    // first build a 3d map that contains all allowed ways to build next level.
    for s in allowed {
        var c1 = s.first!, c2 = s[s.index(after: s.startIndex)], c3 = s.last!
        if allowedMap[c1] == nil { allowedMap[c1] = [Character: [Character]]() }
        if allowedMap[c1]![c2] == nil { allowedMap[c1]![c2] = [Character]() }
        allowedMap[c1]![c2]!.append(c3)
    }
    return dfs(bottom)
}

func dfs(_ curr: String) -> Bool {
    if curr.count == 1 { return true }
    
    var i = curr.startIndex, possibleNextLevels = [[Character]]()
    while i < curr.index(before: curr.endIndex) {
        var next = curr.index(after: i)
        if let top = allowedMap[curr[i]]?[curr[next]] {
            possibleNextLevels.append(top)
        } else { return false }
        i = next
    }
    var result = false
    for lvl in buildLevel(possibleNextLevels) {
        result = result || dfs(lvl)
    }
    return result
}

func buildLevel(_ chars: [[Character]]) -> [String] {
    if chars.count == 0 { return [] }
    if chars.count == 1 { return chars.first!.map { String($0) } }
    var nextChars = chars, currChars = nextChars.removeFirst()
    return buildLevel(nextChars).flatMap { partialString in
        return currChars.map { currChar in
            return String(currChar) + partialString
        }
    }
}
