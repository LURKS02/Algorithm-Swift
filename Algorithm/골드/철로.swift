import Foundation

struct Heap<T: Comparable> {
    var elements: [T] = []
    var comparer: (T, T) -> Bool
    
    var isEmpty: Bool {
        elements.isEmpty
    }
    
    var count: Int {
        elements.count
    }
    
    init(comparer: @escaping (T, T) -> Bool) {
        self.comparer = comparer
    }
    
    mutating func heappush(_ element: T) {
        elements.append(element)
        siftUp()
    }
    
    mutating func heappop() -> T? {
        if elements.count == 0 { return nil }
        if elements.count == 1 { return elements.popLast()! }
        
        let temp = elements[0]
        elements[0] = elements.popLast()!
        if elements.count > 1 {
            siftDown()
        }
        
        return temp
    }
    
    mutating func siftUp() {
        var childIdx = elements.count - 1
        
        while childIdx > 0 {
            let parentIdx = (childIdx - 1) / 2
            if comparer(elements[childIdx], elements[parentIdx]) {
                elements.swapAt(childIdx, parentIdx)
                childIdx = parentIdx
            } else {
                return
            }
        }
    }
    
    mutating func siftDown() {
        var parentIdx = 0
        var cnt = elements.count
        
        while parentIdx < cnt {
            var leftChildIdx = parentIdx * 2 + 1
            var rightChildIdx = parentIdx * 2 + 2
            
            var tempIdx = parentIdx
            
            if leftChildIdx < cnt && comparer(elements[leftChildIdx], elements[tempIdx]) {
                tempIdx = leftChildIdx
            }
            if rightChildIdx < cnt && comparer(elements[rightChildIdx], elements[tempIdx]) {
                tempIdx = rightChildIdx
            }
            
            if parentIdx == tempIdx { break }
            
            elements.swapAt(tempIdx, parentIdx)
            parentIdx = tempIdx
        }
    }
}

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

struct Line: Comparable {
    var start: Int
    var end: Int
    
    static func < (_ lhs: Self, _ rhs: Self) -> Bool {
        if lhs.end == rhs.end {
            return lhs.start < rhs.start
        } else {
            return lhs.end < rhs.end
        }
    }
}

var rails: [Line] = []

for _ in 0..<N {
    let h = fIO.readInt()
    let o = fIO.readInt()
    
    rails.append(Line(start: min(h, o), end: max(h, o)))
}

rails.sort()

let d = fIO.readInt()

var maxCount = 0
var heap = Heap<Int>(comparer: <)

for rail in rails {
    let line = rail
    heap.heappush(line.start)
    let lineStart = rail.end - d
    
    while !heap.isEmpty && heap.elements[0] < lineStart {
        heap.heappop()
    }
    maxCount = max(maxCount, heap.count)
}

print(maxCount)
