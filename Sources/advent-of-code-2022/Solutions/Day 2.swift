//
//  Day 2.swift
//
//
//  Created by Loyi Hsu on 2022/12/2.
//

class Day2 {
    enum Move: Int, Equatable {
        case rock = 1
        case paper = 2
        case scissors = 3

        static func getMove(symbol: String) -> Move? {
            switch symbol {
            case "A":
                return .rock
            case "B":
                return .paper
            case "C":
                return .scissors
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
    }

    enum State: Int {
        case win = 6
        case draw = 3
        case lose = 0

        static func getWinState(from string: String) -> State? {
            switch string {
            case "X":
                return .lose
            case "Y":
                return .draw
            case "Z":
                return .win
            default:
                return nil
            }
        }
    }

    func solve1(input: String) -> Int {
        computeRaces(input: input) { elements in
            let otherMove = Move.getMove(symbol: elements[0])!
            let myMove = Move.getMove(symbol: elements[1])!
            let winState = decideWin(this: myMove, that: otherMove)
            return (myMove, winState)
        }
    }

    func solve2(input: String) -> Int {
        computeRaces(input: input) { elements in
            let otherMove = Move.getMove(symbol: elements[0])!
            let winState = State.getWinState(from: elements[1])!
            let myMove = getMyMove(winState: winState, otherMove: otherMove)
            return (myMove, winState)
        }
    }

    private func computeRaces(input: String, getMyMoveAndWinState: ([String]) -> (Move, State)) -> Int {
        input
            .splitLines()
            .map {
                let elements = $0.splitList()
                let (myMove, winState) = getMyMoveAndWinState(elements)
                return myMove.rawValue + winState.rawValue
            }
            .sum()
    }

    private func decideWin(this: Move, that: Move) -> State {
        guard this != that else { return .draw }
        return that == getOtherMoveForWin(this: this) ? .win : .lose
    }

    private func getMyMove(winState: State, otherMove: Move) -> Move {
        switch winState {
        case .win:
            return getOtherMoveForLose(this: otherMove)
        case .draw:
            return otherMove
        case .lose:
            return getOtherMoveForWin(this: otherMove)
        }
    }

    private func getOtherMoveForWin(this: Move) -> Move {
        switch this {
        case .scissors:
            return .paper
        case .rock:
            return .scissors
        case .paper:
            return .rock
        }
    }

    private func getOtherMoveForLose(this: Move) -> Move {
        switch this {
        case .scissors:
            return .rock
        case .rock:
            return .paper
        case .paper:
            return .scissors
        }
    }
}
