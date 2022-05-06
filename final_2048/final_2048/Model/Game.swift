//
//  Game.swift
//  final_2048
//
//  Created by 我柯 on 2021/11/1.
//

import Foundation

enum Direction {
    case up
    case down
    case left
    case right
}

struct Position {
    var row: Int
    var col: Int
}

class Game {
    
    enum Status: Int {
        case running = 1
        case ended = 0
    }
    
    private var size: Int
    var world = [[Card]]()
    var status = Status.ended
    var goal = 2048
    
    init(size: Int) {
        self.size = size
    }
    
    private func generateNewCard() -> Action {
        var pool = [Position]()
        for row in 0..<size {
            for col in 0..<size {
                if world[row][col].getValue() == 0 {
                    pool.append(Position(row: row, col: col))
                }
            }
        }
        
        let index = Int(arc4random_uniform(UInt32(pool.count)))
        let value = Int((arc4random_uniform(2) + 1) * 2)
        world[pool[index].row][pool[index].col] = Card(value: value)
        
        return Action.new(at: pool[index], value: value)
    }
    
    private func getCleanWorld() -> [[Card]] {
        var clenWorld = [[Card]]()
        for row in 0..<size {
            clenWorld.append([])
            for _ in 0..<size {
                clenWorld[row].append(Card())
            }
        }
        return clenWorld
    }
    
    func start(completion: (_ actions: [Action]) -> Void) {
        world = getCleanWorld()
        var actions = [Action]()
        actions.append(generateNewCard())
        actions.append(generateNewCard())
        status = .running
        completion(actions)
    }
    
    func end() {
        status = .ended
    }
    
    func move(to direction: Direction, completion: (_ actions: [Action]) -> Void) {
        let tos: [Direction: [Int]] = [.left: [0, -1], .right: [0, 1], .up: [-1, 0], .down: [1, 0]]
        let to = tos[direction]!
        var actions = [Action]()
        var win = false
        var newWorld = getCleanWorld()
        var mergeable = Array(repeating: Array(repeating: true, count: size), count: size)
        
        var outerRange = stride(from: 0, to: size, by: 1)
        var innerRange = stride(from: 0, to: size, by: 1)
        if direction == .right || direction == .down {
            innerRange = stride(from: size - 1, to: -1, by: -1)
            if direction == .down {
                outerRange = stride(from: size - 1, to: -1, by: -1)
            }
        }

        for row in outerRange {
            for col in innerRange {
                if world[row][col].getValue() == 0 { continue }
                var tx = row, ty = col
                while (true) {
                    if newWorld[tx][ty].getValue() == 0 {
                        tx += to[0]; ty += to[1]
                        if (!inBound(row: tx, col: ty)) {
                            tx -= to[0]; ty -= to[1]
                            if tx != row || ty != col {
                                actions.append(
                                    .move(
                                        from: Position(row: row, col: col),
                                        to: Position(row: tx, col: ty)
                                    )
                                )
                            }
                            break
                        }
                    } else {
                        if mergeable[tx][ty],
                            newWorld[tx][ty].getValue() == world[row][col].getValue() {
                            actions.append(
                                .upgrade(
                                    from: Position(row: row, col: col),
                                    to: Position(row: tx, col: ty),
                                    newValue: world[row][col].upgrade()
                                )
                            )
                            mergeable[tx][ty] = false
                        } else {
                            tx -= to[0]; ty -= to[1]
                            if tx != row || ty != col {
                                actions.append(
                                    .move(
                                        from: Position(row: row, col: col),
                                        to: Position(row: tx, col: ty)
                                    )
                                )
                            }
                        }
                        break
                    }
                }
                newWorld[tx][ty] = world[row][col]
                if newWorld[tx][ty].getValue() == goal {
                    win = true
                }
            }
        }
        
        world = newWorld
        if actions.count > 0 {
            actions.append(generateNewCard())
        }
        
        if win {
            actions.append(.success)
        } else if checkFailure() {
            actions.append(.failure)
        }
        completion(actions)
    }
    
    private func checkFailure() -> Bool {
        let tos = [[1, 0], [-1, 0], [0, 1], [0, -1]]
        for row in 0..<size {
            for col in 0..<size {
                if world[row][col].getValue() == 0 {
                    return false
                } else {
                    for to in tos {
                        let tx = row + to[0], ty = col + to[1]
                        if inBound(row: tx, col: ty),
                            world[row][col].getValue() == world[tx][ty].getValue() {
                            return false
                        }
                    }
                }
            }
        }
        return true
    }
    
    private func inBound(row: Int, col: Int) -> Bool {
        return row >= 0 && col >= 0 && row < size && col < size
    }
    
    func debugPrint() {
        for w in world {
            print(w.map({ $0.getValue() }))
        }
        print()
    }
    
}
