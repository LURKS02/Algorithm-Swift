struct Heap<T> {
    var elements: [T] = []
    var comparer: (T, T) -> Bool
    var count: Int { elements.count }
    
    init(comparer: @escaping (T, T) -> Bool) {
        self.comparer = comparer
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
            
            elements.swapAt(tempIdx, parentIdx)
            parentIdx = tempIdx
        }
    }
}

let N = Int(readLine()!)!

var selfcost: [Int] = []

for _ in 0..<N {
    let W = Int(readLine()!)!
    selfcost.append(W)
}

var graph: [[Int]] = []

for _ in 0..<N {
    let line = readLine()!.split(separator: " ").map { Int($0)! }
    graph.append(line)
}

struct Node: Comparable {
    let node: Int
    let cost: Int
    
    static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.cost < rhs.cost
    }
}

var totalSum = 0
var heap = Heap<Node>(comparer: <)
var visited = Set<Int>()

for i in 0..<N {
    heap.heappush(Node(node: i, cost: selfcost[i]))
}

while heap.count > 0 {
    if visited.count == N { break }
    
    let node = heap.heappop()!
    if visited.contains(node.node) { continue }
    visited.insert(node.node)
    
    totalSum += node.cost
    
    for neighbor in 0..<N {
        if neighbor == node.node { continue }
        if visited.contains(neighbor) { continue }
        heap.heappush(Node(node: neighbor, cost: graph[node.node][neighbor]))
    }
}


print(totalSum)
