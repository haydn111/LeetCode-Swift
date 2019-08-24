class Solution {
    func getIndex(_ s: String, _ i: Int) -> String.Index {
        return s.index(s.startIndex, offsetBy: i)
    }
    
    func addBinary(_ a: String, _ b: String) -> String {
        var carry = 0
        var result = ""
        var first = a
        var second = b
        
        while (first.count > 0 || second.count > 0 || carry > 0) {
            var firstBit = 0, secondBit = 0
            if first.count > 0 { firstBit = Int(String(first.last!))! }
            if second.count > 0 { secondBit = Int(String(second.last!))! }
            switch firstBit + secondBit + carry {
                case 3:
                    result = "1" + result
                    carry = 1
                case 2: 
                    result = "0" + result
                    carry = 1
                case 1:
                    result = "1" + result
                    carry = 0
                default:
                    result = "0" + result
                    carry = 0
            }
            if first.count > 0 { first.remove(at: getIndex(first, first.count - 1)) }
            if second.count > 0 { second.remove(at: getIndex(second, second.count - 1)) }
        }
        
        return result
    }
}