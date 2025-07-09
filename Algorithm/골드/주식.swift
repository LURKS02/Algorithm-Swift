let T = Int(readLine()!)!

for i in 1..<T+1 {
    let line = readLine()!.split(separator: " ").map { Int($0)! }
    let N = line[0]
    let K = line[1]
    
    let stocks = readLine()!.split(separator: " ").map { Int($0)! }
    
    print("Case #\(i)")
    
    var cache: [Int] = [-Int.max]
    var index: [Int] = []
    
    for stock in stocks {
        if cache.last! < stock {
            cache.append(stock)
            index.append(cache.count - 1)
            continue
        }
        
        let idx = bisectLeft(arr: cache, target: stock)
        
        cache[idx] = stock
        index.append(idx)
    }
    
    var LIS: [Int] = []
    var length = index.max()!
    
    for i in (0..<N).reversed() {
        if length == index[i] {
            LIS.append(stocks[i])
            length -= 1
        }
    }
    
    if LIS.count >= K {
        print(1)
    } else {
        print(0)
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

func bisectRight(arr: [Int], target: Int) -> Int {
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
