let N = Int(readLine()!)!
let jumpLine = readLine()!.split(separator: " ").map { Int($0)! }

//✅ 커서 큐
struct Queue<T> {
    var data = [T]() //👉 element를 저장하는 배열
    var index = 0 //👉 queue의 맨 앞을 가리키는 커서
    
    //✅ 비었는지 확인
    var isEmpty: Bool {
        return !(data.count > index) //👉 count의 시간복잡도 O(1)
        //👉 index가 data의 갯수보다 작다면? = 아직 데이터가 있다.
            // 마지막 data가 dequeue되면 index가 data.count와 같아진다는 것을 생각하면 이해하기 쉽다.
    }
    
    //✅ 큐에 넣기
    mutating func enqueue(_ element: T) {
        data.append(element)
    }
    
    //✅ 큐에서 빼기
    mutating func dequeue() -> T {
        //⭐️ defer문을 활용해서 return된 이후에 index를 1 늘려준다.
        defer {
            index += 1
        }
        return data[index] //👉 현재 index를 return한다.
    }
}


func dfs(_ start: Int) -> Int {
    var deque = Queue<(Int, Int)>()
    deque.enqueue((start, 0))
    var visited = Array(repeating: false, count: N)
    visited[start] = true
    
    while !deque.isEmpty {
        var (currentPosition, count) = deque.dequeue()
        
        if currentPosition == N-1 {
            return count
        }
        
        var number = jumpLine[currentPosition]
        
        if number == 0 {
            continue
        }
        
        for i in 1...number {
            let newPosition = currentPosition + i
            if newPosition < N && !visited[newPosition] {
                deque.enqueue((newPosition, count + 1))
                visited[newPosition] = true
            }
        }
    }
    
    return -1
}

if N == 1 {
    print(0)
}

else {
    print(dfs(0))
}
