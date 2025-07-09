struct Data: Comparable {
    let x: Int
    let y: Int
    let cost: Int
    let chance: Int
    
    static func < (lhs: Data, rhs: Data) -> Bool {
        lhs.cost < rhs.cost
    }
}

class Heap<T: Comparable> {
    var elements: [T] = []
    
    var isEmpty: Bool {
        elements.isEmpty
    }
    
    func push(_ data: T) {
        elements.append(data)
        siftUp()
    }
    
    func pop() -> T {
        if elements.count == 1 {
            return elements.removeLast()
        }
        
        let temp = elements[0]
        elements[0] = elements.removeLast()
        
        if elements.count > 1 { siftDown() }
        
        return temp
    }
    
    func siftUp() {
        var childIdx = elements.count - 1
        while childIdx > 0 {
            var parentIdx = (childIdx - 1) / 2
            
            if elements[childIdx] >= elements[parentIdx] { return }
            
            elements.swapAt(childIdx, parentIdx)
            childIdx = parentIdx
        }
    }
    
    func siftDown() {
        var parentIdx = 0
        var cnt = elements.count
        
        while parentIdx < cnt {
            var leftChildIdx = parentIdx * 2 + 1
            var rightChildIdx = parentIdx * 2 + 2
            var tmpIdx = parentIdx
            
            if leftChildIdx < cnt && elements[leftChildIdx] < elements[parentIdx] {
                tmpIdx = leftChildIdx
            }
            
            if rightChildIdx < cnt && elements[rightChildIdx] < elements[tmpIdx] {
                tmpIdx = rightChildIdx
            }
            
            if parentIdx == tmpIdx { break }
            
            elements.swapAt(parentIdx, tmpIdx)
            parentIdx = tmpIdx
        }
    }
}

let inputs1 = readLine()!.split(separator: " ").map { Int($0)! }

let N = inputs1[0]
let M = inputs1[1]
let T = inputs1[2]

var matrix: [[Int]] = []
for _ in 0..<N {
    let line = readLine()!.split(separator: " ").map { Int($0)! }
    matrix.append(line)
}

let INF = Int.max
var heap = Heap<Data>()
let d = Data(x: 0, y: 0, cost: 0, chance: 0)
heap.push(d)
var costs = Array(repeating: Array(repeating: Array(repeating: INF, count: 2), count: M), count: N)

let dx = [0, 0, -1, 1]
let dy = [1, -1, 0, 0]

var isPrinted = false

while !heap.isEmpty {
    let data = heap.pop()
    
    let x = data.x
    let y = data.y
    let cost = data.cost
    var chance = data.chance
    
    let newCount = cost+1
    
    if newCount > T {
        continue
    }
    
    for i in 0..<4 {
        let nx = x + dx[i]
        let ny = y + dy[i]
        
        if 0 <= nx && nx < N && 0 <= ny && ny < M {
            if chance == 1 {
                if costs[nx][ny][chance] > newCount {
                    costs[nx][ny][chance] = newCount
                    let newData = Data(x: nx, y: ny, cost: newCount, chance: chance)
                    heap.push(newData)
                }
            } else {
                if matrix[nx][ny] != 1 {
                    if matrix[nx][ny] == 2 {
                        if costs[nx][ny][1] > newCount {
                            costs[nx][ny][1] = newCount
                            let newData = Data(x: nx, y: ny, cost: newCount, chance: 1)
                            heap.push(newData)
                        }
                    } else {
                        if costs[nx][ny][chance] > newCount {
                            costs[nx][ny][chance] = newCount
                            let newData = Data(x: nx, y: ny, cost: newCount, chance: chance)
                            heap.push(newData)
                        }
                    }
                }
            }
        }
    }
}

let answer = costs[N-1][M-1].min()!

if answer == INF {
    print("Fail")
} else {
    print(answer)
}
