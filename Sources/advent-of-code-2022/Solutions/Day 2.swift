//
//  Day2.swift
//  
//
//  Created by Loyi Hsu on 2022/12/2.
//

class Day2 {
    enum Move {
        case rock
        case paper
        case scissors

        var score: Int {
            switch self {
            case .rock:
                return 1
            case .paper:
                return 2
            case .scissors:
                return 3
            }
        }

        static func getMyMove(symbol: String) -> Move? {
            switch symbol {
            case "X":
                return .rock
            case "Y":
                return .paper
            case "Z":
                return .scissors
            default:
                return nil
            }
        }

        static func getOtherMove(symbol: String) -> Move? {
            switch symbol {
            case "A":
                return .rock
            case "B":
                return .paper
            case "C":
                return .scissors
            default:
                return nil
            }
        }
    }

    enum State {
        case win
        case draw
        case lose

        var score: Int {
            switch self {
            case .win:
                return 6
            case .draw:
                return 3
            case .lose:
                return 0
            }
        }

        static func getWinState(from string: String) -> State? {
            if string == "X" {
                return .lose
            } else if string == "Y" {
                return .draw
            } else if string == "Z" {
                return .win
            }
            return nil
        }
    }

    private func compare(myMove: Move, otherMove: Move) -> State {
        switch myMove {
        case .paper:
            switch otherMove {
            case .paper:
                return .draw
            case .rock:
                return .win
            case .scissors:
                return .lose
            }
        case .scissors:
            switch otherMove {
            case .paper:
                return .win
            case .rock:
                return .lose
            case .scissors:
                return .draw
            }
        case .rock:
            switch otherMove {
            case .paper:
                return .lose
            case .rock:
                return .draw
            case .scissors:
                return .win
            }
        }
    }

    func getMyMove(winState: State, otherMove: Move) -> Move {
        switch winState {
        case .win:
            switch otherMove {
            case .paper:
                return .scissors
            case .rock:
                return .paper
            case .scissors:
                return .rock
            }
        case .draw:
            switch otherMove {
            case .paper:
                return .paper
            case .rock:
                return .rock
            case .scissors:
                return .scissors
            }
        case .lose:
            switch otherMove {
            case .paper:
                return .rock
            case .rock:
                return .scissors
            case .scissors:
                return .paper
            }
        }
    }

    func solve1(input: String) -> Int {
        input
            .splitLines()
            .map {
                let elements = $0.splitList()
                let otherMove = Move.getOtherMove(symbol: elements[0])!
                let myMove = Move.getMyMove(symbol: elements[1])!
                let state = compare(myMove: myMove, otherMove: otherMove)
                return myMove.score + state.score
            }
            .sum()
    }

    func solve2(input: String) -> Int {
        return input
            .splitLines()
            .map {
                let elements = $0.splitList()
                let otherMove = Move.getOtherMove(symbol: elements[0])!
                let winState = State.getWinState(from: elements[1])!
                let myMove = getMyMove(winState: winState, otherMove: otherMove)
                return myMove.score + winState.score
            }
            .sum()
    }
}
