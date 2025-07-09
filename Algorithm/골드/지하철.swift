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

struct Heap<T: Comparable> {
    var elements: [T] = []
    var comparer: (T, T) -> Bool
    
    init(comparer: @escaping (T, T) -> Bool) {
        self.comparer = comparer
    }
    
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
        if elements.count == 1 { return elements.removeLast() }
        
        let temp = elements[0]
        elements[0] = elements.removeLast()
        
        if elements.count > 1 {
            siftDown()
        }
        
        return temp
    }
    
    private mutating func siftUp() {
        var childIdx = elements.count - 1
        
        while childIdx > 0 {
            var parentIdx = (childIdx - 1) / 2
            
            if comparer(elements[childIdx], elements[parentIdx]) {
                elements.swapAt(childIdx, parentIdx)
                childIdx = parentIdx
            } else { return }
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
            
            elements.swapAt(tempIdx, parentIdx)
            parentIdx = tempIdx
        }
    }
}

let fIO = FileIO()

let N = fIO.readInt()
let M = fIO.readInt()

var subways: [Int] = []

for _ in 0..<N {
    let C = fIO.readInt()
    subways.append(C)
}

struct Node: Comparable {
    let neighbor: Int
    let cost: Int
    
    static func <(lhs: Node, rhs: Node) -> Bool {
        lhs.cost < rhs.cost
    }
}

var graph = Array(repeating: [Node](), count: N)

for i in 0..<N {
    for j in 0..<N {
        let target = fIO.readInt()
        if target != 0 {
            graph[i].append(Node(neighbor: j, cost: target))
        }
    }
}

struct NodeCost {
    var transfer: Int
    var cost: Int
}

var dp = Array(repeating: NodeCost(transfer: Int.max, cost: Int.max), count: N)

struct HeapNode: Comparable {
    let node: Int
    let cost: Int
    let transfer: Int
    
    static func <(lhs: HeapNode, rhs: HeapNode) -> Bool {
        if lhs.transfer == rhs.transfer {
            return lhs.cost < rhs.cost
        } else {
            return lhs.transfer < rhs.transfer
        }
    }
}

var heap = Heap<HeapNode>(comparer: <)

heap.heappush(HeapNode(node: 0, cost: 0, transfer: 0))

while !heap.isEmpty {
    let heapNode = heap.heappop()!
    
    if heapNode.node == M {
        print(heapNode.transfer, heapNode.cost)
        break
    }
    
    for neighbor in graph[heapNode.node] {
        let nextNode = neighbor.neighbor
        let newTransfer = subways[heapNode.node] == subways[nextNode] ? heapNode.transfer : heapNode.transfer + 1
        let newCost = heapNode.cost + neighbor.cost
        
        if dp[nextNode].transfer > newTransfer {
            dp[nextNode].transfer = newTransfer
            dp[nextNode].cost = newCost
            heap.heappush(HeapNode(node: nextNode, cost: newCost, transfer: newTransfer))
        } else if dp[nextNode].transfer == newTransfer {
            if dp[nextNode].cost > newCost {
                dp[nextNode].transfer = newTransfer
                dp[nextNode].cost = newCost
                heap.heappush(HeapNode(node: nextNode, cost: newCost, transfer: newTransfer))
            }
        }
    }
}
