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
let K = fIO.readInt()

var tempDList: [Int] = []

for _ in 0..<N {
    let D = fIO.readInt()
    tempDList.append(D)
}

tempDList.sort(by: >)

let DList = Array(tempDList.prefix(M))

struct Monster {
    let hp: Int
    let cost: Int
}

var monsters: [Monster] = []

for _ in 0..<K {
    let P = fIO.readInt()
    let Q = fIO.readInt()
    
    monsters.append(Monster(hp: P, cost: Q))
}

var maxValue = 0

for D in DList {
    // [단계][체력] = [단계-1][체력 + 소모] + 보상
    let maxTime: Int = 60 * 15
    var dp = Array(repeating: Array(repeating: -Int.max, count: maxTime + 1), count: monsters.count+1)
    dp[0][maxTime] = 0
    var maxCost = 0
    
    for i in 1..<monsters.count+1 {
        let haveToHit: Int = monsters[i-1].hp / D + ((monsters[i-1].hp % D > 0) ? 1 : 0)
        
        for j in stride(from: maxTime, to: -1, by: -1) {
            dp[i][j] = max(dp[i][j], dp[i-1][j])
            
            if j + haveToHit <= maxTime {
                dp[i][j] = max(dp[i][j], dp[i-1][j + haveToHit] + monsters[i-1].cost)
            }
            
            maxCost = max(maxCost, dp[i][j])
        }
    }
    
    maxValue += maxCost
}

print(maxValue)
