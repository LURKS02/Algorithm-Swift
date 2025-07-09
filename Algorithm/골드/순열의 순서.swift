import Foundation

let N = Int(readLine()!)!

let line = readLine()!.split(separator: " ").map { Int($0)! }
let command = line[0]

if command == 1 {
    var nums: [Int] = []
    var answer: [Int] = []
    
    for i in 1...N {
        nums.append(i)
    }
    
    var k = Int64(line[1])
    var radix: Int64 = 1
    for i in 1...N {
        radix *= Int64(i)
    }
    
    var idx = N
    while radix != 1 {
        radix = radix / Int64(idx)
        let i = (Int64(k) - Int64(1)) / radix
        answer.append(nums[Int(i)])
        nums.remove(at: Int(i))
        k -= radix * i
        idx -= 1
    }
    
    answer.append(nums[0])
    
    let result = answer.map { String($0) }.joined(separator: " ")
    print(result)
} else {
    var idx = 1
    var answer: Int64 = 0
    
    var radix: Int64 = 1
    for i in 1...N {
        radix *= Int64(i)
    }
    
    var temp = N
    var nums: [Int] = []
    
    for i in 1...N {
        nums.append(i)
    }
    
    while radix != 1 {
        radix = radix / Int64(temp)
        let target = line[idx]
        var index = -1
        for i in 0..<nums.count {
            if nums[i] == target {
                index = i
            }
        }
        
        let i = Int64(index) * radix
        answer += i
        nums.remove(at: index)
        
        temp -= 1
        idx += 1
    }
    
    print(answer+1)
}
