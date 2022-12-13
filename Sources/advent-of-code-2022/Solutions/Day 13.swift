//
//  Day 13.swift
//
//
//  Created by Yu-Sung Loyi Hsu on 2022/12/4.
//

class Day13 {
    func solve1(input: String) -> Int {
        let list = input.splitParagraphs(shouldTrimWhitespacesAndNewlines: true)

        return list
            .enumerated()
            .map {
                return ($0, $1.components(separatedBy: .newlines).map { unwrapList($0) })
            }
            .filter { compare($1[0], $1[1]) <= 0 }
            .map { index, _ in
                index + 1
            }
            .sum()
    }

    func solve2(input: String) -> Int {
        let list = input
            .appending("""
            [[2]]
            [[6]]
            """)
            .splitList(separator: "\n", shouldTrimWhitespacesAndNewlines: true)
            .dropEmpty()

        return list
            .flatMap { listItem in
                listItem.components(separatedBy: .newlines)
            }
            .sorted {
                compare(unwrapList($0), unwrapList($1)) <= 0
            }
            .enumerated()
            .filter { _, value in
                value == "[[2]]" || value == "[[6]]"
            }
            .map { index, _ in
                index + 1
            }
            .reduce(1) { $0 * $1 }
    }

    private func unwrapList(_ value: String) -> [String] {
        var copy = value
        copy.consumeFirst()
        _ = copy.popLast()

        var list = copy.splitList(separator: ",", shouldTrimWhitespacesAndNewlines: false)
        var output = [String]()

        var temp: [String] = []
        var signal = 0

        while let current = list.popFirst() {
            if current.contains("[") {
                signal += current.filter { $0 == "[" }.count
            }

            if signal > 0 {
                temp.append(current)
            }

            if current.contains("]") {
                signal -= current.filter { $0 == "]" }.count
                if signal == 0 {
                    output.append(temp.joined(separator: ","))
                    temp = []
                }
                continue
            }

            if signal == 0 {
                output.append(current)
            }
        }

        return output.dropEmpty()
    }

    private func compare(_ lhs: [String], _ rhs: [String]) -> Int {
        let zipped = zip(lhs, rhs)

        for item in zipped {
            if let left = Int(item.0), let right = Int(item.1) {
                if left != right {
                    return left - right
                }
            } else {
                var left = item.0
                var right = item.1

                if Int(left) != nil {
                    left = "[\(left)]"
                }

                if Int(right) != nil {
                    right = "[\(right)]"
                }

                let sub = compare(unwrapList(left), unwrapList(right))

                if sub != 0 {
                    return sub
                }
            }
        }

        return lhs.count - rhs.count
    }
}

private extension Array where Element: Collection {
    func dropEmpty() -> [Element] {
        filter { !$0.isEmpty }
    }
}
