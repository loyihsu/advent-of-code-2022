//
//  Day 14.swift
//
//
//  Created by Yu-Sung Loyi Hsu on 2022/12/4.
//

class Day14 {
    func solve1(input: String) -> Int {
        var map = Map(input: input)
        return dropSands(in: &map)
    }

    func solve2(input: String) -> Int {
        var map = Map(input: input).withFloor()
        return dropSands(in: &map)
    }

    private func dropSands(in map: inout Map) -> Int {
        let abyssThreshold = map.findAbyssThreshold()

        var canDrop: Bool {
            !map.contains(Coordinate(x: 500, y: 0))
        }

        var count = 0

        while canDrop {
            var newSand = Coordinate(x: 500, y: 0)
            var next = newSand.drop(on: map, abyssThreshold: abyssThreshold)

            while newSand != next, !map.contains(next) {
                newSand = next
                next = newSand.drop(on: map, abyssThreshold: abyssThreshold)
            }

            map.insert(newSand)

            if let abyssThreshold = abyssThreshold, newSand.y > abyssThreshold {
                break
            }

            count += 1
        }

        return count
    }
}

private struct Coordinate: Hashable {
    let x: Int
    let y: Int

    func line(to another: Coordinate) -> [Coordinate] {
        if x == another.x {
            return (min(y, another.y) ... max(y, another.y))
                .map { Coordinate(x: x, y: $0) }
        } else if y == another.y {
            return (min(x, another.x) ... max(x, another.x))
                .map { Coordinate(x: $0, y: y) }
        }
        return []
    }

    func drop(on map: Map, abyssThreshold: Int? = nil) -> Coordinate {
        if let abyssThreshold = abyssThreshold {
            guard y <= abyssThreshold else { return self }
        }

        let down = findDown()
        let downLeft = findDownLeft()
        let downRight = findDownRight()

        var canMoveDown: Bool {
            !map.contains(down)
        }
        var canMoveDownLeft: Bool {
            !map.contains(downLeft)
        }
        var canMoveDownRight: Bool {
            !map.contains(downRight)
        }

        if canMoveDown {
            return down
        }
        if canMoveDownLeft {
            return downLeft
        }
        if canMoveDownRight {
            return downRight
        }
        return self
    }

    private func findDown() -> Coordinate {
        Coordinate(x: x, y: y + 1)
    }

    private func findDownLeft() -> Coordinate {
        Coordinate(x: x - 1, y: y + 1)
    }

    private func findDownRight() -> Coordinate {
        Coordinate(x: x + 1, y: y + 1)
    }
}

private struct Map {
    var dots: Set<Coordinate>
    var floor: Int?

    init(input: String) {
        let paths = input
            .splitLines(shouldTrimWhitespacesAndNewlines: true)
            .map {
                $0
                    .splitList(separator: " -> ", shouldTrimWhitespacesAndNewlines: true)
                    .map {
                        let list = $0.splitList(separator: ",", shouldTrimWhitespacesAndNewlines: true)
                        return Coordinate(x: Int(list[0])!, y: Int(list[1])!)
                    }
            }

        var map: Set<Coordinate> = []

        paths.forEach {
            zip($0, $0[1...])
                .forEach { lhs, rhs in
                    lhs.line(to: rhs)
                        .forEach {
                            map.insert($0)
                        }
                }
        }

        dots = map
        floor = nil
    }

    mutating func insert(_ coordinate: Coordinate) {
        dots.insert(coordinate)
    }

    func withFloor() -> Map {
        var copySelf = self
        copySelf.makeFloor()
        return copySelf
    }

    mutating func makeFloor() {
        floor = findMaxY() + 2
    }

    func findAbyssThreshold() -> Int? {
        guard floor == nil else { return nil }
        return findMaxY()
    }

    private func findMaxY() -> Int {
        dots.map(\.y).max()!
    }

    func contains(_ coordinate: Coordinate) -> Bool {
        if let floor = floor {
            guard coordinate.y < floor else { return true }
        }
        return dots.contains(coordinate)
    }
}
