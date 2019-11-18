extension Character {
    var ascii: UInt32? {
        return String(self).unicodeScalars.filter { $0.isASCII }.first?.value
    }
    
    func isAlphanumeric() -> Bool {
        return (self >= "A" && self <= "Z") || (self >= "a" && self <= "z") || (self >= "0" && self <= "9")    
    }
}

extension String {
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
    subscript (range: CountableClosedRange<Int>) -> Substring {
        return self[index(startIndex, offsetBy: range.lowerBound)...index(startIndex, offsetBy: range.upperBound)]
    }

    mutating func remove(at i: Int) {
        let index = self.index(self.startIndex, offsetBy: i)
        if index != self.endIndex { self.remove(at: index) }
    }

}