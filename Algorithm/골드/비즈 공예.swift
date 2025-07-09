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
        defer { index += 1 }

        return buffer.withUnsafeBufferPointer { $0[index] }
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

        while now == 10
            || now == 32 { now = read() } // 공백과 줄바꿈 무시

        while now != 10
            && now != 32 && now != 0 {
                str += String(bytes: [now], encoding: .ascii)!
                now = read()
        }

        return str
    }
}

struct Heap<T> {
    var elements: [T] = []
    var comparer: (T, T) -> Bool
    
    var count: Int {
        elements.count
    }
    
    var isEmpty: Bool {
        elements.isEmpty
    }
    
    mutating func heappush(_ element: T) {
        elements.append(element)
        siftUp()
    }
    
    mutating func heappop() -> T? {
        if elements.count == 0 { return nil }
        if elements.count == 1 { return elements.popLast()! }
        
        let temp = elements[0]
        elements[0] = elements.popLast()!
        if elements.count > 1 {
            siftDown()
        }
        return temp
    }
    
    private mutating func siftUp() {
        var childIdx = elements.count - 1
        
        while childIdx > 0 {
            let parentIdx = (childIdx - 1) / 2
            
            if comparer(elements[childIdx], elements[parentIdx]) {
                elements.swapAt(childIdx, parentIdx)
                childIdx = parentIdx
            } else {
                return
            }
        }
    }
    
    private mutating func siftDown() {
        var parentIdx = 0
        var cnt = elements.count
        
        while parentIdx < cnt {
            var leftChildIdx = parentIdx * 2 + 1
            var rightChildIdx = parentIdx * 2 + 2
            var tempIdx = parentIdx
            
            if leftChildIdx < cnt && comparer(elements[leftChildIdx], elements[tempIdx]) {
                tempIdx = leftChildIdx
            }
            if rightChildIdx < cnt && comparer(elements[rightChildIdx], elements[tempIdx]) {
                tempIdx = rightChildIdx
            }
            if parentIdx == tempIdx { break }
            
            elements.swapAt(parentIdx, tempIdx)
            parentIdx = tempIdx
        }
    }
}

struct Deque<T> {
    var elements: [T] = []
    var index = 0
    
    var isEmpty: Bool {
        index >= elements.count
    }
    
    mutating func append(_ element: T) {
        elements.append(element)
    }
    
    mutating func popleft() -> T {
        defer { index += 1 }
        return elements[index]
    }
}

let fIO = FileIO()

let N = fIO.readInt()

var coins: [Int] = []
var answer = 0

for _ in 0..<N {
    let coin = fIO.readInt()
    coins.append(coin)
}

while coins.count != 5 {
    coins.append(0)
}

// dp = [첫번째][두번째][A][B][C][D][E] = 5 * 5 * 10 * 10 * 10 * 10 * 10
var dp = Array(repeating: Array(repeating: Array(repeating: Array(repeating: Array(repeating: Array(repeating: Array(repeating: -1, count: 11), count: 11), count: 11), count: 11), count: 11), count: 6), count: 6)

func solve(prev: Int, cur: Int, a: Int, b: Int, c: Int, d: Int, e: Int) -> Int {
    if (prev != 0 && cur != 0) && prev == cur { return 0 }
    if a < 0 || b < 0 || c < 0 || d < 0 || e < 0 { return 0 }
    if a == 0 && b == 0 && c == 0 && d == 0 && e == 0 { return 1 }
    if dp[prev][cur][a][b][c][d][e] != -1 { return dp[prev][cur][a][b][c][d][e] }
    
    var value = 0
    
    if a > 0 && prev != 1 { value += solve(prev: cur, cur: 1, a: a-1, b: b, c: c, d: d, e: e) }
    if b > 0 && prev != 2 { value += solve(prev: cur, cur: 2, a: a, b: b-1, c: c, d: d, e: e) }
    if c > 0 && prev != 3 { value += solve(prev: cur, cur: 3, a: a, b: b, c: c-1, d: d, e: e) }
    if d > 0 && prev != 4 { value += solve(prev: cur, cur: 4, a: a, b: b, c: c, d: d-1, e: e) }
    if e > 0 && prev != 5 { value += solve(prev: cur, cur: 5, a: a, b: b, c: c, d: d, e: e-1) }
    
    dp[prev][cur][a][b][c][d][e] = value
    
    return value
}


print(solve(prev: 0, cur: 0, a: coins[0], b: coins[1], c: coins[2], d: coins[3], e: coins[4]))
