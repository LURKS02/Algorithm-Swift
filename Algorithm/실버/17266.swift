let N = Int(readLine()!)!
let M = Int(readLine()!)!

let locations = readLine()!.split(separator: " ").map { Int($0)! }

var start = 1
var end = 100001
var ans = 1

while start <= end {
    let mid = (start + end) / 2
//    print(mid)
    
    var currentPosition = 0
    
    var pass = true
    for location in locations {
        if currentPosition < location - mid {
            pass = false
            break
        }
        currentPosition = location + mid
    }
    if currentPosition < N {
        pass = false
    }
    
    if pass {
        ans = mid
        end = mid - 1
    } else {
        start = mid + 1
    }
}

print(ans)
