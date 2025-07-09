struct Deque<T> {
    var elements: [T] = []
    var index: Int = 0
    
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

struct Block {
    var x: Int
    var y: Int
    var value: Int
}

struct Point: Hashable {
    var x: Int
    var y: Int
}

let line = readLine()!.split(separator: " ").map { Int($0)! }

let W = line[0]
let H = line[1]
let N = Int(readLine()!)!

var deq = Deque<Block>()
var blocks = Set<Point>()
var lamps = Set<Point>()
var dusts = Set<Point>()

for _ in 0..<N {
    let line = readLine()!.split(separator: " ")
    
    let B = line[0]
    let X = Int(line[2])!
    let Y = Int(line[1])!
    
    let splits = B.split(separator: "_")
    
    if splits[1] == "block" {
        blocks.insert(Point(x: X, y: Y))
        deq.append(Block(x: X, y: Y, value: 16))
    } else if splits[1] == "dust" {
        dusts.insert(Point(x: X, y: Y))
    } else {
        lamps.insert(Point(x: X, y: Y))
    }
}

var matrix: [[Int]] = Array(repeating: Array(repeating: 0, count: W), count: H)

let dx: [Int] = [1, 0, -1, 0]
let dy: [Int] = [0, 1, 0, -1]

var lighted = Set<Point>()

while !deq.isEmpty {
    let block = deq.popleft()
    
    for i in 0..<4 {
        let newValue = block.value - 1
        
        guard newValue > 0 else { continue }
        
        let nx = block.x + dx[i]
        let ny = block.y + dy[i]
        
        guard 0 <= nx && nx < H && 0 <= ny && ny < W else { continue }
        
        if dusts.contains(Point(x: nx, y: ny)) && matrix[nx][ny] < newValue {
            matrix[nx][ny] = newValue
            deq.append(Block(x: nx, y: ny, value: newValue))
        } else if lamps.contains(Point(x: nx, y: ny)) {
            lighted.insert(Point(x: nx, y: ny))
        }
    }
}

print(lighted.count == lamps.count ? "success" : "failed")

