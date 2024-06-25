import Foundation

func solution(_ name:[String], _ yearning:[Int], _ photo:[[String]]) -> [Int] {
    let infoLength = name.count
    
    var dict: [String: Int] = [:]
    var answerList: [Int] = []
    
    for i in 0..<infoLength {
        let infoName = name[i]
        let infoYearning = yearning[i]
        dict[infoName] = infoYearning
    }
    
    for photoList in photo {
        var sum = 0
        for p in photoList {
            if dict[p] != nil {
                sum += dict[p]!
            }
        }
        answerList.append(sum)
    }
    
    return answerList
    
}
