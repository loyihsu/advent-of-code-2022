//
//  Day 25.swift
//
//
//  Created by Yu-Sung Loyi Hsu on 2022/12/4.
//

class Day25 {
    private let symbols = "=-012"
        .reduce(into: [Character: Int]()) {
            switch $1 {
            case "=":
                $0[$1] = -2
            case "-":
                $0[$1] = -1
            default:
                $0[$1] = Int(String($1))
            }
        }

    func solve(input: String) -> String {
        let sum = input
            .splitLines(shouldTrimWhitespacesAndNewlines: true)
            .map(interpretSNAFU(input:))
            .sum()
        return convertToSNAFU(sum)
    }

    private func interpretSNAFU(input: String) -> Int {
        let input = Array(input.reversed())

        var sum = 0

        for idx in input.indices {
            sum += symbols[input[idx]]! * power(5, to: idx)
        }

        return sum
    }

    private func power(_ base: Int, to: Int) -> Int {
        var output = 1
        for _ in 0 ..< to {
            output *= base
        }
        return output
    }

    private func convertToSNAFU(_ input: Int) -> String {
        var input = input
        var result = [Character]()
        let converter = Array("012=-")

        while input > 0 {
            result.append(converter[input % 5])
            input -= ((input + 2) % 5) - 2
            input /= 5
        }

        return String(result.reversed())
    }
}
