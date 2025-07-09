struct Heap<T: Comparable> {
    var elements: [T] = []
    var comparer: (T, T) -> Bool
    
    init(comparer: @escaping (T, T) -> Bool) {
        self.comparer = comparer
    }
    
    var count: Int {
        elements.count
    }
    
    mutating func heappush(_ element: T) {
        elements.append(element)
        siftUp()
    }
    
    mutating func heappop() -> T? {
        if elements.count == 0 { return nil }
        else if elements.count == 1 { return elements.removeLast() }
        
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
            var parentIdx = (childIdx-1) / 2
            
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
            
            if tempIdx == parentIdx { break }
            
            elements.swapAt(parentIdx, tempIdx)
            parentIdx = tempIdx
        }
    }
}

let line1 = readLine()!.split(separator: " ").map { Int($0)! }
let N = line1[0]
let M = line1[1]

let line2: [Character] = readLine()!.split(separator: " ").map { Character(String($0)) }

var graph: [[Neighbor]] = Array(repeating: [], count: N)

for _ in 0..<M {
    let line3: [Int] = readLine()!.split(separator: " ").map { Int($0)! }
    
    let u = line3[0]
    let v = line3[1]
    let d = line3[2]
    
    graph[u-1].append(Neighbor(node: v-1, cost: d))
    graph[v-1].append(Neighbor(node: u-1, cost: d))
}

struct Neighbor: Comparable {
    let node: Int
    let cost: Int
    
    static func < (lhs: Neighbor, rhs: Neighbor) -> Bool {
        lhs.cost < rhs.cost
    }
}

func prim(graph: [[Neighbor]], start: Int) -> Int {
    var visited = Array(repeating: false, count: graph.count)
    var heap = Heap<Neighbor>(comparer: <)
    heap.heappush(Neighbor(node: 0, cost: 0))
    var totalWeight = 0
    
    while heap.count != 0 {
        let neighbor = heap.heappop()!
        let gender = line2[neighbor.node]
        
        if visited[neighbor.node] { continue }
        
        visited[neighbor.node] = true
        totalWeight += neighbor.cost
        
        for next in graph[neighbor.node] {
            if !visited[next.node] && line2[next.node] != gender {
                heap.heappush(next)
            }
        }
    }
    
    var notVisited = false
    for visitedInfo in visited {
        if !visitedInfo { notVisited = true }
    }
    
    if notVisited {
        return -1
    } else {
        return totalWeight
    }
}

print(prim(graph: graph, start: 0))
