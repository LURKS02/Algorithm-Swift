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

struct Point {
    let x: Int
    let y: Int
}

var points: [Point] = []

for _ in 0..<N {
    let x = fIO.readInt()
    let y = fIO.readInt()
    
    points.append(Point(x: x, y: y))
}

points.sort(by: {
    if $0.x == $1.x {
        return $0.y < $1.y
    } else {
        return $0.x < $1.x
    }
})

var length = 0
var start = -1000000000
var end = -1000000000

for point in points {
    if start <= point.x && point.x <= end {
        end = max(end, point.y)
    }
    
    else if point.x > end {
        length += end - start
        start = point.x
        end = point.y
    }
}

length += end - start

print(length)
