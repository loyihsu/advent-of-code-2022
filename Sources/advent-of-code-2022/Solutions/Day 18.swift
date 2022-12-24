//
//  Day 18.swift
//
//
//  Created by Yu-Sung Loyi Hsu on 2022/12/4.
//

class Day18 {
    func solve1(input: String) -> Int {
        let points = handleInputs(input: input)
        return points
            .map { point in
                point
                    .findAllNeighbours()
                    .filter {
                        !points.contains($0)
                    }
            }
            .map(\.count)
            .sum()
    }

    func solve2(input: String) -> Int {
        let input = handleInputs(input: input)

        let lowerbound = input.findMin() - 1
        let upperbound = input.findMax() + 2

        var searching = [Dimension3(x: lowerbound, y: lowerbound, z: lowerbound)]
        var visited = Set<Dimension3>()

        var count = 0

        while let first = searching.popLast() {
            if !visited.contains(first) {
                visited.insert(first)

                for neighbour in first.findAllNeighbours() where neighbour.fullyWithin(lowerbound ... upperbound) {
                    if input.contains(neighbour) {
                        count += 1
                    } else {
                        searching.append(neighbour)
                    }
                }
            }
        }

        return count
    }

    private func handleInputs(input: String) -> [Dimension3] {
        input
            .splitLines(shouldTrimWhitespacesAndNewlines: true)
            .map {
                $0.splitList(separator: ",", shouldTrimWhitespacesAndNewlines: true).compactMap(Int.init)
            }
            .map {
                Dimension3(x: $0[0], y: $0[1], z: $0[2])
            }
    }
}

private struct Dimension3: Equatable, Hashable {
    let x: Int
    let y: Int
    let z: Int

    func findAllNeighbours() -> [Dimension3] {
        [
            Dimension3(x: x - 1, y: y, z: z),
            Dimension3(x: x + 1, y: y, z: z),
            Dimension3(x: x, y: y - 1, z: z),
            Dimension3(x: x, y: y + 1, z: z),
            Dimension3(x: x, y: y, z: z - 1),
            Dimension3(x: x, y: y, z: z + 1),
        ]
    }

    func fullyWithin(_ range: any RangeExpression<Int>) -> Bool {
        [x, y, z].allSatisfy {
            range.contains($0)
        }
    }
}

private extension Array where Element == Dimension3 {
    func findMin() -> Int {
        [map(\.x).min()!, map(\.y).min()!, map(\.z).min()!].min()!
    }

    func findMax() -> Int {
        [map(\.x).max()!, map(\.y).max()!, map(\.z).max()!].max()!
    }
}
