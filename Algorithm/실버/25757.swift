let l = readLine()!.split(separator: " ")

let N = Int(l[0])!
let game = String(l[1])

let dict = ["Y": 2, "F": 3, "O": 4]

var players = Set<String>()

for i in 0..<N {
    let player = readLine()!
    players.insert(player)
}

let playerCount = players.count

print(playerCount / (dict[game]!-1))
