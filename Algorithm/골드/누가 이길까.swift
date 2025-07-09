let line = readLine()!.split(separator: " ").map { Int($0)! }
let N = line[0]
let M = line[1]

var a = readLine()!.split(separator: " ").map { Int($0)! }
var b = readLine()!.split(separator: " ").map { Int($0)! }

a.sort()

var hi = 0
var arc = 0
var equal = 0

func bisectLeft<T: Comparable>(_ array: [T], _ target: T) -> Int {
    var left = 0
    var right = array.count
    
    while left < right {
        let mid = (left + right) / 2
        
        if array[mid] < target {
            left = mid + 1
        } else {
            right = mid
        }
    }
    
    return left
}

func bisectRight<T: Comparable>(_ array: [T], _ target: T) -> Int {
    var left = 0
    var right = array.count
    
    while left < right {
        let mid = (left + right) / 2
        
        if array[mid] <= target {
            left = mid + 1
        } else {
            right = mid
        }
    }
    
    return left
}

for person in b {
    let leftEqualIndex = bisectLeft(a, person)
    let rightEqualIndex = bisectRight(a, person)
    
    arc += leftEqualIndex
    equal += rightEqualIndex - leftEqualIndex
    hi += (N - rightEqualIndex)
}

print(hi, arc, equal)
