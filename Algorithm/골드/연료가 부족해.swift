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

let R = fIO.readInt()
let C = fIO.readInt()
let N = fIO.readInt()

struct Station: Comparable {
    let r: Int
    let c: Int
    let f: Int
    
    static func <(lhs: Station, rhs: Station) -> Bool {
        return lhs.r + lhs.c < rhs.r + rhs.c
    }
}

var stations: [Station] = []

for _ in 0..<N {
    let r = fIO.readInt()
    let c = fIO.readInt()
    let f = fIO.readInt()
    
    stations.append(Station(r: r-1, c: c-1, f: f))
}

stations.append(Station(r: 0, c: 0, f: 0))
stations.append(Station(r: R-1, c: C-1, f: 0))

stations.sort()

var left = 1
var right = 5998
var answer = 1

func check(mid: Int, stations: [Station], R: Int, C: Int) -> Bool {
    var dp: [Int] = Array(repeating: -Int.max, count: stations.count)
    dp[0] = mid
    
    for i in 1..<stations.count {
        for j in 0..<i {
            if stations[i].r >= stations[j].r && stations[i].c >= stations[j].c {
                let dist = (stations[i].r - stations[j].r) + (stations[i].c - stations[j].c)
                if dist <= dp[j] {
                    dp[i] = max(dp[i], dp[j] - dist + stations[i].f)
                }
            }
        }
    }
    
    if dp[dp.count - 1] >= 0 {
        return true
    } else {
        return false
    }
}

while left <= right {
    let mid = (left + right) / 2
    
    if check(mid: mid, stations: stations, R: R-1, C: C-1) {
        answer = mid
        right = mid - 1
    } else {
        left = mid + 1
    }
}

print(answer)
