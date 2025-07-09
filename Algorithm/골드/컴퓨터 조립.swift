import Foundation

// 라이노님 빠른 입력 FileIO 클래스
final class FileIO {
    private var buffer:[UInt8]
    private var index: Int

    init(fileHandle: FileHandle = FileHandle.standardInput) {
        buffer = Array(fileHandle.readDataToEndOfFile())+[UInt8(0)] // 인덱스 범위 넘어가는 것 방지
        index = 0
    }

    @inline(__always) private func read() -> UInt8 {
        guard index < buffer.count else { return 0 }
        defer { index += 1 }
        return buffer[index]
    }

    @inline(__always) func readInt() -> Int {
        var sum = 0
        var now = read()
        var isPositive = true

        while now == 10 || now == 32 { // 공백과 줄바꿈 무시
            now = read()
        }
        
        if now == 45{ // 음수 처리
            isPositive.toggle()
            now = read()
        }
        
        while now >= 48, now <= 57 {
            sum = sum * 10 + Int(now-48)
            now = read()
        }

        return sum * (isPositive ? 1:-1)
    }

    @inline(__always) func readString() -> String {
        var str = ""
        var now = read()

        while now == 10 || now == 32 {
            now = read()
        }

        while now != 10 && now != 32 && now != 0 {
            if let s = String(bytes: [now], encoding: .ascii) {
                str += s
            }
            now = read()
        }

        return str
    }
}

let fIO = FileIO()

let T = fIO.readInt()

struct Metadata {
    let price: Int
    let quality: Int
}

for _ in 0..<T {
    var dict: [String: [Metadata]] = [:]
    var keys = Set<String>()
    
    let N = fIO.readInt()
    let B = fIO.readInt()
    
    for _ in 0..<N {
        let type = fIO.readString()
        let name = fIO.readString()
        let price = fIO.readInt()
        let quality = fIO.readInt()
        
        if keys.contains(type) {
            dict[type]!.append(Metadata(price: price, quality: quality))
        } else {
            keys.insert(type)
            dict[type] = [Metadata(price: price, quality: quality)]
        }
    }
    
    var left = 0
    var right = 1000000000
    var answer = 0
    
    while left <= right {
        let mid = (left + right) / 2
        
        var cost = 0
        var breakPoint = false
        for l in dict.values {
            var temp = Int.max
            for metadata in l {
                if metadata.quality >= mid {
                    temp = min(temp, metadata.price)
                }
            }
            
            if temp == Int.max {
                right = mid - 1
                breakPoint = true
                break
            }
            
            cost += temp
        }
        
        if breakPoint { continue }
        
        if cost <= B {
            answer = mid
            left = mid + 1
        } else {
            right = mid - 1
        }
    }
    
    print(answer)
}
