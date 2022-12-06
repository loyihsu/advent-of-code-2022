//
//  Day 06.swift
//
//
//  Created by Yu-Sung Loyi Hsu on 2022/12/4.
//

class Day6 {
    func solve1(input: String) -> Int {
        process(string: input, characterWindowWidth: 4) ?? 0
    }

    func solve2(input: String) -> Int {
        process(string: input, characterWindowWidth: 14) ?? 0
    }

    private func process(string: String, characterWindowWidth: Int) -> Int? {
        var window = [Character]()

        for (idx, char) in string.enumerated() {
            window.append(char)

            if window.count > characterWindowWidth {
                _ = window.popFirst()
            }

            if window.count == characterWindowWidth, Set(window).count == window.count {
                return idx + 1
            }
        }

        return nil
    }
}
