import Foundation

let input = readLine()!.split(separator: " ").map { Int($0)! }
let (R, C) = (input[0], input[1])
var map = [[Character]]()

for _ in 0..<R {
    let row = Array(readLine()!)
    map.append(row)
}

let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]

var newMap = map

for i in 0..<R {
    for j in 0..<C {
        if map[i][j] == "X" {
            var seaCount = 0
            
            for dir in directions {
                let ni = i + dir.0
                let nj = j + dir.1
                
                if ni < 0 || ni >= R || nj < 0 || nj >= C || map[ni][nj] == "." {
                    seaCount += 1
                }
            }
            
            if seaCount >= 3 {
                newMap[i][j] = "."
            }
        }
    }
}

var minX = C, maxX = -1, minY = R, maxY = -1

for i in 0..<R {
    for j in 0..<C {
        if newMap[i][j] == "X" {
            minX = min(minX, j)
            maxX = max(maxX, j)
            minY = min(minY, i)
            maxY = max(maxY, i)
        }
    }
}

for i in minY...maxY {
    for j in minX...maxX {
        print(newMap[i][j], terminator: "")
    }
    print("")
}
