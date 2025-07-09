while true {
    let testCase: String = readLine()!
    if testCase == "end" { break }
    
    var board = Array(repeating: Array(repeating: ".", count: 3), count: 3)
    var XCount = 0
    var OCount = 0
    var dotCount = 0
    
    for (idx, char) in testCase.enumerated() {
        let row = idx / 3
        let col = idx % 3
        
        if char == "X" {
            board[row][col] = "X"
            XCount += 1
        } else if char == "O" {
            board[row][col] = "O"
            OCount += 1
        }
    }
    
    dotCount = 9 - (XCount + OCount)
    
    // X가 승리한 경우
    if XCount == OCount + 1 && XCount >= 3 {
        if dotCount == 0 {
            let (XAnswer, OAnswer) = countXOAnswer(board: board)
            if OAnswer == 0 {
                print("valid")
                continue
            } else {
                print("invalid")
                continue
            }
        }
        
        let (XAnswer, OAnswer) = countXOAnswer(board: board)
        if OAnswer == 0 && XAnswer > 0 {
            print("valid")
            continue
        }
        
        print("invalid")
        continue
    }
    
    // O가 승리한 경우
    if XCount == OCount && OCount >= 3 {
        let (XAnswer, OAnswer) = countXOAnswer(board: board)
        if XAnswer == 0 && OAnswer > 0 {
            print("valid")
            continue
        }
        
        print("invalid")
        continue
    }
    
    print("invalid")
}

func countXOAnswer(board: [[String]]) -> (Int, Int) {
    var XAnswer = 0
    var OAnswer = 0
    
    for i in 0..<3 {
        var xCnt = 0
        var oCnt = 0
        
        for j in 0..<3 {
            if board[i][j] == "X" { xCnt += 1 }
            if board[i][j] == "O" { oCnt += 1 }
        }
        
        if xCnt == 3 { XAnswer += 1 }
        if oCnt == 3 { OAnswer += 1 }
    }
    
    for i in 0..<3 {
        var xCnt = 0
        var oCnt = 0
        
        for j in 0..<3 {
            if board[j][i] == "X" { xCnt += 1 }
            if board[j][i] == "O" { oCnt += 1 }
        }
        
        if xCnt == 3 { XAnswer += 1 }
        if oCnt == 3 { OAnswer += 1 }
    }
    
    var xCnt = 0
    var oCnt = 0
    for i in 0..<3 {
        if board[i][i] == "X" { xCnt += 1 }
        if board[i][i] == "O" { oCnt += 1 }
    }
    
    if xCnt == 3 { XAnswer += 1 }
    if oCnt == 3 { OAnswer += 1 }
    
    xCnt = 0
    oCnt = 0
    for i in 0..<3 {
        if board[i][2-i] == "X" { xCnt += 1 }
        if board[i][2-i] == "O" { oCnt += 1 }
    }
    
    if xCnt == 3 { XAnswer += 1 }
    if oCnt == 3 { OAnswer += 1 }
    
    return (XAnswer, OAnswer)
}
