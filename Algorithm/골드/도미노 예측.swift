let line = readLine()!.split(separator: " ").map { Int($0)! }
let N = line[0]
let Q = line[1]

let memo = readLine()!.split(separator: " ").map { Int($0)! }

var pxor = [0, memo[0]]

for i in 1..<memo.count {
    pxor.append(pxor.last! ^ memo[i])
}

for _ in 0..<Q {
    let query = readLine()!.split(separator: " ").map { Int($0)! }
    let command = query[0]
    
    if command == 0 {
        let x = query[1]
        let y = query[2]
        
        print(pxor[x-1] ^ pxor[y-1])
    } else {
        let x = query[1]
        let y = query[2]
        let d = query[3]
        
        print(pxor[x-1] ^ pxor[y-1] ^ d)
    }
}
