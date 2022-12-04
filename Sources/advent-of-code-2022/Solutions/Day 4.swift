//
//  Day 4.swift
//
//
//  Created by Yu-Sung Loyi Hsu on 2022/12/4.
//

class Day4 {
    func solve1(input: String) -> Int {
        handleInputs(input: input) { first, second in
            let bigger = first.count > second.count ? first : second
            let smaller = bigger == first ? second : first
            return smaller.allSatisfy { bigger.contains($0) }
        }
    }

    func solve2(input: String) -> Int {
        handleInputs(input: input) { first, second in
            first.overlaps(second)
        }
    }

    private func handleInputs(input: String, _ compare: @escaping (ClosedRange<Int>, ClosedRange<Int>) -> Bool) -> Int {
        input
            .splitLines()
            .map {
                $0.splitList(separator: ",")
            }
            .filter {
                guard let first = makeClosedRange($0[0]),
                      let second = makeClosedRange($0[1])
                else { return false }
                return compare(first, second)
            }
            .count
    }

    private func makeClosedRange(_ input: String) -> ClosedRange<Int>? {
        input
            .integerList(separator: "-")
            .convertToClosedRange()
    }
}

private extension Array where Element == Int {
    func convertToClosedRange() -> ClosedRange<Int>? {
        guard count == 2 else { return nil }
        guard let first = first, let last = last else { return nil }
        return first ... last
    }
}
