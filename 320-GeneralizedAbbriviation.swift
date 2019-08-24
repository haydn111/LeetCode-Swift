// Write a function to generate the generalized abbreviations of a word.

// Example:

// Given word = "word", return the following list (order does not matter):

// ["word", "1ord", "w1rd", "wo1d", "wor1", "2rd", "w2d", "wo2", "1o1d", "1or1", "w1r1", "1o2", "2r1", "3d", "w3", "4"]

func generateAbbreviations(_ s: String) -> [String] {
    return dfs(s)
}

func dfs(_ s: String) -> [String] {
    if s.count == 0 { return [""] }
    let nextResult = dfs(String(s.dropFirst()))
    return nextResult.flatMap { str -> [String] in
        var oneCount = 1, partial = str
        while let char = partial.first, let num = Int(String(char)) {
            oneCount += num
            partial.removeFirst()
        }
        return [String(s.first!) + str, String(oneCount) + partial]
    }
}
