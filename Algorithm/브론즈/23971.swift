let inputList = readLine()!.split(separator: " ").map { Int($0)! }

let H = inputList[0]
let W = inputList[1]
let N = inputList[2]
let M = inputList[3]

let rows = (H+N) / (N+1)
let cols = (W+M) / (M+1)

let maxCapacity = rows * cols
print(maxCapacity)
