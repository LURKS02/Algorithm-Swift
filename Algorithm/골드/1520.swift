struct Deque<T> {
    private var deque: [T] = []
    private var first = 0
    
    init(_ list: [T]) {
        deque = list
    }
    
    var isEmpty: Bool {
        first >= deque.count
    }
    
    var count: Int {
        deque.count - first
    }
    
    mutating func popleft() -> T {
        defer { first += 1 }
        return deque[first]
    }
    
    mutating func append(_ element: T) {
        deque.append(element)
    }
}

let inputs1 = readLine()!.split(separator: " ").map { Int($0)! }

var map = [[Int]]()

let M = inputs1[0]
let N = inputs1[1]

for _ in 0..<M {
    let line = readLine()!.split(separator: " ").map { Int($0)! }
    map.append(line)
}

let INF = Int.max
var dp = Array(repeating: Array(repeating: INF, count: N), count: M)
var visited = Array(repeating: Array(repeating: false, count: N), count: M)

var deq = Deque<(Int, Int)>([])
deq.append((0, 0))

let dx = [0, 0, -1, 1]
let dy = [1, -1, 0, 0]

func dfs(_ x: Int, _ y: Int) -> Int {
    if dp[x][y] != INF {
        return dp[x][y]
    }
    
    if x == M-1 && y == N-1 {
        return 1
    }
    
    dp[x][y] = 0
    
    for i in 0..<4 {
        let nx = x + dx[i]
        let ny = y + dy[i]
        
        if 0 <= nx && nx < M && 0 <= ny && ny < N && !visited[nx][ny] && map[nx][ny] < map[x][y] {
            visited[nx][ny] = true
            dp[x][y] += dfs(nx, ny)
            visited[nx][ny] = false
        }
    }
    
    return dp[x][y]
}

print(dfs(0, 0))
