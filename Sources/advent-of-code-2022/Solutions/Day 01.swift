//
//  Day 01.swift
//
//
//  Created by Loyi Hsu on 2022/12/1.
//

class Day1 {
    func solve1(input: String) -> Int? {
        sumEachParagraph(input: input)
            .max()
    }

    func solve2(input: String) -> Int {
        sumEachParagraph(input: input)
            .top(3)
            .sum()
    }

    private func sumEachParagraph(input: String) -> [Int] {
        input
            .splitParagraphs(shouldTrimWhitespacesAndNewlines: true)
            .map {
                $0.integerList(separator: "\n").sum()
            }
    }
}
