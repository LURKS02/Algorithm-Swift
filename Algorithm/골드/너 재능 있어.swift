let N = Int(readLine()!)!
let W = readLine()!.split(separator: " ").map { Int($0)! }

let M = Int(readLine()!)!
let L = readLine()!.split(separator: " ").map { Int($0)! }

let K = Int(readLine()!)!

var dp = Array(repeating: Array(repeating: -Int.max, count: M+1), count: N+1)

dp[0][0] = 0

for i in 0..<N+1 {
    for j in 0..<M+1 {
        if i > 0 && j > 0 {
            var haveToMinus: Int = 0
            
            if dp[i][j-1] % K == 0 {
                haveToMinus = L[j-1]
            } else if dp[i][j-1] > 0 {
                haveToMinus = min(dp[i][j-1] % K, L[j-1])
            } else if dp[i][j-1] < 0 {
                let temp = K + dp[i][j-1] % K
                haveToMinus = min(temp, L[j-1])
            }
            
            dp[i][j] = max(dp[i][j], dp[i-1][j] + W[i-1], dp[i][j-1] - haveToMinus)
        } else if i > 0 {
            dp[i][j] = max(dp[i][j], dp[i-1][j] + W[i-1])
        } else if j > 0 {
            var haveToMinus: Int = 0
            
            if dp[i][j-1] % K == 0 {
                haveToMinus = L[j-1]
            } else if dp[i][j-1] > 0 {
                haveToMinus = min(dp[i][j-1] % K, L[j-1])
            } else if dp[i][j-1] < 0 {
                let temp = K + dp[i][j-1] % K
                haveToMinus = min(temp, L[j-1])
            }
            dp[i][j] = max(dp[i][j], dp[i][j-1] - haveToMinus)
        } else {
            continue
        }
    }
}

print(dp[N][M])
