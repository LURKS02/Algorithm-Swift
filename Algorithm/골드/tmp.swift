//
//  tmp.swift
//  Algorithm
//
//  Created by 디해 on 1/21/25.
//

import Foundation

struct Data: Comparable {
    static func < (lhs: Data, rhs: Data) -> Bool {
        return lhs.cost < rhs.cost
    }
    
    let node: Int
    let cost: Int
}

class Heap<T: Comparable> {
    var elements: [T] = []
    
    func push(_ data: T) {
        elements.append(data)
        siftUp()
    }
    
    func pop() -> T? {
        if elements.count == 0 {
            return nil
        } else if elements.count == 1 {
            return elements.removeLast()
        }
        
        let temp = elements[0]
        elements[0] = elements.removeLast()
        
        if elements.count > 1 {
            siftDown()
        }
        
        return temp
    }
    
    func siftUp() {
        var child_idx = elements.count - 1
        
        while child_idx > 0 {
            var parent_idx = (child_idx-1) / 2
            
            if elements[child_idx] >= elements[parent_idx] {
                return
            }
            
            elements.swapAt(child_idx, parent_idx)
            child_idx = parent_idx
        }
    }
    
    func siftDown() {
        var parent_idx = 0
        var cnt = elements.count
        
        while parent_idx < cnt {
            var left_child_idx = parent_idx * 2 + 1
            var right_child_idx = parent_idx * 2 + 2
            var temp_idx = parent_idx
            
            if left_child_idx < cnt && elements[left_child_idx] < elements[parent_idx] {
                temp_idx = left_child_idx
            }
            
            if right_child_idx < cnt && elements[right_child_idx] < elements[temp_idx] {
                temp_idx = right_child_idx
            }
            
            if parent_idx == temp_idx {
                break
            }
            
            elements.swapAt(parent_idx, temp_idx)
            parent_idx = temp_idx
        }
    }
}

struct Deque<T> {
    private var array: [T] = []
    private var index: Int = 0
    
    init(_ arr: [T]) {
        array = arr
    }
    
    var isEmpty: Bool {
        array.count <= index
    }
    
    mutating func append(_ val: T) {
        array.append(val)
    }
    
    mutating func popleft() -> T {
        defer { index += 1 }
        return array[index]
    }
    
    mutating func pop() -> T {
        array.popLast()!
    }
}

func solution(N: Int, graph: [[(Int, Int)]], start: Int, k: Int) -> Int {
    var deq = Deque([(start, 10_000_000_000)])
    var visited = Array(repeating: false, count: N+1)
    visited[start] = true
    var answer = 0
    
    while !deq.isEmpty {
        let (node, value) = deq.popleft()
        
        let nexts = graph[node]
        
        for (neighbor, cost) in nexts {
            if !visited[neighbor] {
                visited[neighbor] = true
                let c = min(cost, value)
                if c >= k { answer += 1 }
                deq.append((neighbor, c))
            }
        }
    }
    
    return answer
}

//func dijkstra(graph: [Int: [(Int, Int)]], start: Int) -> [Int: Int] {
//    var heap = Heap<Data>()
//    let data = Data(node: start, cost: 0)
//    heap.push(data)
//
//    var distances: [Int: Int] = [:]
//    distances[start] = 0
//
//    while !heap.elements.isEmpty {
//        let poppedData = heap.pop()
//        let cur_idx = poppedData!.node
//        let cur_cost = poppedData!.cost
//
//        guard let childs = graph[cur_idx] else { continue }
//
//        for (child_idx, child_cost) in childs {
//            var sum_cost = cur_cost + child_cost
//
//            if distances[child_idx] == nil || distances[child_idx]! > sum_cost {
//                heap.push(Data(node: child_idx, cost: sum_cost))
//                distances[child_idx] = sum_cost
//            }
//        }
//    }
//
//    return distances
//}

let inputs1 = readLine()!.split(separator: " ").map { Int($0)! }
let N = inputs1[0]
let Q = inputs1[1]
    
var graph: [[(Int, Int)]] = Array(repeating: [], count: N+1)

for _ in 0..<N-1 {
    let inputs2 = readLine()!.split(separator: " ").map { Int($0)! }
    let p = inputs2[0]
    let q = inputs2[1]
    let r = inputs2[2]
    
    graph[p].append((q, r))
    graph[q].append((p, r))
}

for i in 0..<Q {
    let inputs3 = readLine()!.split(separator: " ").map { Int($0)! }
    let k = inputs3[0]
    let v = inputs3[1]
    
    print(solution(N: N, graph: graph, start: v, k: k))
}
