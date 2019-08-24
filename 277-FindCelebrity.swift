// Suppose you are at a party with n people (labeled from 0 ton - 1) and among them, there may exist one celebrity. The definition of a celebrity is that all the othern - 1 people know him/her but he/she does not know any of them.

// Now you want to find out who the celebrity is or verify that there is not one. The only thing you are allowed to do is to ask questions like: "Hi, A. Do you know B?" to get information of whether A knows B. You need to find out the celebrity (or verify there is not one) by asking as few questions as possible (in the asymptotic sense).

// You are given a helper function bool knows(a, b) which tells you whether A knows B. Implement a functionint findCelebrity(n), your function should minimize the number of calls toknows.

// Note: There will be exactly one celebrity if he/she is in the party. Return the celebrity's label if there is a celebrity in the party. If there is no celebrity, return-1.

// Solution: 
// If A knows B then a is not celebrity. Let candidate start from first person A, ask him if he knows each person. For the first person, X, A knows about, we know A is not celebrity. We also know the persons before X are not celebrity because A does not know them. Then X become the new cadidate.

func knows(_ a: Int, _ b: Int) -> Bool {
    return false
}

func validateCelebirty(_ candidate: Int, n: Int) -> Bool {
    for i in 0..<n {
        if i != candidate && (knows(candidate, i) || !knows(i, candidate)) {
            return false
        }
    }
    return true
}

func findCelebrity(_ n: Int) -> Int? {
    var candidate = 0
    for person in 1..<n {
        if knows(candidate, person) {
            candidate = person
        }
    }
    if validateCelebirty(candidate, n: n) {
        return candidate
    } else { return nil }
}