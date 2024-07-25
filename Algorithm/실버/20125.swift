let N = Int(readLine()!)!

var board: [[Character]] = []

for _ in 0..<N {
    board.append(Array(readLine()!))
}

var targetX = -1
var targetY = -1

for i in 1..<N-1 {
    for j in 1..<N-1 {
        if board[i-1][j] == "*" && board[i+1][j] == "*" && board[i][j-1] == "*" && board[i][j+1] == "*" {
            targetX = i
            targetY = j
        }
    }
}

var leftArm = 0
for i in stride(from: targetY-1, to: -1, by: -1) {
    if board[targetX][i] == "*" {
        leftArm += 1
    }
}

var rightArm = 0
for i in targetY+1...N-1 {
    if board[targetX][i] == "*" {
        rightArm += 1
    }
}

var middle = 0
for i in targetX+1...N-1 {
    if board[i][targetY] == "*" {
        middle += 1
    }
}

var leftLeg = 0
for i in targetX + middle + 1...N-1 {
    if board[i][targetY-1] == "*" {
        leftLeg += 1
    }
}

var rightLeg = 0
for i in targetX + middle + 1...N-1 {
    if board[i][targetY+1] == "*" {
        rightLeg += 1
    }
}


print(targetX+1, targetY+1)
print(leftArm, rightArm, middle, leftLeg, rightLeg)
