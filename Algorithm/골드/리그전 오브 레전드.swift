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
let Q = fIO.readInt()

var teams: [Int] = []

for _ in 0..<N {
    let a = fIO.readInt()
    teams.append(a)
}

var pf = Array(repeating: 0, count: N+1)
var doublePf = Array(repeating: 0, count: N+1)

for i in 1..<N+1 {
    pf[i] = pf[i-1] + teams[i-1]
    doublePf[i] = doublePf[i-1] + Int(pow(Double(teams[i-1]), 2))
}

for _ in 0..<Q {
    let l = fIO.readInt()
    let r = fIO.readInt()
    
    let target = pf[r] - pf[l-1]
    print((target * target - (doublePf[r] - doublePf[l-1])) / 2)
}
