let line1 = readLine()!.split(separator: " ").map { Int($0)! }
let L = line1[0]
let K = line1[1]
let C = line1[2]

var cuts = readLine()!.split(separator: " ").map { Int($0)! }
let cutSets = Set<Int>(cuts)
cuts = Array(cutSets).sorted()

var left = 1
var right = 1000000000

var answerLength = 0
var answerSpot = 0

while left <= right {
    let mid = (left + right) / 2
    
    var start1 = 0
    var last1 = cuts[0]
    var startToCut1 = Int.max
    var maxLength1 = 0
    var cutSpot1 = Set<Int>()
    
    for i in 1..<cuts.count {
        if cuts[i] - start1 <= mid {
            last1 = cuts[i]
        } else {
            cutSpot1.insert(last1)
            maxLength1 = max(maxLength1, last1 - start1)
            startToCut1 = min(startToCut1, last1)
            start1 = last1
            last1 = cuts[i]
        }
    }
    
    if L - start1 <= mid {
        last1 = L
    } else {
        cutSpot1.insert(last1)
        maxLength1 = max(maxLength1, last1 - start1)
        startToCut1 = min(startToCut1, last1)
        start1 = last1
        last1 = L
    }
    
    maxLength1 = max(maxLength1, last1 - start1)
    
    var start2 = L
    var last2 = cuts.last!
    var startToCut2 = Int.max
    var maxLength2 = 0
    var cutSpot2 = Set<Int>()
    
    for i in stride(from: cuts.count - 2, to: -1, by: -1) {
        if start2 - cuts[i] <= mid {
            last2 = cuts[i]
        } else {
            cutSpot2.insert(last2)
            maxLength2 = max(maxLength2, start2 - last2)
            startToCut2 = min(startToCut2, last2)
            start2 = last2
            last2 = cuts[i]
        }
    }
    
    if start2 <= mid {
        last2 = 0
    } else {
        cutSpot2.insert(last2)
        maxLength2 = max(maxLength2, start2 - last2)
        startToCut2 = min(startToCut2, last2)
        start2 = last2
        last2 = 0
    }
    
    maxLength2 = max(maxLength2, start2 - last2)
    
    if (maxLength1 <= mid && cutSpot1.count <= C) && (maxLength2 <= mid && cutSpot2.count <= C) {
        if cutSpot1.count < C {
            for cut in cuts {
                if cutSpot1.count == C { break }
                if !cutSpot1.contains(cut) {
                    cutSpot1.insert(cut)
                    startToCut1 = min(startToCut1, cut)
                }
            }
        }
        
        if cutSpot2.count < C {
            for cut in cuts {
                if cutSpot2.count == C { break }
                if !cutSpot2.contains(cut) {
                    cutSpot2.insert(cut)
                    startToCut2 = min(startToCut2, cut)
                }
            }
        }
        
        answerLength = mid
        answerSpot = min(startToCut1, startToCut2)
        right = mid - 1
    } else if maxLength1 <= mid && cutSpot1.count <= C {
        if cutSpot1.count < C {
            for cut in cuts {
                if cutSpot1.count == C { break }
                if !cutSpot1.contains(cut) {
                    cutSpot1.insert(cut)
                    startToCut1 = min(startToCut1, cut)
                }
            }
        }
        
        answerLength = mid
        answerSpot = startToCut1
        right = mid - 1
    } else if maxLength2 <= mid && cutSpot2.count <= C {
        if cutSpot2.count < C {
            for cut in cuts {
                if cutSpot2.count == C { break }
                if !cutSpot2.contains(cut) {
                    cutSpot2.insert(cut)
                    startToCut2 = min(startToCut2, cut)
                }
            }
        }
        
        answerLength = mid
        answerSpot = startToCut2
        right = mid - 1
    } else {
        left = mid + 1
    }
}

print(answerLength, answerSpot)
