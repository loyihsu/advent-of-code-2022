//
//  Day 15.swift
//
//
//  Created by Yu-Sung Loyi Hsu on 2022/12/4.
//

class Day15 {
    func solve1(input: String, caringRow: Int) -> Int {
        let points = handleInput(input)
            .flatMap { sensor, closest in
                let distance = sensor.distance(closest)
                return sensor.expand(distance, existing: closest, caringYRange: caringRow ... caringRow)
            }

        return Set(points).count
    }

    func solve2(input _: String) {}

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
