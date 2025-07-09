import Foundation

let N = Int(readLine()!)!
var matrix: [[Character]] = []

for _ in 0..<N {
    let line: [Character] = readLine()!.split(separator: " ").map { Character(String($0)) }
    matrix.append(line)
}

var teachers: [Point] = []

struct Point: Hashable {
    let x: Int
    let y: Int
}

let dx = [0, 0, -1, 1]
let dy = [1, -1, 0, 0]

for i in 0..<N {
    for j in 0..<N {
        if matrix[i][j] == "T" {
            teachers.append(Point(x: i, y: j))
        }
    }
}

func backtracking(count: Int) {
    if count == 3 {
        if isPossible() {
            print("YES")
            exit(0)
        } else {
            return
        }
    }
    
    for i in 0..<N {
        for j in 0..<N {
            if matrix[i][j] == "X" {
                matrix[i][j] = "O"
                backtracking(count: count+1)
                matrix[i][j] = "X"
            }
        }
    }
}

func isPossible() -> Bool {
    var isPossible = true
    
    for teacher in teachers {
        if !isPossible { break }
        
        for i in 0..<4 {
            var nx = teacher.x
            var ny = teacher.y
            
            while true {
                nx += dx[i]
                ny += dy[i]
                
                if nx < 0 || ny < 0 || nx >= N || ny >= N || matrix[nx][ny] == "O" {
                    break
                }
                
                if matrix[nx][ny] == "S" {
                    isPossible = false
                    break
                }
            }
        }
    }
    
    return isPossible
}

backtracking(count: 0)
print("NO")
