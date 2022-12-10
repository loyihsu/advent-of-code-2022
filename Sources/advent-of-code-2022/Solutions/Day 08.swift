//
//  Day 08.swift
//
//
//  Created by Yu-Sung Loyi Hsu on 2022/12/4.
//

class Day8 {
    func solve1(input: String) -> Int {
        let list = handleInput(input)
        return findVisible(list: list)
    }

    func solve2(input: String) -> Int {
        let list = handleInput(input)
        return findBestViewingScore(list: list)
    }

    private func handleInput(_ input: String) -> [[Int]] {
        input
            .splitLines(shouldTrimWhitespacesAndNewlines: true)
            .map { string in
                string
                    .map(String.init)
                    .compactMap(Int.init)
            }
    }

    private func findTallest(list: [[Int]], currentPosition: (idx: Int, jdx: Int)) -> (top: Int, bottom: Int, left: Int, right: Int) {
        let (idx, jdx) = currentPosition

        let tallest = Direction.allCases
            .map { direction in
                direction.getRange(idx: idx, jdx: jdx, length: (first: list.count, second: list[idx].count))
                    .map { ndx -> Int in
                        let adx = direction.navigationMode == .horizontal ? idx : ndx
                        let bdx = direction.navigationMode == .horizontal ? ndx : jdx
                        return list[adx][bdx]
                    }
                    .max()!
            }

        return (top: tallest[0], bottom: tallest[1], left: tallest[2], right: tallest[3])
    }

    private func findVisible(list: [[Int]]) -> Int {
        var visibleCount = 0

        for idx in list.indices {
            for jdx in list[idx].indices {
                let edgeTop = idx == 0
                let edgeLeft = jdx == 0
                let edgeBottom = idx == list.count - 1
                let edgeRight = jdx == list[idx].count - 1

                if edgeTop || edgeLeft || edgeBottom || edgeRight {
                    visibleCount += 1
                } else {
                    let (findTop, findBottom, findLeft, findRight) = findTallest(list: list, currentPosition: (idx: idx, jdx: jdx))

                    let visibleFromTop = findTop < list[idx][jdx]
                    let visibleFromBottom = findBottom < list[idx][jdx]
                    let visibleFromLeft = findLeft < list[idx][jdx]
                    let visibleFromRight = findRight < list[idx][jdx]

                    if visibleFromTop || visibleFromBottom || visibleFromLeft || visibleFromRight {
                        visibleCount += 1
                    }
                }
            }
        }
        return visibleCount
    }

    private func findBestViewingScore(list: [[Int]]) -> Int {
        var score = 0
        for idx in list.indices {
            for jdx in list[idx].indices {
                let current = findScore(list: list, idx: idx, jdx: jdx)
                score = max(score, current)
            }
        }
        return score
    }

    private func findScore(list: [[Int]], idx: Int, jdx: Int) -> Int {
        Direction.allCases
            .reduce(1) {
                $0 * findNavigationDistance(direction: $1, list: list, idx: idx, jdx: jdx)
            }
    }

    private func findNavigationDistance(direction: Direction, list: [[Int]], idx: Int, jdx: Int) -> Int {
        var distance = 0
        for ndx in direction.getRange(idx: idx, jdx: jdx, length: (first: list.count, second: list[idx].count)) {
            distance += 1
            let adx = direction.navigationMode == .horizontal ? idx : ndx
            let bdx = direction.navigationMode == .horizontal ? ndx : jdx
            if list[adx][bdx] >= list[idx][jdx] {
                break
            }
        }
        return distance
    }
}

// MARK: - Navigation Helpers

private enum Direction: CaseIterable {
    case top, left, right, bottom

    static var allCases: [Direction] {
        [.top, .left, .right, .bottom]
    }

    var navigationMode: NavigationMode {
        switch self {
        case .top, .bottom:
            return .vertical
        case .left, .right:
            return .horizontal
        }
    }

    func getRange(idx: Int, jdx: Int, length: (first: Int, second: Int)) -> [Int] {
        switch self {
        case .top:
            return Array((0 ..< idx).reversed())
        case .bottom:
            return Array(idx + 1 ..< length.first)
        case .left:
            return Array((0 ..< jdx).reversed())
        case .right:
            return Array(jdx + 1 ..< length.second)
        }
    }
}

private enum NavigationMode {
    case horizontal
    case vertical
}
