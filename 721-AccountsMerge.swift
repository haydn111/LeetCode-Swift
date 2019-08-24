// Given a list accounts, each element accounts[i] is a list of strings, where the first element accounts[i][0] is a name, and the rest of the elements are emails representing emails of the account.

// Now, we would like to merge these accounts. Two accounts definitely belong to the same person if there is some email that is common to both accounts. Note that even if two accounts have the same name, they may belong to different people as people could have the same name. A person can have any number of accounts initially, but all of their accounts definitely have the same name.

// After merging the accounts, return the accounts in the following format: the first element of each account is the name, and the rest of the elements are emails in sorted order. The accounts themselves can be returned in any order.

// Example 1:
// Input: 
// accounts = [["John", "johnsmith@mail.com", "john00@mail.com"], ["John", "johnnybravo@mail.com"], ["John", "johnsmith@mail.com", "john_newyork@mail.com"], ["Mary", "mary@mail.com"]]
// Output: [["John", 'john00@mail.com', 'john_newyork@mail.com', 'johnsmith@mail.com'],  ["John", "johnnybravo@mail.com"], ["Mary", "mary@mail.com"]]
// Explanation: 
// The first and third John's are the same person as they have the common email "johnsmith@mail.com".
// The second John and Mary are different people as none of their email addresses are used by other accounts.
// We could return these lists in any order, for example the answer [['Mary', 'mary@mail.com'], ['John', 'johnnybravo@mail.com'], 
// ['John', 'john00@mail.com', 'john_newyork@mail.com', 'johnsmith@mail.com']] would still be accepted.
// Note:

// The length of accounts will be in the range [1, 1000].
// The length of accounts[i] will be in the range [1, 10].
// The length of accounts[i][j] will be in the range [1, 30].

class Solution {    // build graph + dfs/bfs. O(n)
    func accountsMerge(_ accounts: [[String]]) -> [[String]] {
        // build graph. Here only need a *partial* graph that can access all related email using the first email of each account.
        var graph = [String: Set<String>]() // email: neighbor_emails
        for acct in accounts {
            for i in 1..<acct.count {
                let email = acct[i]
                if graph[email] == nil { graph[email] = Set<String>() }
                graph[email]!.insert(acct[1])
                graph[acct[1]]!.insert(email)
            }
        }

        // traverse graph
        var visited = Set<String>()
        var result = [[String]]()
        for acct in accounts {
            let merged = [acct[0]] + bfs(email: acct[1], graph: graph, visited: &visited)
            result.append(merged.sorted())
        }
        return result
    }

    // return a list of email associated to the email passed in 
    func bfs(email: String, graph: [String: Set<String>], visited: inout Set<String>) -> [String] {
        var emails = [email]
        var queue = [email]
        while queue.count > 0 {
            var e = queue.removeFirst()
            visited.insert(e)
            emails.append(e)
            for neighbor in graph[e]! {
                if !visited.contains(neighbor) { queue.append(neighbor) }
            }
        }
        return emails
    }
}

print(accountsMerge([["John","johnsmith@mail.com","john_newyork@mail.com"],
                        ["John","johnsmith@mail.com","john00@mail.com"],
                        ["Mary","mary@mail.com"],
                        ["John","johnnybravo@mail.com"]]))


class NaiveSolution {
    class Person: NSObject {
        var name: String
        var emails = Set<String>()

        init(name: String, emails: [String]) {
            self.name = name
            self.emails = Set(emails)
        }
    }

    func accountsMerge(_ accounts: [[String]]) -> [[String]] {
        let accts = NSMutableDictionary()  // email: person
        let people = NSMutableSet()     // set holding all persons

        for acct in accounts {
            var emails = acct
            let name = emails.removeFirst()
            var person = Person(name: name, emails: emails)

            for email in emails {
                if let existingPerson = accts.object(forKey: email as NSString) as? Person {
                    // someone already owns this email.
                    person = existingPerson
                    for email in emails {
                        accts.setObject(existingPerson, forKey: email as NSString)
                        person.emails.insert(email)
                    }
                    break
                } else {   // first time see this email    
                    accts.setObject(person, forKey: email as NSString)
                }
            }

            people.add(person)
        }

        var result = [[String]]()
        for person in people {
            let acct = [(person as! Person).name] + Array((person as! Person).emails).sorted()
            result.append(acct)
        }
        return result
    }
}

