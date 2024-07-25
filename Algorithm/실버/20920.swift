import Foundation
let firstLine = readLine()!.split(separator: " ").map { Int($0)! }
let N = firstLine[0]
let M = firstLine[1]

var wordCount: [String: Int] = [:]

for _ in 0..<N {
    let word = readLine()!
    if word.count >= M {
        wordCount[word, default: 0] += 1
    }
}

let sortedWords = wordCount.keys.sorted { word1, word2 in
    let count1 = wordCount[word1]!
    let count2 = wordCount[word2]!
    
    if count1 != count2 {
        return count1 > count2
    } else if word1.count != word2.count {
        return word1.count > word2.count
    } else {
        return word1 < word2
    }
}

for word in sortedWords {
    print(word)
}
