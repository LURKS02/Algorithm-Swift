let input1 = readLine()!.split(separator: " ").map { Int($0)! }

let N = input1[0]
let M = input1[1]
let K = input1[2]

var board: [[Character]] = []

for _ in 0..<N {
    let line = Array(readLine()!)
    board.append(line)
}

var answer1 = Array(repeating: Array(repeating: 1, count: M), count: N)
var answer2 = Array(repeating: Array(repeating: 1, count: M), count: N)

var start1: Character = "B"
var start2: Character = "W"

for i in 0..<N {
    if i % 2 == 0 {
        start1 = "B"
        start2 = "W"
    } else {
        start1 = "W"
        start2 = "B"
    }
    
    for j in 0..<M {
        if start1 == board[i][j] {
            answer1[i][j] = 0
        }
        if start2 == board[i][j] {
            answer2[i][j] = 0
        }
        
        if start1 == "B" {
            start1 = "W"
        } else {
            start1 = "B"
        }
        
        if start2 == "B" {
            start2 = "W"
        } else {
            start2 = "B"
        }
    }
}

for i in 0..<N {
    for j in 0..<M {
        let current = answer1[i][j]
        let left = i > 0 ? answer1[i-1][j] : 0
        let right = j > 0 ? answer1[i][j-1] : 0
        let mid = (i > 0 && j > 0) ? answer1[i-1][j-1] : 0
        
        answer1[i][j] = current + left + right - mid
        
        let current2 = answer2[i][j]
        let left2 = i > 0 ? answer2[i-1][j] : 0
        let right2 = j > 0 ? answer2[i][j-1] : 0
        let mid2 = (i > 0 && j > 0) ? answer2[i-1][j-1] : 0
        
        answer2[i][j] = current2 + left2 + right2 - mid2
    }
}

var answer = Int.max

for i in K-1..<N {
    for j in K-1..<M {
        let current1 = answer1[i][j]
        let left1 = i >= K ? answer1[i-K][j] : 0
        let right1 = j >= K ? answer1[i][j-K] : 0
        let mid1 = (i >= K && j >= K) ? answer1[i-K][j-K] : 0
        answer = min(answer, current1 - left1 - right1 + mid1)
        
        let current2 = answer2[i][j]
        let left2 = i >= K ? answer2[i-K][j] : 0
        let right2 = j >= K ? answer2[i][j-K] : 0
        let mid2 = (i >= K && j >= K) ? answer2[i-K][j-K] : 0
        answer = min(answer, current2 - left2 - right2 + mid2)
    }
}

print(answer)
