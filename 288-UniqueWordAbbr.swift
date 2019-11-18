// An abbreviation of a word follows the form <first letter><number><last letter>. Below are some examples of word abbreviations:

// a) it                      --> it    (no abbreviation)

//      1
// b) d|o|g                   --> d1g

//               1    1  1
//      1---5----0----5--8
// c) i|nternationalizatio|n  --> i18n

//               1
//      1---5----0
// d) l|ocalizatio|n          --> l10n
// Assume you have a dictionary and given a word, find whether its abbreviation is unique in the dictionary. A word's abbreviation is unique if no other word from the dictionary has the same abbreviation.

// Example: 
// Given dictionary = [ "deer", "door", "cake", "card" ]

// isUnique("dear") -> 
// false

// isUnique("cart") -> 
// true

// isUnique("cane") -> 
// false

// isUnique("make") -> 
// true


// Build a dict of [word_abbr: [words]] for the given dictionary. 
// Then if dict[abbr] == nil || (dict[abbr]!.count == 1 && that abbr is from current word), 
// return true

class ValidWordAbbr {
    var table = [String: Set<String>]()    // dict of [word_abbr: [words]]
    init(_ dict: [String]) {
        for s in dict {
            var abbr = getAbbr(of: s)
            if table[abbr] == nil { tabe[abbr] = Set<String>() }
            table[abbr].insert(s)
        }
    }

    func isUnique(_ word: String) -> Bool {
        var abbr = getAbbr(of: s)
        return table[abbr] == nil || 
                (table[abbr]!.count == 1 && table[abbr]!.contains(word))
    }

    func getAbbr(of s: String) -> String {
        if s.count <= 2 { return s }
        var abbr = "", str = s
        abbr.append(s.first!)
        str.removeFirst(); str.removeLast()
        abbr.append(str.count)
        abbr.append(s.last!)
        return abbr
    }
}