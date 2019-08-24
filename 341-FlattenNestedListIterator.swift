// Given a nested list of integers, implement an iterator to flatten it.

// Each element is either an integer, or a list -- whose elements may also be integers or other lists.

// Example 1:
// Given the list [[1,1],2,[1,1]],

// By calling next repeatedly until hasNext returns false, the order of elements returned by next should be: [1,1,2,1,1].

// Example 2:
// Given the list [1,[4,[6]]],

// By calling next repeatedly until hasNext returns false, the order of elements returned by next should be: [1,4,6].

class NestedIterator {
    var list = [Int]()
    var curr = 0
    
    init(_ nestedList: [Any]) {
        list = buildList(from: nestedList)
    }
    
    func buildList(from nestedList: [Any]) -> [Int] {
        guard var item = nestedList.first else { return [] }
        var list = nestedList
        list.removeFirst()
        if item is Int {
            return [item as! Int] + buildList(from: list) 
        }
        else if item is [Int] {            
            return item as! [Int] + buildList(from: list) 
        } else {
            return buildList(from: item as! [Any]) + buildList(from: list)
        }
    }
    
    func next() -> Int? {
        if hasNext() { 
            curr += 1
            return list[curr - 1]
        }
        return nil
    }
    
    func hasNext() -> Bool {
        return curr < list.count
    }
}

var list: [Any] = [[1, 2], 3, [4, [5, [6, 7]], 8]]
let iterator = NestedIterator(list)
while iterator.hasNext() {
    print(iterator.next())
}