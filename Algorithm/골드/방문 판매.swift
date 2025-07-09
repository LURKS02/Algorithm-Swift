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
let X = fIO.readInt()
let Y = fIO.readInt()

struct Person {
    let x: Int
    let y: Int
}

var persons: [Person] = []

for _ in 0..<N {
    let x = fIO.readInt()
    let y = fIO.readInt()
    
    persons.append(.init(x: x, y: y))
}

// var dp = [단계][x판매 수][y판매 수]
var dp = Array(repeating: Array(repeating: Array(repeating: Int.max, count: Y+1), count: X+1), count: persons.count + 1)
var trace = Array(repeating: Array(repeating: Array(repeating: -1, count: Y+1), count: X+1), count: persons.count + 1)

dp[0][0][0] = 0

for i in 0..<persons.count {
    let personX = persons[i].x
    let personY = persons[i].y
    
    for x in 0...X {
        for y in 0...Y {
            if dp[i][x][y] == Int.max { continue }
            
            if dp[i+1][x][y] > dp[i][x][y] {
                dp[i+1][x][y] = dp[i][x][y]
                trace[i+1][x][y] = trace[i][x][y]
            }
            
            let newX = min(x + personX, X)
            let newY = min(y + personY, Y)
            if dp[i+1][newX][newY] > dp[i][x][y] + 1 {
                dp[i+1][newX][newY] = dp[i][x][y] + 1
                trace[i+1][newX][newY] = i
            }
        }
    }
}

if dp[persons.count][X][Y] != Int.max {
    print(dp[persons.count][X][Y])
    
    var minLastCustomer = Int.max
    for i in 1...persons.count {
        if dp[i][X][Y] == dp[persons.count][X][Y] {
            minLastCustomer = min(minLastCustomer, trace[i][X][Y])
        }
    }
    
    print(minLastCustomer + 1)
} else {
    print(-1)
}
