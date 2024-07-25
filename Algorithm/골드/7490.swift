import Foundation

func findZeroSumSequences(_ n: Int) -> [String] {
    var results = [String]()
    var sequence = [String]()
    
    func backtrack(_ index: Int) {
//        print(sequence)
        if index == n {
            let expression = sequence.joined()
            if evaluateExpression(expression) == 0 {
                results.append(expression)
            }
            return
        }
        
        sequence.append(" ")
        sequence.append("\(index + 1)")
        backtrack(index + 1)
        sequence.removeLast()
        sequence.removeLast()
        
        sequence.append("+")
        sequence.append("\(index + 1)")
        backtrack(index + 1)
        sequence.removeLast()
        sequence.removeLast()
        
        sequence.append("-")
        sequence.append("\(index + 1)")
        backtrack(index + 1)
        sequence.removeLast()
        sequence.removeLast()
    }
    
    sequence.append("1")
    backtrack(1)
    return results.sorted()
}

func evaluateExpression(_ expression: String) -> Int {
    let expression = expression.replacingOccurrences(of: " ", with: "")
    var result = 0
    var currentSign = 1
    var currentNum = 0
    
    for char in expression {
        if char == "+" {
            result += currentSign * currentNum
            currentNum = 0
            currentSign = 1
        } else if char == "-" {
            result += currentSign * currentNum
            currentNum = 0
            currentSign = -1
        } else if let digit = Int(String(char)) {
            currentNum = currentNum * 10 + digit
        }
    }
    
    if currentNum > 0 {
        result += currentSign * currentNum
    }
    return result
}

let testCases: Int = Int(readLine()!)!

for _ in 0..<testCases {
    let N: Int = Int(readLine()!)!
    
    let ans = findZeroSumSequences(N)
    
    for a in ans {
        print(a)
    }
    print()
}
