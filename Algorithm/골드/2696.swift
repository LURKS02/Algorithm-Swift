struct Heap {
    var elements: [Int] = []
    var comparer: (Int, Int) -> Bool
    
    init(comparer: @escaping (Int, Int) -> Bool) {
        self.comparer = comparer
    }
    
    var count: Int {
        elements.count
    }
    
    mutating func heappush(_ element: Int) {
        elements.append(element)
        siftUp()
    }
    
    mutating func heappop() -> Int? {
        if elements.count == 0 { return nil }
        else if elements.count == 1 { return elements.removeLast() }
        
        let temp = elements[0]
        elements[0] = elements.removeLast()
        
        if elements.count > 1 {
            siftDown()
        }
        
        return temp
    }
    
    private mutating func siftUp() {
        var childIdx = elements.count - 1
        
        while childIdx > 0 {
            var parentIdx = (childIdx-1) / 2
            
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

let T = Int(readLine()!)!

for _ in 0..<T {
    let M = Int(readLine()!)!
    
    var answer: [Int] = []
    
    var maxHeap = Heap(comparer: >)
    var minHeap = Heap(comparer: <)
    
    let limit = ((M-1) / 10 + 1)
    for _ in 0..<limit {
        let line = readLine()!.split(separator: " ").map { Int($0)! }
        for number in line {
            if maxHeap.count == 0 || number <= maxHeap.elements[0] {
                maxHeap.heappush(number)
            } else {
                minHeap.heappush(number)
            }
            
            if maxHeap.elements.count > minHeap.elements.count {
                minHeap.heappush(maxHeap.heappop()!)
            } else if maxHeap.elements.count < minHeap.elements.count {
                maxHeap.heappush(minHeap.heappop()!)
            }
            
            if (maxHeap.count + minHeap.count) % 2 == 1 {
                if maxHeap.count > minHeap.count {
                    answer.append(maxHeap.elements[0])
                } else {
                    answer.append(minHeap.elements[0])
                }
            }
        }
    }
    
    print(answer.count)
    for i in stride(from: 0, to: answer.count, by: 10) {
        let endIndex = min(i + 10, answer.count)
        let slice = answer[i..<endIndex].map { String($0) }.joined(separator: " ")
        print(slice)
    }
}
