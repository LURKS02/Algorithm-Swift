import Foundation

let N = Int(readLine()!)!
let inputString = readLine()!

class Deque<T> {
    private var array: [T] = []
    private var index: Int = 0
    
    var isEmpty: Bool { index >= array.count }
    
    func popleft() -> T {
        defer { index += 1 }
        return array[index]
    }
    
    func append(_ element: T) {
        array.append(element)
    }
}

if N == 1 { print(inputString) }

else {
    var operations: [(Character, Int)] = []
    
    for i in stride(from: 1, to: inputString.count, by: 2) {
        let opIdx = inputString.index(inputString.startIndex, offsetBy: i)
        let numIdx = inputString.index(inputString.startIndex, offsetBy: i+1)
        
        let op = inputString[opIdx]
        let num = Int(String(inputString[numIdx]))!
        
        operations.append((op, num))
    }
    
    let deq = Deque<(Int, Int)>()
    deq.append((Int(String(inputString[inputString.startIndex]))!, 0))
    
    var answer = -Int(pow(2.0, 31.0))
    
    while !deq.isEmpty {
        let (number, numberOfUsedOps) = deq.popleft()
        
        if numberOfUsedOps == operations.count {
            answer = max(answer, number)
            continue
        }
        
        // 그냥 수식을 사용하는 경우
        let (op, num) = operations[numberOfUsedOps]
        if op == "+" { deq.append((number + num, numberOfUsedOps + 1)) }
        if op == "-" { deq.append((number - num, numberOfUsedOps + 1)) }
        if op == "*" { deq.append((number * num, numberOfUsedOps + 1)) }
        
        // 수식을 두개 합쳐서 사용하는 경우
        if numberOfUsedOps + 1 < operations.count {
            let (nextOP, nextNum) = operations[numberOfUsedOps + 1]
            let A = Int(num)
            let B = Int(nextNum)
            
            var operatedNum = 0
            if nextOP == "+" { operatedNum = A + B }
            if nextOP == "-" { operatedNum = A - B }
            if nextOP == "*" { operatedNum = A * B }
            
            if op == "+" { deq.append((number + operatedNum, numberOfUsedOps + 2)) }
            if op == "-" { deq.append((number - operatedNum, numberOfUsedOps + 2)) }
            if op == "*" { deq.append((number * operatedNum, numberOfUsedOps + 2)) }
        }
    }
    
    print(answer)
}
