struct Deque<T> {
    var elements: [T] = []
    var first = 0
    
    var isEmpty: Bool {
        first >= elements.count
    }
    
    var count: Int {
        elements.count - first
    }
    
    mutating func append(_ element: T) {
        elements.append(element)
    }
    
    mutating func popleft() -> T {
        defer { first += 1 }
        return elements[first]
    }
}

let line1 = readLine()!.split(separator: " ").map { Int($0)! }
let N = line1[0]
let M = line1[1]

var matrix: [[Character]] = []

for _ in 0..<N {
    let line = Array(readLine()!)
    matrix.append(line)
}

var rx = -1
var ry = -1
var bx = -1
var by = -1
var gx = -1
var gy = -1

for i in 0..<N {
    for j in 0..<M {
        if matrix[i][j] == "O" {
            gx = i
            gy = j
        }
        if matrix[i][j] == "R" {
            rx = i
            ry = j
        }
        if matrix[i][j] == "B" {
            bx = i
            by = j
        }
    }
}

let dx = [0, 0, -1, 1]
let dy = [1, -1, 0, 0]

var deque = Deque<(Int, Int, Int, Int, Int)>()
deque.append((rx, ry, bx, by, 0))
var visited = Array(repeating: Array(repeating: Array(repeating: Array(repeating: false, count: 10), count: 10), count: 10), count: 10)
visited[rx][ry][bx][by] = true

var isPrinted = false

while !deque.isEmpty {
    let (crx, cry, cbx, cby, count) = deque.popleft()
    
    if count > 10 { continue }
    if cbx == gx && cby == gy {
        continue
    }
    
    if crx == gx && cry == gy {
        print(1)
        isPrinted = true
        break
    }
    
    for i in 0..<4 {
        var nrx = crx
        var nbx = cbx
        var nry = cry
        var nby = cby
        
        if i == 0 {
            if nry < nby {
                while matrix[cbx][nby + 1] != "#" {
                    nby += 1
                    if matrix[cbx][nby] == "O" { break }
                }
                while (matrix[crx][nry + 1] != "#") && !(crx == cbx && nry + 1 == nby) {
                    nry += 1
                    if matrix[crx][nry] == "O" { break }
                }
                if matrix[crx][nry + 1] == "O" { nry += 1 }
            } else {
                while matrix[crx][nry + 1] != "#" {
                    nry += 1
                    if matrix[crx][nry] == "O" { break }
                }
                while (matrix[cbx][nby + 1] != "#") && !(cbx == crx && nby + 1 == nry) {
                    nby += 1
                    if matrix[cbx][nby] == "O" { break }
                }
                if matrix[cbx][nby + 1] == "O" { nby += 1 }
            }
        } else if i == 1 {
            if nry < nby {
                while matrix[crx][nry - 1] != "#" {
                    nry -= 1
                    if matrix[crx][nry] == "O" { break }
                }
                while matrix[cbx][nby - 1] != "#" && !(cbx == crx && nby - 1 == nry) {
                    nby -= 1
                    if matrix[cbx][nby] == "O" { break }
                }
                if matrix[cbx][nby - 1] == "O" { nby -= 1 }
            } else {
                while matrix[cbx][nby - 1] != "#" {
                    nby -= 1
                    if matrix[cbx][nby] == "O" { break }
                }
                while matrix[crx][nry - 1] != "#" && !(crx == cbx && nry - 1 == nby) {
                    nry -= 1
                    if matrix[crx][nry] == "O" { break }
                }
                if matrix[crx][nry - 1] == "O" { nry -= 1 }
            }
        } else if i == 2 {
            if nrx < nbx {
                while matrix[nrx - 1][cry] != "#" {
                    nrx -= 1
                    if matrix[crx][nry] == "O" { break }
                }
                while matrix[nbx - 1][cby] != "#" && !(nbx - 1 == nrx && cby == cry) {
                    nbx -= 1
                    if matrix[nbx][cby] == "O" { break }
                }
                if matrix[nbx - 1][cby] == "O" {
                    nbx -= 1
                }
            } else {
                while matrix[nbx - 1][cby] != "#" {
                    nbx -= 1
                    if matrix[nbx][cby] == "O" { break }
                }
                while matrix[nrx - 1][cry] != "#" && !(nrx - 1 == nbx && cry == cby) {
                    nrx -= 1
                    if matrix[nrx][cry] == "O" { break }
                }
                if matrix[nrx - 1][cry] == "O" {
                    nrx -= 1
                }
            }
        } else {
            if nrx < nbx {
                while matrix[nbx + 1][cby] != "#" {
                    nbx += 1
                    if matrix[nbx][cby] == "O" { break }
                }
                while matrix[nrx + 1][cry] != "#" && !(nrx + 1 == nbx && cry == cby) {
                    nrx += 1
                    if matrix[nrx][cry] == "O" { break }
                }
                if matrix[nrx + 1][cry] == "O" { nrx += 1 }
            } else {
                while matrix[nrx + 1][cry] != "#" {
                    nrx += 1
                    if matrix[nrx][cry] == "O" { break }
                }
                while matrix[nbx + 1][cby] != "#" && !(nbx + 1 == nrx && cby == cry) {
                    nbx += 1
                    if matrix[nbx][cby] == "O" { break }
                }
                if matrix[nbx + 1][cby] == "O" { nbx += 1 }
            }
        }
        if visited[nrx][nry][nbx][nby] { continue }
        
        visited[nrx][nry][nbx][nby] = true
        deque.append((nrx, nry, nbx, nby, count+1))
    }
}

if !isPrinted {
    print(0)
}
