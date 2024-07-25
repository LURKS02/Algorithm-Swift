let input = readLine()!.split(separator: " ").map { Int($0)! }
let N = input[0]
let M = input[1]

struct Deque<T> {
    var deque: [T] = []
    var index = 0
    
    func isEmpty() -> Bool {
        return index >= deque.count
    }
    
    mutating func append(_ element: T) {
        deque.append(element)
    }
    
    mutating func popleft() -> T {
        defer { index += 1 }
        return deque[index]
    }
}

var matrix: [[Character]] = []

for i in 0..<N {
    let inputList = Array(readLine()!)
    matrix.append(inputList)
}

var startX = -1
var startY = -1

for i in 0..<N {
    for j in 0..<M {
        if matrix[i][j] == "I" {
            startX = i
            startY = j
        }
    }
}

let result = bfs(startX, startY)

if result == 0 {
    print("TT")
} else {
    print(result)
}

func bfs(_ x: Int, _ y: Int) -> Int {
    var metPerson = 0
    
    let dx: [Int] = [0, 0, -1, 1]
    let dy: [Int] = [1, -1, 0, 0]
    
    var deq = Deque<(Int, Int)>()
    var visited = Array(repeating: Array(repeating: false, count: M), count: N)
    
    deq.append((x, y))
    visited[x][y] = true
    
    while !deq.isEmpty() {
        let (currentX, currentY) = deq.popleft()
        
        if matrix[currentX][currentY] == "P" {
            metPerson += 1
        }
        
        for i in 0..<4 {
            let nx = currentX + dx[i]
            let ny = currentY + dy[i]
            
            if nx >= 0 && nx < N && ny >= 0 && ny < M && !visited[nx][ny] && matrix[nx][ny] != "X" {
                deq.append((nx, ny))
                visited[nx][ny] = true
            }
        }
    }
    
    return metPerson
}
