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


struct Heap {
    var elements: [Int] = []
    var comparer: (Int, Int) -> Bool
    
    init(comparer: @escaping (Int, Int) -> Bool) {
        self.comparer = comparer
    }
    
    var count: Int {
        elements.count
    }
    
    mutating func push(_ data: Int) {
        elements.append(data)
        siftUp()
    }
    
    mutating func pop() -> Int? {
        if elements.count == 0 { return nil }
        else if elements.count == 1 { return elements.removeLast() }
        
        let temp = elements[0]
        elements[0] = elements.removeLast()
        
        if elements.count > 1 {
            siftDown()
        }
        
        return temp
    }
    
    mutating func siftUp() {
        var childIdx = elements.count - 1
        
        while childIdx > 0 {
            var parentIdx = (childIdx-1) / 2
            
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
            
            elements.swapAt(parentIdx, tempIdx)
            parentIdx = tempIdx
        }
    }
}

let fIO = FileIO()
let N = fIO.readInt()

var leftHeap = Heap(comparer: >)
var rightHeap = Heap(comparer: <)

var answer = ""

for _ in 0..<N {
    let num = fIO.readInt()
    
    if leftHeap.count == 0 || num <= leftHeap.elements[0] {
        leftHeap.push(num)
    } else {
        rightHeap.push(num)
    }
    
    if leftHeap.count > rightHeap.count + 1 {
        rightHeap.push(leftHeap.pop()!)
    } else if rightHeap.count > leftHeap.count {
        leftHeap.push(rightHeap.pop()!)
    }
    
    answer += "\(leftHeap.elements[0])\n"
}

print(answer)
