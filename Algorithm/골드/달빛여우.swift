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

struct Heap<T> {
    var elements: [T] = []
    var comparer: (T, T) -> Bool
    
    var count: Int {
        elements.count
    }
    
    var isEmpty: Bool {
        elements.isEmpty
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
    
    private mutating func siftUp() {
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
    
    private mutating func siftDown() {
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

struct Deque<T> {
    var elements: [T] = []
    var index = 0
    
    var isEmpty: Bool {
        index >= elements.count
    }
    
    mutating func append(_ element: T) {
        elements.append(element)
    }
    
    mutating func popleft() -> T {
        defer { index += 1 }
        return elements[index]
    }
}

let fIO = FileIO()

let N = fIO.readInt()
let M = fIO.readInt()

struct Next {
    let node: Int
    let cost: Int
}
var graph: [[Next]] = Array(repeating: [], count: N+1)

for _ in 0..<M {
    let a = fIO.readInt()
    let b = fIO.readInt()
    let d = fIO.readInt()
    
    graph[a].append(Next(node: b, cost: d))
    graph[b].append(Next(node: a, cost: d))
}

var foxCost = Array(repeating: Int.max, count: N+1)
var wolfCost = Array(repeating: Array(repeating: Int.max, count: N+1), count: 2)

struct FoxNode: Comparable {
    let node: Int
    let value: Int
    
    static func < (lhs: FoxNode, rhs: FoxNode) -> Bool {
        return lhs.value < rhs.value
    }
}

var heap1 = Heap<FoxNode>(comparer: <)
heap1.heappush(FoxNode(node: 1, value: 0))
foxCost[1] = 0

while !heap1.isEmpty {
    let nd = heap1.heappop()!
    let node = nd.node
    let count = nd.value
    
    if foxCost[node] < count {
        continue
    }
    
    for next in graph[node] {
        let newCount = count + next.cost * 2
        if foxCost[next.node] > newCount {
            foxCost[next.node] = newCount
            heap1.heappush(FoxNode(node: next.node, value: newCount))
        }
    }
}

struct WolfNode: Comparable {
    let node: Int
    let value: Int
    let isDoubled: Bool
    
    static func < (lhs: WolfNode, rhs: WolfNode) -> Bool {
        return lhs.value < rhs.value
    }
}

var heap2 = Heap<WolfNode>(comparer: <)
heap2.heappush(WolfNode(node: 1, value: 0, isDoubled: false))
wolfCost[0][1] = 0

while !heap2.isEmpty {
    let nd = heap2.heappop()!
    let node = nd.node
    let value = nd.value
    let isDoubled = nd.isDoubled
    
    // 이 부분 떄문에 시간초과 났음
    
    if isDoubled {
        if wolfCost[1][node] < value {
            continue
        }
    } else {
        if wolfCost[0][node] < value {
            continue
        }
    }
    
    for next in graph[node] {
        if isDoubled {
            let newCount = value + next.cost * 4
            if wolfCost[0][next.node] > newCount {
                wolfCost[0][next.node] = newCount
                heap2.heappush(WolfNode(node: next.node, value: newCount, isDoubled: false))
            }
        } else {
            let newCount = value + next.cost
            
            if wolfCost[1][next.node] > newCount {
                wolfCost[1][next.node] = newCount
                heap2.heappush(WolfNode(node: next.node, value: newCount, isDoubled: true))
            }
        }
    }
}

var answer = 0

for i in 1...N {
    if foxCost[i] < wolfCost[0][i] && foxCost[i] < wolfCost[1][i] {
        answer += 1
    }
}

print(answer)
