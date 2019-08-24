// Given a sorted integer array where the range of elements are [lower, upper] inclusive, return its missing ranges.

// For example, given [0, 1, 3, 50, 75], lower = 0 and upper = 99, return ["2", "4->49", "51->74", "76->99"].

func findMissingRanges(_ array: [Int], _ lower: Int, _ upper: Int) -> [String] {
    if array.count == 0 {
        if lower == upper { return ["\(lower)"] }
        else { return ["\(lower)->\(upper)"] }
    }
    
    var result = [String]()
    if array.first! - lower > 0 {
        addRange(to: &result, lb: lower, ub: array.first! - 1)
    }
    for i in 0..<array.count - 1 {
        if array[i + 1] - array[i] > 1 {
            addRange(to: &result, lb: array[i] + 1, ub: array[i + 1] - 1)
        }
    }
    if upper - array.last! > 0 {
        addRange(to: &result, lb: array.last! + 1, ub: upper)
    }
    return result
}

func addRange(to array: inout [String], lb: Int, ub: Int) {
    if lb == ub { array.append(String(lb)) }
    else { array.append("\(lb)->\(ub)") }
}
