//
//  Day3.swift
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
        return input
            .splitLines()
            .map(Array.init)
            .map(splitCompartments(line:))
            .compactMap { (this, that) in
                return this.findFirstCommonCharacter(in: that)
            }
            .compactMap {
                allCharacters[$0]
            }
            .sum()
    }

    func solve2(input: String) -> Int {
        return input
            .splitLines()
            .map(Array.init)
            .chunked(3)
            .compactMap {
                let first = $0[0].findCommonCharacters(in: $0[1])
                let second = $0[1].findCommonCharacters(in: $0[2])

                return first.findFirstCommonCharacter(in: second)
            }
            .compactMap {
                allCharacters[$0]
            }
            .sum()
    }

    private func splitCompartments(line: Array<Character>) -> (Array<Character>, Array<Character>) {
        let half = line.count / 2
        let startIndex = line.startIndex
        let halfIndex = line.index(startIndex, offsetBy: half)
        return (Array(line[startIndex..<halfIndex]), Array(line[halfIndex...]))
    }
}
