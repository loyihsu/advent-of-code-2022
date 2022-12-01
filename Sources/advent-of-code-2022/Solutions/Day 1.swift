//
//  Day 1.swift
//
//
//  Created by Loyi Hsu on 2022/12/1.
//

import Foundation

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
            .splitParagraphs()
            .map {
                $0.integerList().sum()
            }
    }
}
