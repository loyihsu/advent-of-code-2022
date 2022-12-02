//
//  Helpers.swift
//
//
//  Created by Loyi Hsu on 2022/12/1.
//

import Foundation

extension Array where Element == Int {
    func sum() -> Int {
        reduce(0, +)
    }

    func top(_ count: Int) -> [Int] {
        var copySelf = self

        guard count > 0 else { return [] }

        return (0 ..< count)
            .compactMap { _ in
                copySelf.maxAndPop()
            }
    }

    private mutating func maxAndPop() -> Int? {
        guard let max = enumerated()
            .max(by: { $0.element < $1.element })
        else {
            return nil
        }
        remove(at: max.offset)
        return max.element
    }
}

func fetchSampleData(filename: String) throws -> String {
    let input = Bundle.module.path(forResource: "\(filename)", ofType: "txt")!
    let fileContent = try String(contentsOfFile: input)
    return fileContent
}

extension String {
    func splitParagraphs() -> [String] {
        components(separatedBy: "\n\n")
    }

    func splitLines() -> [String] {
        trimmingCharacters(in: .newlines)
            .components(separatedBy: .newlines)
    }

    func splitList() -> [String] {
        components(separatedBy: .whitespaces)
    }

    func integerList() -> [Int] {
        splitLines()
            .compactMap(Int.init)
    }
}
