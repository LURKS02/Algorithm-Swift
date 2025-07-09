let T = Int(readLine()!)!

var answer = ""

for _ in 0..<T {
    let command: [Character] = Array(readLine()!)
    
    var start = 0
    var end = command.count - 1
    
    var chance = true
    var printed = false
    
    while start < end {
        if command[start] == command[end] {
            start += 1
            end -= 1
            continue
        } else {
            if chance {
                var tempCount1 = 0
                var tempCount2 = 0
                
                var tempStart1 = start + 1
                var tempEnd1 = end
                
                var tempStart2 = start
                var tempEnd2 = end - 1
                
                while tempStart1 < tempEnd1 && command[tempStart1] == command[tempEnd1] {
                    tempCount1 += 1
                    tempStart1 += 1
                    tempEnd1 -= 1
                }
                
                while tempStart2 < tempEnd2 && command[tempStart2] == command[tempEnd2] {
                    tempCount2 += 1
                    tempStart2 += 1
                    tempEnd2 -= 1
                }
                
                if tempCount1 >= tempCount2 {
                    if tempStart1 >= tempEnd1 {
                        answer += "1\n"
                        printed = true
                        break
                    } else {
                        answer += "2\n"
                        printed = true
                        break
                    }
                } else {
                    if tempStart2 >= tempEnd2 {
                        answer += "1\n"
                        printed = true
                        break
                    } else {
                        answer += "2\n"
                        printed = true
                        break
                    }
                }
            } else {
                answer += "2\n"
                printed = true
                break
            }
        }
    }
    
    if !printed {
        if start >= end {
            answer += "0\n"
        } else {
            answer += "2\n"
        }
    }
}

print(answer)
