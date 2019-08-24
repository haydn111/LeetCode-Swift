// Leetcode 211

class TrieNode {
    var value: Character
    var parent: TrieNode?
    var children: [Character: TrieNode]
    var isTerminate: Bool

    init(_ value: Character) {
        self.value = value
        parent = nil
        children = [:]
        isTerminate = false
    }

    func isLeaf() -> Bool {
        return children.count == 0
    }
}

class Trie {
    var root: TrieNode
    var wordCount: Int

    init() {
        root = TrieNode(" ")
        wordCount = 0
    }

    func insert(_ word: String) {
        if word.count == 0 { return }
        var curr: TrieNode = root
        for char in Array(word) {
            if curr.children[char] == nil {
                let newNode = TrieNode(char)
                newNode.parent = curr
                curr.children[char] = newNode
            }
            curr = curr.children[char]!
        }
        curr.isTerminate = true
        wordCount += 1
    }

    func contains(_ word: String) -> Bool {
        if word.count == 0  { return false }
        var curr: TrieNode = root
        for char in Array(word) {
            if curr.children[char] == nil {
                return false
            }
            curr = curr.children[char]!
        }
        return curr.isTerminate
    }

    func remove(_ word: String) {
        if word.count == 0 { return }
        // 1. find the end of this word
        var curr: TrieNode = root
        for char in Array(word) {
            if curr.children[char] == nil {
                return  // word does not exist in trie
            }
            curr = curr.children[char]!
        }
        
        // 2. backtracking to delete nodes
        curr.isTerminate = false
        while curr.isLeaf() && !curr.isTerminate, let parent = curr.parent {
            parent.children[curr.value] = nil
            curr = parent
        }
        wordCount -= 1
    }

    func count() -> Int {
        return wordCount
    }

    func findWordsWithPrefix(_ prefix: String) -> [String] {
        if prefix.count == 0 { return [] }
        // 1. find the end of this prefix
        var curr = root
        for char in Array(prefix) {
            if curr.children[char] == nil {
                return []  // word does not exist in trie
            }
            curr = curr.children[char]!
        }

        // 2. find all string below the end of prefix
        let suffixes = findAllStrings(from: curr).map {
            return String($0.dropFirst())
        }

        return suffixes.map { prefix + $0 }
    }

     private func findAllStrings(from node: TrieNode) -> [String] {
        if node.isTerminate { 
            if node.isLeaf() { return [String(node.value)] }
            else { 
                return [String(node.value)] + (node.children.flatMap {
                    findAllStrings(from: $0.value)
                }.map { String(node.value) + $0 })
            }
        }
        return node.children.flatMap { 
            findAllStrings(from: $0.value)
        }.map { String(node.value) + $0 }
    }
}

// Test
let trie = Trie()
trie.insert("ab")
trie.insert("acf")
trie.insert("abcc")
trie.insert("abce")
trie.insert("abd")

print(trie.contains("ab"), trie.contains("acf"), trie.contains("abcc"), trie.contains("abce"), trie.contains("abd"), trie.contains("abcde"))

trie.remove("acf")
print(trie.contains("acf"))

print(trie.findWordsWithPrefix("ab"))

// Results:
// true true true true true false
// () false
// ["ab", "abcc", "abce", "abd"]