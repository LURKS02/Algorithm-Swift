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
let Q = fIO.readInt()

var matrix: [[Int]] = []

var px: [[Int]] = Array(repeating: Array(repeating: 0, count: M), count: N)

for _ in 0..<N {
    var newList: [Int] = []
    
    for _ in 0..<M {
        let temp = fIO.readInt()
        newList.append(temp)
    }
    
    matrix.append(newList)
}


for j in 0..<M {
    px[0][j] = matrix[0][j]
}

for j in 0..<M {
    for i in 1..<N {
        px[i][j] = px[i-1][j] + matrix[i][j]
    }
}

for i in 1..<N {
    for j in 0..<M {
        if j == 0 { continue }
        
        px[i][j] += px[i-1][j-1]
    }
}

for _ in 0..<Q {
    let W = fIO.readInt()
    let P = fIO.readInt()
    
    print(px[W-1][P-1])
}
