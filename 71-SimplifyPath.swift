// Given an absolute path for a file (Unix-style), simplify it.

// For example,
// path = "/home/", => "/home"
// path = "/a/./b/../../c/", => "/c"

// Corner Cases:

// Did you consider the case where path = "/../"?
// In this case, you should return "/".
// Another corner case is the path might contain multiple slashes '/' together, such as "/home//foo/".
// In this case, you should ignore redundant slashes and return "/home/foo".

func simplifyPath(_ path: String) -> String {
    var components = path.split(separator: "/").map { String($0) }
    var simplifiedComponents = [String]()
    for c in components {
        if c == "." { continue }
        else if c == ".." {
            if simplifiedComponents.count > 0 { simplifiedComponents.removeLast() }
        }
        else { simplifiedComponents.append(c) }
    }
    return "/" + simplifiedComponents.joined(separator: "/")
}