//
//  Helpers.swift
//
//
//  Created by Loyi Hsu on 2022/12/1.
//

import Foundation

extension Array {
    func chunked(_ count: Int) -> [[Element]] {
        var copySelf = self
        var temp = [Element]()
        var output = [[Element]]()

        while let item = copySelf.popFirst() {
            temp.append(item)

            if temp.count == count {
                output.append(temp)
                temp = []
            }
        }

        if !temp.isEmpty {
            output.append(temp)
        }

        return output
    }

    mutating func popFirst() -> Element? {
        guard !isEmpty else { return nil }
        return removeFirst()
    }
}


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
        trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: "\n\n")
    }

    func splitLines() -> [String] {
        trimmingCharacters(in: .newlines)
            .components(separatedBy: .newlines)
    }

    func splitList(separator: String = " ") -> [String] {
        trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: separator)
            .map {
                $0.trimmingCharacters(in: .whitespaces)
            }
    }

    func integerList() -> [Int] {
        splitLines()
            .compactMap(Int.init)
    }
}

extension Array where Element == Character {
    func findFirstCommonCharacter(in another: [Character]) -> Character? {
        let this = Set(self)
        let that = Set(another)
        return this.first(where: { that.contains($0) })
    }

    func findCommonCharacters(in another: [Character]) -> [Character] {
        let this = Set(self)
        let that = Set(another)
        return this.filter { that.contains($0) }
    }
}
