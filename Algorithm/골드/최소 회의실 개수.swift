struct Heap {
    var elements: [Int] = []
    var comparer: (Int, Int) -> Bool
    
    var count: Int {
        elements.count
    }
    
    var isEmpty: Bool {
        elements.isEmpty
    }
    
    mutating func heappush(_ element: Int) {
        elements.append(element)
        siftUp()
    }
    
    mutating func heappop() -> Int? {
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
            
            elements.swapAt(parentIdx, tempIdx)
            parentIdx = tempIdx
        }
    }
}

let N = Int(readLine()!)!

var meetings: [(Int, Int)] = []
 
for _ in 0..<N {
    let line = readLine()!.split(separator: " ").map { Int($0)! }
    let start = line[0]
    let end = line[1]
    
    meetings.append((start, end))
}

meetings.sort(by: {
    if $0.0 == $1.0 {
        return $0.1 < $1.1
    } else {
        return $0.0 < $1.0
    }
})

var count = 0
var heap = Heap(comparer: <)

for meeting in meetings {
    if !heap.isEmpty && heap.elements[0] <= meeting.0 {
        heap.heappop()
        heap.heappush(meeting.1)
    } else {
        heap.heappush(meeting.1)
    }
    count = max(count, heap.count)
}

print(count)
