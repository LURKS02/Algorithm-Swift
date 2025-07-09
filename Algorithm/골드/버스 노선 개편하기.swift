let N = Int(readLine()!)!

struct Bus: Comparable {
    let S: Int
    let E: Int
    let C: Int
    
    static func <(lhs: Bus, rhs: Bus) -> Bool {
        return lhs.S < rhs.S
    }
}

var buses: [Bus] = []

for _ in 0..<N {
    let line = readLine()!.split(separator: " ").map { Int($0)! }
    
    let S = line[0]
    let E = line[1]
    let C = line[2]
    
    buses.append(Bus(S: S, E: E, C: C))
}

buses.sort()

var convertedBuses: [Bus] = []

var start = -1
var end = -1
var cost = 0

for bus in buses {
    if end < bus.S {
        if start != -1 && end != -1 {
            convertedBuses.append(Bus(S: start, E: end, C: cost))
        }
        
        start = bus.S
        end = bus.E
        cost = bus.C
    } else {
        end = max(end, bus.E)
        cost = min(cost, bus.C)
    }
}

convertedBuses.append(Bus(S: start, E: end, C: cost))

print(convertedBuses.count)

for bus in convertedBuses {
    print("\(bus.S) \(bus.E) \(bus.C)")
}
