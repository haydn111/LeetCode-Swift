struct Trie<Element: Hashable> {
    let isElement: Bool
    let children: [Element: Trie<Element>]
}

extension Trie {
    init() {
        isElement = false
        children = [:]
    }
    
    init(_ key: [Element]) {
        if let (head, tail) = key.decompose {
            let children = [head: Trie(tail)]
            self = Trie(isElement: false, children: children)
        } else {
            self = Trie(isElement: true, children: [:])
        }
    }
    
    var elements: [[Element]] {
        // var result: [[Element]] = isElement ? [[]] : []
        return children.flatMap { (key, value) -> [[Element]] in
            value.elements.map { [key] + $0 }
        }
    }
    
    func lookup(_ key: [Element]) -> Bool {
        guard let (head, tail) = key.decompose else { return isElement }
        guard let subtrie = children[head] else { return false }
        return subtrie.lookup(tail)
    }
    
    func withPrefix(_ prefix: [Element]) -> Trie<Element>? {
        guard let (head, tail) = prefix.decompose else { return self }
        guard let remainder = children[head] else { return nil }
        return remainder.withPrefix(tail)
    }
    
    func insert(_ key: [Element]) -> Trie<Element> {
        guard let (head, tail) = key.decompose else {
            return Trie(isElement: true, children: children)
        }
        var newChildren = children
        if let nextTrie = children[head] {
            newChildren[head] = nextTrie.insert(tail)
        } else {
            newChildren[head] = Trie(tail)
        }
        return Trie(isElement: isElement, children: newChildren)
    }
}

extension Array {
    var decompose: (Element, [Element])? {
        return isEmpty ? nil : (self[startIndex], Array(self.dropFirst()))
    }
}
