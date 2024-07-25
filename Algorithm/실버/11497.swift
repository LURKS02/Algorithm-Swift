let T = Int(readLine()!)!

func minDifficulty(logs: [Int]) -> Int {
    let sortedLogs = Array(logs.sorted().reversed())
    
    var maxDiff = -Int.max
    
    let biggestValue = sortedLogs[0]
    
    var leftVal = biggestValue
    var rightVal = biggestValue
    
    var now = 0
    for log in sortedLogs {
        if log == biggestValue { continue }
        
        if now % 2 == 0 {
            let diff = leftVal - log
            leftVal = log
            maxDiff = max(maxDiff, diff)
        }
        else {
            let diff = rightVal - log
            rightVal = log
            maxDiff = max(maxDiff, diff)
        }
        
        now += 1
    }
    
    maxDiff = max(maxDiff, abs(leftVal - rightVal))
    
    return maxDiff
}

for _ in 0..<T {
    let N = Int(readLine()!)!
    let trees = readLine()!.split(separator: " ").map { Int($0)! }
    print(minDifficulty(logs: trees))
}
