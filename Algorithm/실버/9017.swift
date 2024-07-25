let T = Int(readLine()!)!

func findWinningTeam(N: Int, teamNumbers: [Int]) -> Int {
    
    var teamPeople: [Int: Int] = [:]
    var teamScores: [Int: [Int]] = [:]

    for team in teamNumbers {
        if teamPeople[team] == nil {
            teamPeople[team] = 0
        }
        teamPeople[team]! += 1
    }
    
    let validTeams = Set(teamPeople.filter { $0.value == 6 }.keys)
    
    var idx = 1
    for team in teamNumbers {
        if validTeams.contains(team) {
            if teamScores[team] == nil {
                teamScores[team] = []
            }
            teamScores[team]!.append(idx)
            idx += 1
        }
    }
    
    var minScore = Int.max
    var winningTeam = -1
    
//    print(teamScores)
    
    for team in teamScores.keys {
        let sortedScores = teamScores[team]!.sorted()
        let teamScore = sortedScores.prefix(4).reduce(0, +)
        let fifthScore = sortedScores[4]
        
        if teamScore < minScore || (teamScore == minScore && fifthScore < teamScores[winningTeam]?.sorted()[4] ?? Int.max) {
            minScore = teamScore
            winningTeam = team
        }
    }
    
    return winningTeam
}

for _ in 0..<T {
    let N = Int(readLine()!)!
    let t = readLine()!.split(separator: " ").map { Int($0)! }
    
    let winner = findWinningTeam(N: N, teamNumbers: t)
    
    print(winner)
}
