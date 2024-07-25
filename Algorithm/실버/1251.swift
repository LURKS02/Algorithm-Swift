import Foundation

func findWord(word: String) -> String {
    let length = word.count
    var smallestWord = String(Array(repeating: "z", count: length))
    
    for i in 1..<length-1 {
        for j in i+1..<length {
            let part1 = String(word.prefix(i).reversed())
            let part2 = String(word[word.index(word.startIndex, offsetBy: i)..<word.index(word.startIndex, offsetBy: j)].reversed())
            let part3 = String(word.suffix(length-j).reversed())
            
            let newWord = part1+part2+part3
            
            if newWord < smallestWord {
                smallestWord = newWord
            }
        }
    }
    return smallestWord
}

let input = readLine()!
let result = findWord(word: input)
print(result)
