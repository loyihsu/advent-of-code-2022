//
//  Day 09.swift
//
//
//  Created by Yu-Sung Loyi Hsu on 2022/12/4.
//

import Foundation

struct Position: Hashable {
    var x = 0
    var y = 0

    func distance(from another: Position) -> Int {
        let xDistance = Double(x - another.x)
        let yDistance = Double(y - another.y)
        return Int(sqrt(xDistance * xDistance + yDistance * yDistance))
    }
}

class Day9 {
    func solve1(input: String) -> Int {
        var headPosition = Position()
        var lastHeadPosition = Position()
        var tailPosition = Position()
        var tailBook = Set<Position>([tailPosition])

        input
            .splitLines(shouldTrimWhitespacesAndNewlines: true)
            .map {
                $0.components(separatedBy: .whitespaces)
            }
            .forEach {
                if $0[0] == "R", let distance = Int($0[1]) {
                    for _ in 0 ..< distance {
                        lastHeadPosition = headPosition
                        headPosition.x += 1
                        if headPosition.distance(from: tailPosition) > 1 {
                            tailPosition = lastHeadPosition
                            tailBook.insert(tailPosition)
                        }
                    }
                }

                if $0[0] == "L", let distance = Int($0[1]) {
                    for _ in 0 ..< distance {
                        lastHeadPosition = headPosition
                        headPosition.x -= 1
                        if headPosition.distance(from: tailPosition) > 1 {
                            tailPosition = lastHeadPosition
                            tailBook.insert(tailPosition)
                        }
                    }
                }

                if $0[0] == "U", let distance = Int($0[1]) {
                    for _ in 0 ..< distance {
                        lastHeadPosition = headPosition
                        headPosition.y -= 1
                        if headPosition.distance(from: tailPosition) > 1 {
                            tailPosition = lastHeadPosition
                            tailBook.insert(tailPosition)
                        }
                    }
                }

                if $0[0] == "D", let distance = Int($0[1]) {
                    for _ in 0 ..< distance {
                        lastHeadPosition = headPosition
                        headPosition.y += 1
                        if headPosition.distance(from: tailPosition) > 1 {
                            tailPosition = lastHeadPosition
                            tailBook.insert(tailPosition)
                        }
                    }
                }
            }
        return tailBook.count
    }

    func solve2(input: String) -> Int {
        simulate(input: input, knots: kno)
    }

    private func simulate(input: String, knots: Int) -> Int {
        var headPosition = [Position](repeating: Position(), count: knots)
        var tailBook = Set<Position>([Position()])

        input
            .splitLines(shouldTrimWhitespacesAndNewlines: true)
            .map {
                $0.components(separatedBy: .whitespaces)
            }
            .forEach {
                if $0[0] == "R", let distance = Int($0[1]) {
                    for _ in 0 ..< distance {
                        headPosition[0].x += 1

                        for idx in headPosition.indices.dropFirst() {
                            if headPosition[idx].distance(from: headPosition[idx - 1]) > 1 {
                                headPosition[idx].x += 1
                            }
                            if idx == headPosition.count - 1 {
                                tailBook.insert(headPosition[idx])
                            }
                        }
                    }
                }

                if $0[0] == "L", let distance = Int($0[1]) {
                    for _ in 0 ..< distance {
                        headPosition[0].x -= 1

                        for idx in headPosition.indices.dropFirst() {
                            if headPosition[idx].distance(from: headPosition[idx - 1]) > 1 {
                                headPosition[idx].x -= 1
                            }
                            if idx == headPosition.count - 1 {
                                tailBook.insert(headPosition[idx])
                            }
                        }
                    }
                }

                if $0[0] == "U", let distance = Int($0[1]) {
                    for _ in 0 ..< distance {
                        headPosition[0].y -= 1

                        for idx in headPosition.indices.dropFirst() {
                            if headPosition[idx].distance(from: headPosition[idx - 1]) > 1 {
                                headPosition[idx].y -= 1
                            }
                            if idx == headPosition.count - 1 {
                                tailBook.insert(headPosition[idx])
                            }
                        }
                    }
                }

                if $0[0] == "D", let distance = Int($0[1]) {
                    for _ in 0 ..< distance {
                        headPosition[0].y += 1

                        for idx in headPosition.indices.dropFirst() {
                            if headPosition[idx].distance(from: headPosition[idx - 1]) > 1 {
                                headPosition[idx].y += 1
                            }
                            if idx == headPosition.count - 1 {
                                tailBook.insert(headPosition[idx])
                            }
                        }
                    }
                }
            }

        if tailBook.count == 1, let last = headPosition.last, tailBook.contains(last) {
            tailBook.remove(last)
        }
        return tailBook.count
    }
}
