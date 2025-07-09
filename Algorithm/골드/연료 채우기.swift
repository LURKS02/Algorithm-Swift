struct Heap<T: Comparable> {
    var elements: [T] = []
    var comparer: (T, T) -> Bool
    
    init(comparer: @escaping (T, T) -> Bool) {
        self.comparer = comparer
    }
    
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
    
    mutating func siftUp() {
        var childIdx = elements.count - 1
        
        while childIdx > 0 {
            var parentIdx = (childIdx - 1) / 2
            
            if comparer(elements[childIdx], elements[parentIdx]) {
                elements.swapAt(childIdx, parentIdx)
                childIdx = parentIdx
            } else {
                return
            }
        }
    }
    
    mutating func siftDown() {
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
            
            elements.swapAt(tempIdx, parentIdx)
            parentIdx = tempIdx
        }
    }
}


let N = Int(readLine()!)!

struct Oil: Comparable {
    let distance: Int
    let oil: Int
    
    static func < (_ lhs: Self, _ rhs: Self) -> Bool {
        lhs.distance < rhs.distance
    }
}

var spots: [Oil] = []

for _ in 0..<N {
    let line = readLine()!.split(separator: " ").map { Int($0)! }
    let a = line[0]
    let b = line[1]
    
    spots.append(Oil(distance: a, oil: b))
}

spots.sort()

let line = readLine()!.split(separator: " ").map { Int($0)! }
let L = line[0]
let P = line[1]

var idx = 0
var heap = Heap<Int>(comparer: >)

var currentDistance = P
var oilIndex = 0
var answer = 0
var isPrinted = false

while oilIndex < spots.count {
    if currentDistance >= L {
        print(answer)
        isPrinted = true
        break
    }
    
    if spots[oilIndex].distance <= currentDistance {
        heap.heappush(spots[oilIndex].oil)
        oilIndex += 1
        continue
    } else {
        if heap.isEmpty { break }
        let largestOil = heap.heappop()!
        answer += 1
        currentDistance += largestOil
    }
}

if !isPrinted {
    while !heap.isEmpty {
        if currentDistance >= L {
            print(answer)
            isPrinted = true
            break
        }
        
        let largestOil = heap.heappop()!
        currentDistance += largestOil
        answer += 1
    }
}

if !isPrinted {
    print(-1)
}
