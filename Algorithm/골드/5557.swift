import Foundation

let N: Int = Int(readLine()!)!
let array: [Int] = readLine()!.split(separator: " ").map { Int($0)! }

// dp = [몇번째 수까지 봤는지][해당 수의 값] = 경우의 수
var dp: [[Int]] = Array(repeating: Array(repeating: 0, count: 21), count: N)

dp[0][array[0]] = 1

for i in 1..<N-1 {
    for j in 0...20 {
        if dp[i-1][j] != 0 {
            if j + array[i] <= 20 {
                dp[i][j+array[i]] += dp[i-1][j]
            }
            if j - array[i] >= 0 {
                dp[i][j-array[i]] += dp[i-1][j]
            }
        }
    }
}

print(dp[N-2][array[N-1]])
