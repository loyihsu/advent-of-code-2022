//
//  Day 03.swift
//
//
//  Created by Loyi Hsu on 2022/12/2.
//

class Day3 {
    let allCharacters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        .enumerated()
        .reduce(into: [Character: Int]()) { prev, this in
            prev[this.element] = this.offset + 1
        }

    func solve1(input: String) -> Int {
        input
            .splitLines(shouldTrimWhitespacesAndNewlines: true)
            .map(Array.init)
            .map(splitCompartments(line:))
            .compactMap { this, that in
                this.findOneAndOnlyCommonCharacter(in: that, duplicationHandlingStrategy: .duplicatesConsideredSame)
            }
            .compactMap {
                allCharacters[$0]
            }
            .sum()
    }

    func solve2(input: String) -> Int {
        input
            .splitLines(shouldTrimWhitespacesAndNewlines: true)
            .map(Array.init)
            .chunked(3)
            .compactMap {
                let first = $0[0].findCommonCharacters(in: $0[1], duplicationHandlingStrategy: .duplicatesConsideredSame)
                let second = $0[1].findCommonCharacters(in: $0[2], duplicationHandlingStrategy: .duplicatesConsideredSame)
                return first.findOneAndOnlyCommonCharacter(in: second, duplicationHandlingStrategy: .duplicatesConsideredSame)
            }
            .compactMap {
                allCharacters[$0]
            }
            .sum()
    }

    private func splitCompartments(line: [Character]) -> ([Character], [Character]) {
        let half = line.count / 2
        let startIndex = line.startIndex
        let halfIndex = line.index(startIndex, offsetBy: half)
        return (Array(line[startIndex ..< halfIndex]), Array(line[halfIndex...]))
    }
}
