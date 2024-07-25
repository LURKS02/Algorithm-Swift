let input = readLine()!.split(separator: " ")
let A = String(input[0])
let B = String(input[1])

func minDifference(A: String, B: String) -> Int {
    let lenA = A.count
    let lenB = B.count
    
    var minDiff = Int.max
    
    for i in 0...(lenB-lenA) {
        let startIndex = B.index(B.startIndex, offsetBy: i)
        let endIndex = B.index(startIndex, offsetBy: lenA)
        let subB = B[startIndex..<endIndex]
        
        var currentDiff = 0
        for (charA, charB) in zip(A, subB) {
            if charA != charB {
                currentDiff += 1
            }
        }
        
        if currentDiff < minDiff {
            minDiff = currentDiff
        }
    }
    return minDiff
}

print(minDifference(A: A, B: B))
