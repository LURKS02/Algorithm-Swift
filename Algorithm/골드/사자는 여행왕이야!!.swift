import Foundation

// 라이노님 빠른 입력 FileIO 클래스
final class FileIO {
    private var buffer:[UInt8]
    private var index: Int

    init(fileHandle: FileHandle = FileHandle.standardInput) {
        buffer = Array(fileHandle.readDataToEndOfFile())+[UInt8(0)] // 인덱스 범위 넘어가는 것 방지
        index = 0
    }

    @inline(__always) private func read() -> UInt8 {
        defer { index += 1 }

        return buffer.withUnsafeBufferPointer { $0[index] }
    }

    @inline(__always) func readInt() -> Int {
        var sum = 0
        var now = read()
        var isPositive = true

        while now == 10 || now == 32 { // 공백과 줄바꿈 무시
            now = read()
        }
        
        if now == 45{ // 음수 처리
            isPositive.toggle()
            now = read()
        }
        
        while now >= 48, now <= 57 {
            sum = sum * 10 + Int(now-48)
            now = read()
        }

        return sum * (isPositive ? 1:-1)
    }

    @inline(__always) func readString() -> String {
        var str = ""
        var now = read()

        while now == 10
            || now == 32 { now = read() } // 공백과 줄바꿈 무시

        while now != 10
            && now != 32 && now != 0 {
                str += String(bytes: [now], encoding: .ascii)!
                now = read()
        }

        return str
    }
}

let fIO = FileIO()

let N = fIO.readInt()
let M = fIO.readInt()

struct Travel: Comparable {
    let start: Int
    let end: Int
    
    static func <(_ lhs: Travel, _ rhs: Travel) -> Bool {
        if lhs.start == rhs.start {
            return lhs.end < rhs.end
        } else {
            return lhs.start < rhs.start
        }
    }
}

var travels: [Travel] = []

for _ in 0..<M {
    let a = fIO.readInt()
    let b = fIO.readInt()
    
    travels.append(Travel(start: a, end: b))
}

travels.sort(by: <)

// dp = [단계][날짜] = 이 단계 + 날짜까지 최소 기간
var dp = Array(repeating: Array(repeating: Int.max, count: N+1), count: M+1)

for i in 0..<M+1 {
    dp[i][0] = 0
}

for i in 1...M {
    let travel = travels[i-1]
    
    for j in 0..<N+1 {
        dp[i][j] = min(dp[i-1][j], dp[i][j])
        
        if j < travel.start {
            dp[i][travel.end] = min(max(dp[i-1][j], travel.start - j - 1), dp[i][travel.end])
        }
    }
}

for i in 0..<N+1 {
    dp[M][i] = max(dp[M][i], N - i)
}

var minValue = Int.max

for i in 1..<N+1 {
    minValue = min(minValue, dp[M][i])
}

print(minValue)

