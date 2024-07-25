import Foundation

func findRank(N: Int, newScore: Int, P: Int, scores: [Int]) -> Int {
    if N == 0 { return 1 }
    
    var rankList = scores
    var rank = 1
    
    for i in 0..<N {
        if newScore > rankList[i] {
            break
        }
        
        if newScore < rankList[i] {
            rank += 1
        }
    }
    
    if rank > P {
        return -1
    }
    
    if N == P && newScore <= rankList.last! {
        return -1
    }
    
    return rank
}

let input = readLine()!.split(separator: " ").map { Int($0)! }
let N = input[0]
let newScore = input[1]
let P = input[2]

var scores: [Int] = []

if N > 0 {
    scores = readLine()!.split(separator: " ").map { Int($0)! }
}

let result = findRank(N: N, newScore: newScore, P: P, scores: scores)
print(result)
