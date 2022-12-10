//
//  Day 10.swift
//
//
//  Created by Yu-Sung Loyi Hsu on 2022/12/4.
//

class Day10 {
    enum Command {
        case addx(value: Int)
        case noop

        func exec(register: inout Int, cycles: inout Int) {
            switch self {
            case let .addx(value):
                register += value
                cycles += 2
            case .noop:
                cycles += 1
            }
        }
    }

    func solve1(input: String) -> Int {
        let logs = getLogs(input: input)
        let checkpoints = [20, 60, 100, 140, 180, 220]
        return checkpoints.reduce(0) {
            $0 + $1 * logs[$1]
        }
    }

    func solve2(input: String) -> String {
        let logs = getLogs(input: input)
        var screen = [Bool]()

        for idx in 1 ... 240 {
            let currentCenter = logs[idx]
            let currentRange = currentCenter - 1 ... currentCenter + 1
            screen.append(currentRange.contains((idx - 1) % 40))
        }

        return makeScreenRepresentation(signals: screen)
    }

    private func getLogs(input: String) -> [Int] {
        var register = 1, cycle = 0
        var output = [1]

        input
            .splitLines(shouldTrimWhitespacesAndNewlines: true)
            .compactMap {
                let components = $0.components(separatedBy: " ")
                if components[0] == "addx", let value = Int(components[1]) {
                    return Command.addx(value: value)
                } else if components[0] == "noop" {
                    return Command.noop
                }
                return nil
            }
            .forEach { (command: Command) in
                command.exec(register: &register, cycles: &cycle)
                while output.count <= cycle, let log = output.last {
                    output.append(log)
                }
                output.append(register)
            }

        return output
    }

    private func makeScreenRepresentation(signals: [Bool]) -> String {
        signals
            .map {
                $0 == true ? "#" : "."
            }
            .chunked(40)
            .map(String.init(_:))
            .joined(separator: "\n")
    }
}
