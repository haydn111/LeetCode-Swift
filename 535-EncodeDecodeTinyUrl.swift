// Note: This is a companion problem to the System Design problem: Design TinyURL.
// TinyURL is a URL shortening service where you enter a URL such as https://leetcode.com/problems/design-tinyurl and it returns a short URL such as http://tinyurl.com/4e9iAk.

// Design the encode and decode methods for the TinyURL service. There is no restriction on how your encode/decode algorithm should work. You just need to ensure that a URL can be encoded to a tiny URL and the tiny URL can be decoded to the original URL.


// 将长短链接进行一一映射. 我们可以使用两个Map来分别保存，
// Each url has an index k. k increment for every new url. Map1 = [longUrl: k], map2 = [k: longUrl].
// Encode: A string s contains all upper, lower case letters and numbers, length is 62. Keep appending s.charAt(k % 62) to shortUrl until k == 0
// Decode: k = 0. For each char in shortUrl backwards, k = k * 62 + s.indexOf(char)

class Codec {
    var map1 = [Int: String]()
    var map2 = [String: Int]()
    let s = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

    func encode(_ longUrl) -> String {
        var k = map1.count
        map2[longUrl] = k
        map1[k] = longUrl

        var shortUrl = ""
        while k > 0 {
            shortUrl.append(s[k % 62])
            k /= 62
        }
        return shortUrl
    }

    func decode(_ shortUrl) -> String {
        var k = 0
        for i in stride(from: shortUrl.count - 1, through: 0, by: -1) {
            k = k * 62 + s.index(of: shortUrl[i])
        }
        return map1[k]!
    }
}
