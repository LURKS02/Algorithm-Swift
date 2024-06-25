import Foundation

func solution(_ players:[String], _ callings:[String]) -> [String] {
    var playerIndexMap = [String: Int]()
    for (index, player) in players.enumerated() {
        playerIndexMap[player] = index
    }
    
    var racePosition = players
    
    for calling in callings {
        if let index = playerIndexMap[calling] {
            let temp = racePosition[index-1]
            racePosition[index-1] = calling
            racePosition[index] = temp
            
            playerIndexMap[calling] = index-1
            playerIndexMap[temp] = index
        }
    }
    
    return racePosition
}


print(solution(["mumu", "soe", "poe", "kai", "mine"], ["kai", "kai", "mine", "mine"]))
