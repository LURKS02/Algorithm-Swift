let N = Int(readLine()!)!

struct Deque<T> {
    var elements: [T] = []
    var index = 0
    
    var isEmpty: Bool {
        elements.count <= index
    }
    
    mutating func append(_ element: T) {
        elements.append(element)
    }
    
    mutating func popleft() -> T {
        defer { index += 1 }
        return elements[index]
    }
}

var graph: [[Int]] = Array(repeating: [], count: N+1)

for _ in 0..<N {
    let line = readLine()!.split(separator: " ").map { Int($0)! }
    let t1 = line[0]
    let t2 = line[1]
    
    graph[t1].append(t2)
    graph[t2].append(t1)
}

var visited = Set<Int>()
var visitedList: [Int] = []

var cycle = Set<Int>()

func dfs(node: Int, previous: Int) {
    for neighbor in graph[node] {
        if neighbor == previous { continue }
        
        if !visited.contains(neighbor) {
            visited.insert(neighbor)
            visitedList.append(neighbor)
            
            dfs(node: neighbor, previous: node)
            
            visited.remove(neighbor)
            visitedList.popLast()
        } else {
            var put = false
            for i in 0..<visitedList.count {
                if visitedList[i] == neighbor { put = true }
                
                if put { cycle.insert(visitedList[i]) }
            }
            break
        }
    }
}

visited.insert(1)
visitedList.append(1)
dfs(node: 1, previous: 0)

struct Node {
    let node: Int
    let count: Int
}

func bfs(node: Int) -> Int {
    if cycle.contains(node) { return 0 }
    
    var visited = Set<Int>()
    var deq = Deque<Node>()
    deq.append(Node(node: node, count: 0))
    visited.insert(node)
    
    while !deq.isEmpty {
        let n = deq.popleft()
        
        for neighbor in graph[n.node] {
            if cycle.contains(neighbor) {
                return n.count + 1
            } else {
                if !visited.contains(neighbor) {
                    visited.insert(neighbor)
                    deq.append(Node(node: neighbor, count: n.count + 1))
                }
            }
        }
    }
    
    return -1
}

var answer: [Int] = []

for node in 1...N {
    answer.append(bfs(node: node))
}

print(answer.map { String($0) }.joined(separator: " "))
