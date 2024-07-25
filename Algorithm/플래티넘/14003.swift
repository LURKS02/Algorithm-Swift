let N = Int(readLine()!)!
let array = readLine()!.split(separator: " ").map { Int($0)! }

var cache: [Int] = [-1_000_000_001]
var index: [Int] = []

for i in 0..<N {
    if cache.last! < array[i] {
        cache.append(array[i])
        index.append(cache.count-1)
        continue
    }
    
    var start = 0
    var end = cache.count - 1
    
    while start <= end {
        let mid = (start + end) / 2
        
        if cache[mid] >= array[i] {
            end = mid - 1
        } else {
            start = mid + 1
        }
    }
    
    cache[start] = array[i]
    index.append(start)
}

var length = index.max()!

print(length)

var LIS: [Int] = []

for i in (0..<N).reversed() {
    if length == index[i] {
        LIS.append(array[i])
        length -= 1
    }
}

print(LIS.reversed().map { String($0) }.joined(separator: " "))
