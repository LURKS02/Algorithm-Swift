let line = readLine()!.split(separator: " ").map { Int($0)! }
let N = line[0]
let X = line[1]

// dp[LV][패티/번]
var dp: [[Int64]] = Array(repeating: [0, 0], count: N+1)
dp[0] = [1, 0]

for i in 1...N {
    dp[i] = [1 + 2 * dp[i-1][0], 2 + 2 * dp[i-1][1]]
}

print(getAnswer(N: N, X: Int64(X)))

func getAnswer(N: Int, X: Int64) -> Int64 {
    if X == 0 { return 0 }
    if N == 0 { return 1 }
    
    var answer: Int64 = 0
    var temp = X
    
    if temp > 0 {
        temp -= 1
    }
    
    if N > 0 && temp > dp[N-1][0] + dp[N-1][1] {
        answer += dp[N-1][0]
        temp -= dp[N-1][0] + dp[N-1][1]
    } else if N > 0 {
        answer += getAnswer(N: N-1, X: temp)
        temp = 0
    }
    
    if temp > 0 {
        temp -= 1
        answer += 1
    }
    
    if N > 0 && temp > dp[N-1][0] + dp[N-1][1] {
        answer += dp[N-1][0]
        temp -= dp[N-1][0] + dp[N-1][1]
    } else if N > 0 {
        answer += getAnswer(N: N-1, X: temp)
        temp = 0
    }
    
    if temp > 0 {
        temp -= 1
    }
    
    return answer
}
