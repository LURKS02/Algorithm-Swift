import Foundation

struct Deque<T> {
    private var array: [T] = []
    private var index: Int = 0
    
    var isEmpty: Bool {
        array.count <= index
    }
    
    mutating func append(_ val: T) {
        array.append(val)
    }
    
    mutating func popleft() -> T {
        defer { index += 1 }
        return array[index]
    }
    
    mutating func pop() -> T {
        array.popLast()!
    }
    
}

let firstInput = readLine()!.split(separator: " ")

let N = Int(firstInput[0])!
let P = Int(firstInput[1])!
let K = Int(firstInput[2])!

var graph: [[(Int, Int)]] = Array(repeating: [], count: N+1)

for _ in 0..<P {
    let inputString = readLine()!.split(separator: " ")
    let com1 = Int(inputString[0])!
    let com2 = Int(inputString[1])!
    let cost = Int(inputString[2])!
    
    graph[com1].append((com2, cost))
    graph[com2].append((com1, cost))
}

var start = 0
var end = 1000000
var ans = -1


while start <= end {
    let mid = (start + end) / 2
    
    if BFS(mid: mid) {
        end = mid - 1
        ans = mid
    } else {
        start = mid + 1
    }
}

if ans == -1 {
    print(-1)
} else {
    print(ans)
}

func BFS(mid: Int) -> Bool {
    var deque = Deque<(Int, Int)>()
    deque.append((1, K))
    var visited: [[Bool]] = Array(repeating: Array(repeating: false, count: K+1), count: N+1)
    visited[1][K] = true
    
    while !deque.isEmpty {
        let (node, chance) = deque.popleft()
        
        if node == N { return true }
        
        for (neighbor, cost) in graph[node] {
            
            if cost <= mid && !visited[neighbor][chance] {
                visited[neighbor][chance] = true
                deque.append((neighbor, chance))
            }
            
            if cost > mid && chance > 0 && !visited[neighbor][chance-1] {
                visited[neighbor][chance-1] = true
                deque.append((neighbor, chance-1))
            }
        }
    }
    
    return false
}
