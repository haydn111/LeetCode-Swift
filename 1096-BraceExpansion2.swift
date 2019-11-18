// Under a grammar given below, strings can represent a set of lowercase words.  Let's use R(expr) to denote the set of words the expression represents.

// Grammar can best be understood through simple examples:

//     Single letters represent a singleton set containing that word.
//         R("a") = {"a"}
//         R("w") = {"w"}
//     When we take a comma delimited list of 2 or more expressions, we take the union of possibilities.
//         R("{a,b,c}") = {"a","b","c"}
//         R("{{a,b},{b,c}}") = {"a","b","c"} (notice the final set only contains each word at most once)
//     When we concatenate two expressions, we take the set of possible concatenations between two words where the first word comes from the first expression and the second word comes from the second expression.
//         R("{a,b}{c,d}") = {"ac","ad","bc","bd"}
//         R("a{b,c}{d,e}f{g,h}") = {"abdfg", "abdfh", "abefg", "abefh", "acdfg", "acdfh", "acefg", "acefh"}

// Formally, the 3 rules for our grammar:

//     For every lowercase letter x, we have R(x) = {x}
//     For expressions e_1, e_2, ... , e_k with k >= 2, we have R({e_1,e_2,...}) = R(e_1) ∪ R(e_2) ∪ ...
//     For expressions e_1 and e_2, we have R(e_1 + e_2) = {a + b for (a, b) in R(e_1) × R(e_2)}, where + denotes concatenation, and × denotes the cartesian product.

// Given an expression representing a set of words under the given grammar, return the sorted list of words that the expression represents.

class Solution {
    enum Operator {
        case plus
        case multiply
    }

    enum ResultElement {
        case array(_ array: [String])
        case single(_ element: String)
        case op(_ operator: Operator)
        
        func wrappedValue() -> [String] {
            switch self {
            case .array(let array):
                return array
            case .single(let string):
                return [string]
            default:
                return []
            }
        }
        
        public static func + (lhs: ResultElement, rhs: ResultElement) -> ResultElement {
            var result = [String]()
            switch (lhs, rhs) {
            case (.array(let array1), .array(let array2)):
                result = array1 + array2
            case (.array(let array1), .single(let string2)):
                result += array1
                result.append(string2)
            case (.single(let string1), .array(let array2)):
                result.append(string1)
                result += array2
            case (.single(let string1), .single(let string2)):
                result = [string1, string2]
            default:
                fatalError("operator should not be concatenated")
            }
            return .array(result)
        }
        
        public static func * (lhs: ResultElement, rhs: ResultElement) -> ResultElement {
            var result = [String]()
            switch (lhs, rhs) {
            case (.array(let array1), .array(let array2)):
                result = array1 * array2
            case (.array(let array1), .single(let string2)):
                result = array1 * string2
            case (.single(let string1), .array(let array2)):
                result = string1 * array2
            default:
                fatalError("impossible to multiply two strings")
            }
            return .array(result)
        }
    }
        
    func braceExpansionII(_ expression: String) -> [String] {
        var resultElements = [ResultElement]()
        var i = expression.startIndex
        var j = i   // starting index of next iteration
        
        while i < expression.endIndex {
            let char = expression[i]
            if char == "," {
                resultElements.append(.op(.plus))
                j = expression.index(after: j)
            }
            else if char >= "a" && char <= "z" {
                // Find the end of this string
                j = expression.index(after: i)
                while j < expression.endIndex  {
                    if expression[j] >= "a" && expression[j] <= "z" {
                        j = expression.index(after: j)
                    } else {
                        break
                    }
                }
                
                // default to product if there is no operator
                if let lastResult = resultElements.last {
                    if case ResultElement.op(_) = lastResult {} else {
                        resultElements.append(.op(.multiply))
                    }
                }

                resultElements.append(.single(String(expression[i..<j])))
            }
            else if char == "{" {
                // Find the next matching "}" and recursion
                var count = 1
                j = expression.index(after: i)
                while j < expression.endIndex {
                    if expression[j] == "{" {
                        count += 1
                    } else if expression[j] == "}" {
                        count -= 1
                    }
                    if count == 0 {
                        break
                    }
                    j = expression.index(after: j)
                }
                // Now j is at the index of matching "}"
                if expression.index(after: i) <= expression.index(before: j) {  // If there is anything between "{" and "}"
                    let subExp = String(expression[expression.index(after: i)...expression.index(before: j)])
                    let innerResult = braceExpansionII(subExp)
                    
                    // default to product if there is no operator
                    if let lastResult = resultElements.last {
                        if case ResultElement.op(_) = lastResult {} else {
                            resultElements.append(.op(.multiply))
                        }
                    }
                    
                    resultElements.append(.array(innerResult))
                } else {    // empty brace "{}"
                    resultElements.append(.array([]))
                }
                
                j = expression.index(after: j)
            }
            
            // Perform multiply operation
            if resultElements.count >= 3,
                case ResultElement.op(let op) = resultElements[resultElements.count - 2],
                op == .multiply {
                let operand2 = resultElements.removeLast()
                resultElements.removeLast() // operator
                let operand1 = resultElements.removeLast()
                resultElements.append(operand1 * operand2)
            }
            
            // Prepare for next iteration
            i = j
        }

        // Perform plus operation
        var k = 1
        while k + 1 < resultElements.count {
            if case ResultElement.op(let op) = resultElements[k], op == .plus {
                let operand1 = resultElements.remove(at: k - 1)
                resultElements.remove(at: k - 1)    // operator
                let operand2 = resultElements.remove(at: k - 1)
                resultElements.insert(operand1 + operand2, at: k - 1)
            } else {
                k += 1
            }
        }
        
        let resultWithDup = resultElements.flatMap { (element) -> [String] in
            element.wrappedValue()
        }
        
        return Array(Set(resultWithDup)).sorted()
    }
}

extension String {
    // String x [String]
    public static func * (lhs: String, rhs: [String]) -> [String] {
        return rhs.map { y in "\(lhs)\(y)" }
    }
}

extension Array where Element == String {
    // [String] x String
    public static func * (lhs: Array, rhs: String) -> Array {
        return lhs.map { x in "\(x)\(rhs)" }
    }

    // [String] x [String]
    public static func * (lhs: Array, rhs: Array) -> Array {
        return lhs.flatMap { x in
            rhs.map { y in "\(x)\(y)" }
        }
    }
}
