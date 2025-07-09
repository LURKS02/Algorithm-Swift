let line = readLine()!.split(separator: " ").map { Int($0)! }
let N = line[0]
let K = line[1]

let A = readLine()!.split(separator: " ").map { Int($0)! }

var possibleDate: [Int] = []

for index in 0..<A.count {
    if A[index] == 1 {
        possibleDate.append(index+1)
    }
}

possibleDate.sort()

var left = 1
var right = 199999
var answer = 1

while left <= right {
    let mid = (left + right) / 2
//    print()
//    print(">>> mid: \(mid)")
    
    var runningDate = N
    var movingCount = 0
    var continueFlag = false
    
    while true {
        let prev = runningDate
        runningDate = max(runningDate - mid, 1)
        movingCount += 1
        
        if runningDate == 1 { break }
        
        if A[runningDate-1] == 0 {
            let newRunningDate = possibleDate[bisectLeft(arr: possibleDate, target: runningDate)]
            if prev == newRunningDate {
                left = mid + 1
                continueFlag = true
                break
            } else {
                runningDate = newRunningDate
            }
        }
    }
    
    if continueFlag {
        continue
    }
    
    if movingCount <= K {
        right = mid - 1
        answer = mid
    } else {
        left = mid + 1
    }
}

func bisectLeft(arr: [Int], target: Int) -> Int {
    var left = 0
    var right = arr.count
    
    while left < right {
        let mid = (left + right) / 2
        if arr[mid] < target {
            left = mid + 1
        } else {
            right = mid
        }
    }
    
    return left
}

print(answer)
