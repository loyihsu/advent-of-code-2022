//
//  Day 11.swift
//
//
//  Created by Yu-Sung Loyi Hsu on 2022/12/4.
//

class Day11 {
    func solve1(input: String) -> Int {
        let monkeyList = parseInput(input)
        return compute(
            monkeyList: monkeyList,
            rounds: 20,
            worryManager: { value in
                value / 3
            }
        )
    }

    func solve2(input: String) -> Int {
        let monkeyList = parseInput(input)
        let manager = monkeyList.map(\.div).reduce(1, *)
        return compute(
            monkeyList: monkeyList,
            rounds: 10000,
            worryManager: { value in
                value % manager
            }
        )
    }

    private func compute(monkeyList: [Monkey], rounds: Int, worryManager: (Int) -> Int) -> Int {
        var monkeyList = monkeyList
        (0 ..< rounds)
            .forEach { _ in
                for idx in monkeyList.indices {
                    while let item = monkeyList[idx].items.popFirst() {
                        let computed = worryManager(monkeyList[idx].operation(item))
                        monkeyList[monkeyList[idx].nextMonkey(computed)]
                            .items
                            .append(computed)
                        monkeyList[idx].inspection += 1
                    }
                }
            }
        return monkeyList.map(\.inspection).top(2).reduce(1, *)
    }

    private func parseInput(_ input: String) -> [Monkey] {
        input
            .splitParagraphs(shouldTrimWhitespacesAndNewlines: true)
            .compactMap { input -> Monkey? in
                var lines = input
                    .splitLines(shouldTrimWhitespacesAndNewlines: true)
                    .map {
                        $0.trimmingCharacters(in: .whitespaces)
                    }

                guard var monkeyIndex = lines.popFirst() else { return nil }
                monkeyIndex.consumeFirst("Monkey ".count)
                _ = monkeyIndex.popLast()

                let index = Int(monkeyIndex)!

                guard var startingItems = lines.popFirst() else { return nil }
                startingItems.consumeFirst("Starting items: ".count)
                let items = startingItems
                    .splitList(separator: ", ", shouldTrimWhitespacesAndNewlines: true)
                    .compactMap(Int.init)

                guard var operation = lines.popFirst() else { return nil }
                operation.consumeFirst("Operation: new = ".count)
                let compute: (Int) -> Int = { input in
                    let plus = operation.components(separatedBy: " + ")
                    let minus = operation.components(separatedBy: " - ")
                    let multiply = operation.components(separatedBy: " * ")
                    let divide = operation.components(separatedBy: " / ")
                    if plus.count > 1 {
                        if plus[0] == "old", plus[1] == "old" {
                            return input + input
                        } else if plus[0] == "old", let value = Int(plus[1]) {
                            return input + value
                        }
                    } else if minus.count > 1 {
                        if minus[0] == "old", minus[1] == "old" {
                            return input - input
                        } else if minus[0] == "old", let value = Int(minus[1]) {
                            return input - value
                        }
                    } else if multiply.count > 1 {
                        if multiply[0] == "old", multiply[1] == "old" {
                            return input * input
                        } else if multiply[0] == "old", let value = Int(multiply[1]) {
                            return input * value
                        }
                    } else if divide.count > 1 {
                        if divide[0] == "old", divide[1] == "old" {
                            return input / input
                        } else if divide[0] == "old", let value = Int(divide[1]) {
                            return input / value
                        }
                    }
                    return input
                }

                guard var test = lines.popFirst() else { return nil }
                guard var trueStatement = lines.popFirst() else { return nil }
                trueStatement.consumeFirst("If true: throw to monkey ".count)
                guard var falseStatement = lines.popFirst() else { return nil }
                falseStatement.consumeFirst("If false: throw to monkey ".count)
                test.consumeFirst("Test: divisible by ".count)
                let div = Int(test)!
                let next: (Int) -> Int = { value in
                    (value % div == 0)
                        ? Int(trueStatement)!
                        : Int(falseStatement)!
                }
                return Monkey(
                    index: index,
                    items: items,
                    operation: compute,
                    div: div,
                    nextMonkey: next
                )
            }
    }
}

// MARK: - Monkey

private struct Monkey {
    let index: Int
    var items: [Int]
    let operation: (Int) -> Int
    let nextMonkey: (Int) -> Int
    let div: Int
    var inspection: Int = 0

    init(index: Int, items: [Int], operation: @escaping (Int) -> Int, div: Int, nextMonkey: @escaping (Int) -> Int) {
        self.index = index
        self.items = items
        self.operation = operation
        self.div = div
        self.nextMonkey = nextMonkey
    }
}

private extension Array where Element == Monkey {
    func template() -> [Monkey] {
        var copySelf = self
        for idx in copySelf.indices {
            copySelf[idx].items = []
        }
        return copySelf
    }
}
