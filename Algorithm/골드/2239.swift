import Foundation

var board = [[Int]]()

for _ in 0..<9 {
    let line = Array(readLine()!.map { Int(String($0))! })
//    print(line)
    board.append(line)
}

func isValid(_ x: Int, _ y: Int, _ val: Int) -> Bool {
    for i in 0..<9 {
        if board[x][i] == val || board[i][y] == val { return false }
    }
    
    let startRow = (x/3) * 3
    let startCol = (y/3) * 3
    
    for i in 0..<3 {
        for j in 0..<3 {
            if board[startRow+i][startCol+j] == val { return false }
        }
    }
    
    return true
}

func solve() -> Bool {
    for i in 0..<9 {
        for j in 0..<9 {
//            print(i, j)
            if board[i][j] == 0 {
                for val in 1...9 {
                    if isValid(i, j, val) {
                        board[i][j] = val
                        if solve() {
                            return true
                        }
                        board[i][j] = 0
                    }
                }
                return false
            }
        }
    }
    return true
}

if solve() {
    for row in board {
        print(row.map { String($0) }.joined(separator: ""))
    }
}
