import Foundation

let T = Int(readLine()!)!

for _ in 0..<T {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let testCaseNumber = input[0]
    let heights = Array(input[1...])
    
    var line: [Int] = []
    var totalMoves = 0
    
    for height in heights {
        var position = line.count
        for i in 0..<line.count {
            if line[i] > height {
                position = i
                break
            }
        }
        
        line.insert(height, at: position)
        totalMoves += (line.count - position - 1)
    }
    
    print("\(testCaseNumber) \(totalMoves)")
}
