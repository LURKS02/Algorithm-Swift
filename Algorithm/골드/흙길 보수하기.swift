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
let L = fIO.readInt()

struct Road: Comparable {
    let start: Int
    let end: Int
    
    static func <(lhs: Road, rhs: Road) -> Bool {
        if lhs.start == rhs.start {
            return lhs.end < rhs.end
        } else {
            return lhs.start < rhs.start
        }
    }
}

var roads: [Road] = []

for _ in 0..<N {
    let start = fIO.readInt()
    let end = fIO.readInt()
    
    roads.append(Road(start: start, end: end-1))
}

roads.sort()

var newRoads: [Road] = []

var curStart = -2
var curEnd = -2

for road in roads {
    if road.start > curEnd + 1 {
        if curStart != -2 && curEnd != -2 {
            newRoads.append(Road(start: curStart, end: curEnd))
        }
        curStart = road.start
        curEnd = road.end
    } else {
        curEnd = max(curEnd, road.end)
    }
}

newRoads.append(Road(start: curStart, end: curEnd))

var overPoint: Int = -1
var totalCount: Int = 0
var roadIndex: Int = 0

while roadIndex < newRoads.count {
    if roadIndex == 0 {
        if overPoint == -1 {
            overPoint = newRoads[roadIndex].start + L - 1
            totalCount += 1
        } else {
            overPoint += L
            totalCount += 1
        }
    } else {
        if overPoint < newRoads[roadIndex].start {
            overPoint = newRoads[roadIndex].start + L - 1
            totalCount += 1
        } else if overPoint >= newRoads[roadIndex].start && overPoint < newRoads[roadIndex].end {
            overPoint += L
            totalCount += 1
        }
    }
    
    if overPoint >= newRoads[roadIndex].end {
        roadIndex += 1
    }
}

print(totalCount)
