import Foundation

var input1 = readLine()!.split(separator: " ").map { Int($0)! }

let N: Int = input1[0]
let M: Int = input1[1]
let x: Int = input1[2]
let y: Int = input1[3]
let K: Int = input1[4]

var matrix: [[Int]] = []

var diceX: Int = x
var diceY: Int = y

for i in (0..<N) {
    var input2 = readLine()!.split(separator: " ").map { Int($0)! }
    
    matrix.append(input2)
}

var keywords: [Int] = readLine()!.split(separator: " ").map { Int($0)! }
var dice: [Int] = [0, 0, 0, 0, 0, 0]

for keyword in keywords {
    if keyword == 1 {
        let nx = diceX
        let ny = diceY + 1
        
        if nx < 0 || nx >= N || ny < 0 || ny >= M {
            continue
        }
        
        let temp: Int = dice[2]
        dice[2] = dice[1]
        dice[1] = dice[5]
        dice[5] = dice[3]
        dice[3] = temp
        
        if matrix[nx][ny] == 0 {
            matrix[nx][ny] = dice[5]
        } else {
            dice[5] = matrix[nx][ny]
            matrix[nx][ny] = 0
        }
        
        diceX = nx
        diceY = ny
        
    } else if keyword == 2 {
        let nx = diceX
        let ny = diceY - 1
        
        if nx < 0 || nx >= N || ny < 0 || ny >= M {
            continue
        }
        
        let temp: Int = dice[2]
        dice[2] = dice[3]
        dice[3] = dice[5]
        dice[5] = dice[1]
        dice[1] = temp
        
        if matrix[nx][ny] == 0 {
            matrix[nx][ny] = dice[5]
        } else {
            dice[5] = matrix[nx][ny]
            matrix[nx][ny] = 0
        }
        
        diceX = nx
        diceY = ny
    } else if keyword == 3 {
        let nx = diceX - 1
        let ny = diceY
        
        if nx < 0 || nx >= N || ny < 0 || ny >= M {
            continue
        }
        
        let temp: Int = dice[2]
        dice[2] = dice[4]
        dice[4] = dice[5]
        dice[5] = dice[0]
        dice[0] = temp
        
        if matrix[nx][ny] == 0 {
            matrix[nx][ny] = dice[5]
        } else {
            dice[5] = matrix[nx][ny]
            matrix[nx][ny] = 0
        }
        
        diceX = nx
        diceY = ny
    } else if keyword == 4 {
        let nx = diceX + 1
        let ny = diceY
        
        if nx < 0 || nx >= N || ny < 0 || ny >= M {
            continue
        }
        
        let temp: Int = dice[2]
        dice[2] = dice[0]
        dice[0] = dice[5]
        dice[5] = dice[4]
        dice[4] = temp
        
        if matrix[nx][ny] == 0 {
            matrix[nx][ny] = dice[5]
        } else {
            dice[5] = matrix[nx][ny]
            matrix[nx][ny] = 0
        }
        
        diceX = nx
        diceY = ny
    }
    
    print(dice[2])
}
