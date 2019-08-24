infix operator ++: AdditionPrecedence
extension String {
    static func +(left: String, right: String) -> String {
        var newStr = left
        newStr.append(right)
        newStr.append(left)
        return newStr
    }

    static prefix func + (str: String) -> String {
        var newStr = str
        newStr.append(str)
        return newStr
    }
    
    static func ++ (left: String, right: String) -> String {
        var newStr = left
        newStr.append(right)
        newStr.append(right)
        return newStr
    }
}

print(+"abc")
print("abc"+"123")
print("abc"++"123")