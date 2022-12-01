//
//  Day 1.swift
//
//
//  Created by Loyi Hsu on 2022/12/1.
//

import Foundation

class Day1 {
    func solve1(input: String) -> Int? {
        return input
            .components(separatedBy: "\n\n")
            .map {
                $0.components(separatedBy: .newlines)
                    .compactMap {
                        Int($0)
                    }
                    .sum()
            }
            .max()
    }

    func solve2(input: String) -> Int {
        return input
            .components(separatedBy: "\n\n")
            .map {
                $0.components(separatedBy: .newlines)
                    .compactMap {
                        Int($0)
                    }
                    .sum()
            }
            .top(3)
            .sum()
    }
}
