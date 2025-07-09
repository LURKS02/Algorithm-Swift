struct Deque {
    var elements: [String] = []
    var first = 0
    
    var count: Int {
        elements.count - first
    }
    
    var isEmpty: Bool {
        first >= elements.count
    }
    
    mutating func append(_ element: String) {
        elements.append(element)
    }
    
    mutating func popleft() -> String {
        defer { first += 1 }
        return elements[first]
    }
}

let S = readLine()!
let T = readLine()!

var deque = Deque()
var visited = Set<String>()
deque.append(T)
visited.insert(T)
var isPrinted: Bool = false

while !deque.isEmpty {
    let str = deque.popleft()
    
    if str == S {
        print(1)
        isPrinted = true
        break
    }
    
    if str.count <= S.count { continue }
    
    if str[str.index(str.startIndex, offsetBy: str.count - 1)] == "A" {
        let case1 = String(str.dropLast())
        if !visited.contains(case1) {
            deque.append(case1)
            visited.insert(case1)
        }
    }
    
    if str[str.startIndex] == "B" {
        let case2 = String(str.dropFirst().reversed())
        if !visited.contains(case2) {
            deque.append(case2)
            visited.insert(case2)
        }
    }
}

if !isPrinted {
    print(0)
}
