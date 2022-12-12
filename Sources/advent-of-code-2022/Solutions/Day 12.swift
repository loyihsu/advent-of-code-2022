//
//  Day 12.swift
//
//
//  Created by Yu-Sung Loyi Hsu on 2022/12/4.
//

import Foundation

class Day12 {
    private let elevations: [Character: Int] = {
        var base = "abcdefghijklmnopqrstuvwxyz"
            .enumerated()
            .reduce(into: [Character: Int]()) {
                $0[$1.element] = $1.offset
            }
        base["S"] = base["a"]
        base["E"] = base["z"]
        return base
    }()

    private func getElevation(_ character: Character) -> Int {
        elevations[character, default: 0]
    }

    func solve1(input: String) -> Int {
        let list = handleInput(input)
        let start = findStartPosition(list: list)
        let end = findEndPosition(list: list)
        let found = navigate(list: list, start: start, end: end)
        return found
    }

    func solve2(input: String) -> Int {
        let list = handleInput(input)
        let end = findEndPosition(list: list)
        return backtrace(list: list, start: end)
    }

    private func handleInput(_ input: String) -> [[Character]] {
        input
            .splitLines(shouldTrimWhitespacesAndNewlines: true)
            .map(Array.init)
    }

    private func findStartPosition(list: [[Character]]) -> (Int, Int) {
        find(character: "S", list: list)
    }

    private func findEndPosition(list: [[Character]]) -> (Int, Int) {
        find(character: "E", list: list)
    }

    private func find(character: Character, list: [[Character]]) -> (Int, Int) {
        for idx in list.indices {
            for jdx in list[idx].indices {
                if list[idx][jdx] == character {
                    return (idx, jdx)
                }
            }
        }
        fatalError("not found")
    }

    private func navigate(list: [[Character]], start: (row: Int, col: Int), end: (row: Int, col: Int)) -> Int {
        var unvisited = list.enumerated().flatMap { index, value in
            value.indices.map { jndex in
                Node(row: index, col: jndex)
            }
        }

        var visited = [Node]()

        var ended: Bool {
            !visited.contains(where: { $0.row == end.row && $0.col == end.col })
        }

        let start = unvisited.firstIndex(where: { $0.row == start.row && $0.col == start.col })!
        unvisited[start].cost = 0

        while let this = minAndPopByCost(&unvisited), ended {
            visited.append(this)

            if let left = this.getLeft(in: list, from: unvisited),
               compare(lhs: list[unvisited[left].row][unvisited[left].col], rhs: list[this.row][this.col])
            {
                unvisited[left].cost = min(unvisited[left].cost, this.cost + 1)
            }

            if let right = this.getRight(in: list, from: unvisited),
               compare(lhs: list[unvisited[right].row][unvisited[right].col], rhs: list[this.row][this.col])
            {
                unvisited[right].cost = min(unvisited[right].cost, this.cost + 1)
            }

            if let up = this.getUp(in: list, from: unvisited),
               compare(lhs: list[unvisited[up].row][unvisited[up].col], rhs: list[this.row][this.col])
            {
                unvisited[up].cost = min(unvisited[up].cost, this.cost + 1)
            }

            if let down = this.getDown(in: list, from: unvisited),
               compare(lhs: list[unvisited[down].row][unvisited[down].col], rhs: list[this.row][this.col])
            {
                unvisited[down].cost = min(unvisited[down].cost, this.cost + 1)
            }
        }

        guard let result = visited.first(where: { $0.row == end.row && $0.col == end.col }) else { return Int.max }
        return result.cost
    }

    private func backtrace(list: [[Character]], start: (row: Int, col: Int)) -> Int {
        var unvisited = list.enumerated()
            .flatMap { index, value in
                value.indices.map { jndex in
                    Node(row: index, col: jndex)
                }
            }

        var visited = [Node]()

        var ended: Bool {
            visited.contains { getElevation(list[$0.row][$0.col]) == 0 }
        }

        let start = unvisited.firstIndex(where: { $0.row == start.row && $0.col == start.col })!
        unvisited[start].cost = 0

        while let this = minAndPopByCost(&unvisited), !ended {
            visited.append(this)

            if let left = this.getLeft(in: list, from: unvisited),
               compare(lhs: list[this.row][this.col], rhs: list[unvisited[left].row][unvisited[left].col])
            {
                unvisited[left].cost = min(unvisited[left].cost, this.cost + 1)
            }

            if let right = this.getRight(in: list, from: unvisited),
               compare(lhs: list[this.row][this.col], rhs: list[unvisited[right].row][unvisited[right].col])
            {
                unvisited[right].cost = min(unvisited[right].cost, this.cost + 1)
            }

            if let up = this.getUp(in: list, from: unvisited),
               compare(lhs: list[this.row][this.col], rhs: list[unvisited[up].row][unvisited[up].col])
            {
                unvisited[up].cost = min(unvisited[up].cost, this.cost + 1)
            }

            if let down = this.getDown(in: list, from: unvisited),
               compare(lhs: list[this.row][this.col], rhs: list[unvisited[down].row][unvisited[down].col])
            {
                unvisited[down].cost = min(unvisited[down].cost, this.cost + 1)
            }
        }

        guard let result = visited.first(where: { getElevation(list[$0.row][$0.col]) == 0 }) else { return Int.max }
        return result.cost
    }

    private func compare(lhs: Character, rhs: Character) -> Bool {
        getElevation(lhs) - getElevation(rhs) <= 1
    }

    private func minAndPopByCost(_ unvisited: inout [Node]) -> Node? {
        guard let min = unvisited.min(by: { $0.cost < $1.cost }) else { return nil }
        unvisited.removeAll(where: { $0.row == min.row && $0.col == min.col })
        return min
    }
}

private struct Node: Hashable {
    var row: Int
    var col: Int
    var cost = Int.max

    func getLeft(in _: [[Character]], from unvisited: [Node]) -> Int? {
        guard col - 1 >= 0 else { return nil }
        return unvisited.firstIndex(where: { $0.row == row && $0.col == col - 1 })
    }

    func getRight(in list: [[Character]], from unvisited: [Node]) -> Int? {
        guard col + 1 < list[0].count else { return nil }
        return unvisited.firstIndex(where: { $0.row == row && $0.col == col + 1 })
    }

    func getUp(in _: [[Character]], from unvisited: [Node]) -> Int? {
        guard row - 1 >= 0 else { return nil }
        return unvisited.firstIndex(where: { $0.row == row - 1 && $0.col == col })
    }

    func getDown(in list: [[Character]], from unvisited: [Node]) -> Int? {
        guard row + 1 < list.count else { return nil }
        return unvisited.firstIndex(where: { $0.row == row + 1 && $0.col == col })
    }
}
