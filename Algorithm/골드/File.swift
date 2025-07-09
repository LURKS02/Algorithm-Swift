let N = Int(readLine()!)!

var cups = readLine()!.split(separator: " ").map { Int($0)! }

cups.sort()

var ans = Int.max
var ansList: [Int] = []
var breakPoint = false

for i in 0..<cups.count-2 {
    if breakPoint {
        break
    }
    
    var left = i + 1
    var right = cups.count-1
    
    while left < right {
        let result = cups[i] + cups[left] + cups[right]
        if abs(result) < ans {
            ans = abs(result)
            ansList = [cups[i], cups[left], cups[right]]
        }
        if result < 0 {
            left += 1
        } else if result > 0 {
            right -= 1
        } else {
            breakPoint = true
            break
        }
    }
}

print(ansList.sorted().map { "\($0)" }.joined(separator: " "))
