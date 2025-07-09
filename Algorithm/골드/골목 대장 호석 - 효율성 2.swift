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
        if elements.count > 1 { siftDown() }
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
            
            if tempIdx == parentIdx { break }
            
            elements.swapAt(tempIdx, parentIdx)
            parentIdx = tempIdx
        }
    }
}

struct Node: Comparable {
    let current: Int
    let spend: Int
    
    static func < (lhs: Node, rhs: Node) -> Bool {
        lhs.spend < rhs.spend
    }
}

func shameRootDijkstra(start: Int, end: Int, shame: Int, money: Int) -> Int {
    var heap = Heap<Node>(comparer: <)
    heap.heappush(Node(current: start, spend: 0))
    var cost = Array(repeating: Int.max, count: N+1)
    cost[start] = 0
    
    while !heap.isEmpty {
        let node = heap.heappop()!
        
        if node.current == end {
            if money >= node.spend {
                return node.spend
            } else {
                return -1
            }
        }
        
        if graphKeys.contains(node.current) {
            for next in graph[node.current]! {
                let c = next.weight
                
                let newCost = node.spend + c
                if newCost < cost[next.next] && c <= shame {
                    cost[next.next] = newCost
                    heap.heappush(Node(current: next.next, spend: newCost))
                }
            }
        }
    }
    
    return -1
}


let fIO = FileIO()

let N = fIO.readInt()
let M = fIO.readInt()
let A = fIO.readInt()
let B = fIO.readInt()
let C = fIO.readInt()

struct Next {
    let next: Int
    let weight: Int
}

var graph: [Int: [Next]] = [:]
var graphKeys = Set<Int>()
var shames: [Int] = []

for _ in 0..<M {
    let r = fIO.readInt()
    let v = fIO.readInt()
    let money = fIO.readInt()
    if graphKeys.contains(r) {
        graph[r]!.append(Next(next: v, weight: money))
    } else {
        graph[r] = [Next(next: v, weight: money)]
        graphKeys.insert(r)
    }
    if graphKeys.contains(v) {
        graph[v]!.append(Next(next: r, weight: money))
    } else {
        graph[v] = [Next(next: r, weight: money)]
        graphKeys.insert(v)
    }
    
    shames.append(money)
}

shames.sort()

var left = 0
var right = shames.count - 1
var answer = Int.max
 
while left <= right {
    let mid = (left + right) / 2
    
    let totalCost = shameRootDijkstra(start: A, end: B, shame: shames[mid], money: C)
    
    if totalCost == -1 {
        left = mid + 1
    } else {
        right = mid - 1
        answer = min(answer, shames[mid])
    }
}

if answer == Int.max {
    print(-1)
} else {
    print(answer)
}
