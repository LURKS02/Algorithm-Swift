func run() -> String {
    let inputList = Array(readLine()!.map { String($0) })
    
    var stack: [String] = []
    
    for c in inputList {
        if c == "(" || c == "[" {
            stack.append(c)
        }
        
        if c == ")" {
            var sum = 0
            while true {
                guard let popC = stack.popLast() else { return "0" }
                if popC == "(" {
                    if sum == 0 { stack.append(String(2)) }
                    else { stack.append(String(sum * 2)) }
                    break
                } else if popC == ")" || popC == "[" || popC == "]" {
                    return "0"
                } else {
                    sum += Int(popC)!
                }
            }
        }
        
        if c == "]" {
            var sum = 0
            while true {
                guard let popC = stack.popLast() else { return "0" }
                if popC == "[" {
                    if sum == 0 { stack.append(String(3)) }
                    else { stack.append(String(sum * 3)) }
                    break
                } else if popC == "]" || popC == "(" || popC == ")" {
                    return "0"
                } else {
                    sum += Int(popC)!
                }
            }
        }
//        print(stack)
    }
    
    var answer = 0
    for s in stack {
        guard let ints = Int(s) else { return "0" }
        answer += ints
    }
    return String(answer)
}

print(run())
