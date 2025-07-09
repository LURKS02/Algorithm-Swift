import Foundation

let MOD = 1000000000
let N = Int(readLine()!)!

// dp = [길이 N까지][마지막 숫자][사용된 숫자의 비트마스크] = 계단수의 갯수
var dp: [[[Int]]] = Array(repeating: Array(repeating: Array(repeating: 0, count: 1024), count: 10), count: N)

for i in 1...9 {
    dp[0][i][1 << i] = 1
}

for i in 0..<N-1 {
    for j in 0...9 {
        for k in 0..<1024 {
            if dp[i][j][k] > 0 {
                if j > 0 {
                    dp[i+1][j-1][k | (1 << (j-1))] = (dp[i+1][j-1][k | 1 << (j-1)] + dp[i][j][k]) % MOD
                }
                if j < 9 {
                    dp[i+1][j+1][k | (1 << (j+1))] = (dp[i+1][j+1][k | 1 << (j+1)] + dp[i][j][k]) % MOD
                }
            }
        }
    }
}

var result = 0
let allDigitsUsed = (1 << 10) - 1

for i in 0...9 {
    result = (result + dp[N-1][i][allDigitsUsed]) % MOD
}

print(result)
