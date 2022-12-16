//
//  Day 15.swift
//
//
//  Created by Yu-Sung Loyi Hsu on 2022/12/4.
//

import Foundation

class Day15 {
    func solve1(input: String, caringRow: Int) -> Int {
        let points = handleInput(input)
            .flatMap { sensor, closest in
                let distance = sensor.distance(closest)
                return sensor.expand(distance, existing: closest, caringYRange: caringRow ... caringRow)
            }

        return Set(points).count
    }

    func solve2(input: String, range: ClosedRange<Int>) -> Int {
        var casting = [[ClosedRange<Int>]](repeating: [], count: range.count)
        let rules = handleInput(input)

        for rule in rules {
            for idx in casting.indices {
                let distance = rule.sensor.distance(rule.closest)
                if let cast = rule.sensor.cast(on: idx, with: distance, limitingRange: range) {
                    casting[idx].append(cast)
                }
            }
        }

        casting = casting.map { line in
            var sorted = line.sorted {
                $0.lowerBound < $1.lowerBound
            }

            var buffer: [ClosedRange<Int>] = []
            var output = [ClosedRange<Int>]()

            while let first = sorted.popFirst() {
                if buffer.count < 2 {
                    buffer.append(first)
                } else if buffer.count == 2 {
                    if let merged = buffer[0].merging(with: buffer[1]) {
                        buffer = [merged, first]
                    } else {
                        output.append(buffer.popFirst()!)
                    }
                }
            }

            if buffer.count == 2, let merged = buffer[0].merging(with: buffer[1]) {
                buffer = [merged]
            }

            output.append(contentsOf: buffer)
            return output
        }

        let found = casting.enumerated()
            .filter { $1.count > 1 }

        return (found[0].element[0].upperBound + 1) * 4_000_000 + found[0].offset
    }

    private func handleInput(_ input: String) -> [(sensor: Coordinate, closest: Coordinate)] {
        input
            .splitLines(shouldTrimWhitespacesAndNewlines: true)
            .map {
                let parts = $0.components(separatedBy: ": ")
                var sensorRaw = parts[0]
                sensorRaw.consumeFirst("Sensor at ".count)

                let sensorInts = sensorRaw.components(separatedBy: ", ")
                    .compactMap { string in
                        var string = string
                        string.consumeFirst(2)
                        return Int(string)
                    }

                let sensorCoordinate = Coordinate(x: sensorInts[0], y: sensorInts[1])

                var closestRaw = parts[1]
                closestRaw.consumeFirst("closest beacon is at ".count)

                let closestInts = closestRaw.components(separatedBy: ", ")
                    .compactMap { string in
                        var string = string
                        string.consumeFirst(2)
                        return Int(string)
                    }

                let closestCoordinate = Coordinate(x: closestInts[0], y: closestInts[1])

                return (sensorCoordinate, closestCoordinate)
            }
    }
}

private struct Coordinate: Hashable {
    let x: Int
    let y: Int

    func distance(_ another: Coordinate) -> Int {
        let xDistance = abs(x - another.x)
        let yDistance = abs(y - another.y)
        return xDistance + yDistance
    }

    func cast(on row: Int, with distance: Int, limitingRange: ClosedRange<Int>) -> ClosedRange<Int>? {
        guard row >= y - distance else { return nil }
        guard row <= y + distance else { return nil }
        let first = x + (distance - abs(y - row))
        let second = x - (distance - abs(y - row))
        return (min(first, second) ... max(first, second)).clamped(to: limitingRange)
    }

    func expand(_ maxDistance: Int, existing: Coordinate, caringXRange: ClosedRange<Int>? = nil, caringYRange: ClosedRange<Int>? = nil) -> [Coordinate] {
        var xRange = (x - maxDistance) ... (x + maxDistance)
        var yRange = (y - maxDistance) ... (y + maxDistance)

        if let caringXRange = caringXRange {
            xRange = xRange.clamped(to: caringXRange)
        }

        if let caringYRange = caringYRange {
            yRange = yRange.clamped(to: caringYRange)
        }

        return xRange.flatMap { x in
            yRange.map { y in
                Coordinate(x: x, y: y)
            }
        }
        .filter {
            distance($0) <= maxDistance
        }
        .filter {
            $0 != existing
        }
    }
}

private extension ClosedRange where Bound == Int {
    func merging(with second: ClosedRange<Int>) -> ClosedRange<Int>? {
        let newLowerBound = Swift.min(lowerBound, second.lowerBound)
        let newUpperBound = Swift.max(upperBound, second.upperBound)
        return overlaps(second) || abs(upperBound - second.lowerBound) == 1 ? newLowerBound ... newUpperBound : nil
    }
}
