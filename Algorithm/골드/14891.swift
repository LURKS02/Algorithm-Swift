import Foundation

let firstGear = readLine()!.map { Int(String($0))! }
let secondGear = readLine()!.map { Int(String($0))! }
let thirdGear = readLine()!.map { Int(String($0))! }
let fourthGear = readLine()!.map { Int(String($0))! }

var gearList: [[Int]] = [[-1], firstGear, secondGear, thirdGear, fourthGear]

let K = Int(readLine()!)!

func rotateGear(_ gear: [Int], direction: Int) -> [Int] {
    var tempGear = gear
    
    if direction == 1 {
        tempGear[0] = gear[7]
        tempGear[1] = gear[0]
        tempGear[2] = gear[1]
        tempGear[3] = gear[2]
        tempGear[4] = gear[3]
        tempGear[5] = gear[4]
        tempGear[6] = gear[5]
        tempGear[7] = gear[6]
    }
    
    else {
        tempGear[0] = gear[1]
        tempGear[1] = gear[2]
        tempGear[2] = gear[3]
        tempGear[3] = gear[4]
        tempGear[4] = gear[5]
        tempGear[5] = gear[6]
        tempGear[6] = gear[7]
        tempGear[7] = gear[0]
    }
    
    return tempGear
}

func getLeftState(_ gear: [Int]) -> Int {
    gear[6]
}

func getRightState(_ gear: [Int]) -> Int {
    gear[2]
}

func changeDirection(_ direction: Int) -> Int {
    if direction == 1 {
        return -1
    } else {
        return 1
    }
}

for _ in 0..<K {
    let input2 = readLine()!.split(separator: " ").map { Int($0)! }
    let gearNumber: Int = input2[0]
    let direction: Int = input2[1]
    
    var leftState = getLeftState(gearList[gearNumber])
    var rightState = getRightState(gearList[gearNumber])
    
    let tempGear = rotateGear(gearList[gearNumber], direction: direction)
    gearList[gearNumber] = tempGear
    
    
    var leftRotateDirection = direction
    for i in stride(from: gearNumber-1, to: 0, by: -1) {
        var nextGear = gearList[i]
        let rightState = getRightState(nextGear)
        if leftState == rightState { break }
        
        leftState = getLeftState(nextGear)
        leftRotateDirection = changeDirection(leftRotateDirection)
        nextGear = rotateGear(gearList[i], direction: leftRotateDirection)
        gearList[i] = nextGear
    }
    
    var rightRotateDirection = direction
    for i in stride(from: gearNumber + 1, to: gearList.count, by: 1) {
        var nextGear = gearList[i]
        var leftState = getLeftState(nextGear)
        if leftState == rightState { break }
        
        rightState = getRightState(nextGear)
        rightRotateDirection = changeDirection(rightRotateDirection)
        nextGear = rotateGear(gearList[i], direction: rightRotateDirection)
        gearList[i] = nextGear
    }
    
//    print(gearList)
//    print()
}

var count = 0

if gearList[1][0] == 1 {
    count += 1
}
if gearList[2][0] == 1 {
    count += 2
}
if gearList[3][0] == 1 {
    count += 4
}
if gearList[4][0] == 1 {
    count += 8
}
print(count)
