import Foundation

func solution(_ park: [String], _ routes: [String]) -> [Int] {
    var (park, x, y) = (park.map{$0.map{String($0)}}, 0, 0)
    
    for i in 0..<park.count {
        for j in 0..<park[0].count where park[i][j] == "S" {
            (x, y) = (i, j)
        }
    }
    
    func isIn(_ x: Int, _ y: Int) -> Bool {
        x >= 0 && y >= 0 && x < park.count && y < park[0].count
    }
    
    for dirwei in routes {
        let dirwei = dirwei.split { $0 == " " }.map { String($0) }
        let (dir, wei) = (dirwei[0], dirwei[1])
        var (ixiy, skip) = ((0, 0), false)
        
        switch dir {
        case "N":
            ixiy = (-1, 0)
        case "S":
            ixiy = (1, 0)
        case "W":
            ixiy = (0, -1)
        default:
            ixiy = (0, 1)
        }
        
        var (X, Y) = (x, y)
        
        for _ in 0..<Int(wei)! where !skip {
            (X, Y) = (X + ixiy.0, Y + ixiy.1)
            if !isIn(X, Y) { skip = true; break }
            if park[X][Y] == "X" { skip = true; }
        }
        if skip { continue }
        (x, y) = (X, Y)
    }
    return [x, y]
}
