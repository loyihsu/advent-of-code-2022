//
//  Day 05.swift
//
//
//  Created by Yu-Sung Loyi Hsu on 2022/12/4.
//

class Day5 {
    func solve1(input: String) -> String {
        var (stackMap, commands) = parseInput(input)

        commands
            .forEach {
                $0.apply(on: &stackMap, persistOrdering: false)
            }

        return stackMap
            .compactMap(\.last)
            .joined()
    }

    func solve2(input: String) -> String {
        var (stackMap, commands) = parseInput(input)

        commands
            .forEach {
                $0.apply(on: &stackMap, persistOrdering: true)
            }

        return stackMap
            .compactMap(\.last)
            .joined()
    }

    private func parseInput(_ input: String) -> (stackMap: [[String]], commands: [Command]) {
        let components = input.splitParagraphs(shouldTrimWhitespacesAndNewlines: false)
        return (parseStackMap(components[0]), parseCommands(components[1]))
    }

    private func parseStackMap(_ rawInput: String) -> [[String]] {
        var lines = rawInput.splitLines(shouldTrimWhitespacesAndNewlines: false)
        let last = lines.popLast()!
        let stackCount = last.splitList(separator: " ", shouldTrimWhitespacesAndNewlines: false)
            .compactMap(Int.init)
            .count
        var output = [[String]](repeating: [], count: stackCount)

        lines.forEach { line in
            var copyLine = line
            for idx in 0 ..< stackCount {
                if let first = copyLine.consumeFirst(3) {
                    let content = first.trimmingCharacters(in: .whitespaces)
                    if !content.isEmpty {
                        let item = content
                            .replacingOccurrences(of: "[", with: "")
                            .replacingOccurrences(of: "]", with: "")
                        output[idx].append(item)
                    }
                }
                copyLine.consumeFirst()
            }
        }

        return output
            .map {
                $0.reversed()
            }
    }

    private func parseCommands(_ rawInput: String) -> [Command] {
        rawInput
            .splitLines(shouldTrimWhitespacesAndNewlines: true)
            .map {
                let components = $0
                    .components(separatedBy: .whitespaces)
                    .compactMap(Int.init)
                return Command(count: components[0], from: components[1], to: components[2])
            }
    }
}

private struct Command {
    let count: Int
    let from: Int
    let to: Int

    func apply(on stackMap: inout [[String]], persistOrdering: Bool) {
        var temp = [String]()
        for _ in 0 ..< count {
            if let top = stackMap[from - 1].popLast() {
                temp.append(top)
            }
        }
        if persistOrdering {
            stackMap[to - 1].append(contentsOf: temp.reversed())
        } else {
            stackMap[to - 1].append(contentsOf: temp)
        }
    }
}
