let l = readLine()!.split(separator: " ")
let N = Int(l[0])!
let Q = Int(l[1])!

var logsByLevel = Array(repeating: [String](), count: 7)

for _ in 0..<N {
    let line = readLine()!.split(separator: "#")
    let time = line[0].filter { $0 != "-" && $0 != ":" && $0 != " " }
    
    let level = Int(line[1])!
    
    logsByLevel[level].append(time)
}

var ans = [String]()

for k in 0..<Q {
    let line = readLine()!.split(separator: "#")
    let startTime = line[0].filter { $0 != "-" && $0 != ":" && $0 != " " }
    let endTime = line[1].filter { $0 != "-" && $0 != ":" && $0 != " " }
    
    let level = Int(line[2])!
    
    var answer = 0
    
    for key in level...6 {
        if logsByLevel[key].count != 0 {
            let leftIndex = bisectLeft(logsByLevel[key], startTime)
            let rightIndex = bisectRight(logsByLevel[key], endTime)
            
            answer += rightIndex - leftIndex
        }
    }
    
    ans.append("\(answer)")
}

print(ans.joined(separator: "\n"))


func bisectLeft<T: Comparable>(_ arr: [T], _ target: T) -> Int {
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

func bisectRight<T: Comparable>(_ arr: [T], _ target: T) -> Int {
    var left = 0
    var right = arr.count
    
    while left < right {
        let mid = (left + right) / 2
        if arr[mid] <= target {
            left = mid + 1
        } else {
            right = mid
        }
    }
    
    return left
}
