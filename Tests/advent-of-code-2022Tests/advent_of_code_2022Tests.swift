@testable import advent_of_code_2022
import XCTest

final class advent_of_code_2022Tests: XCTestCase {
    func testDay1() throws {
        let sampleInput = try fetchSampleData(day: 1, filename: "sample_input")
        XCTAssertNotEqual(sampleInput, "")
        let realInput = try fetchSampleData(day: 1, filename: "real_input")
        XCTAssertNotEqual(realInput, "")

        let solver = Day1()

        let sampleAnswer1 = try XCTUnwrap(solver.solve1(input: sampleInput))
        XCTAssertEqual(sampleAnswer1, 24_000)

        let sampleAnswer2 = try XCTUnwrap(solver.solve2(input: sampleInput))
        XCTAssertEqual(sampleAnswer2, 45_000)

        let realAnswer1 = try XCTUnwrap(solver.solve1(input: realInput))
        XCTAssertEqual(realAnswer1, 67_633)

        let realAnswer2 = solver.solve2(input: realInput)
        XCTAssertEqual(realAnswer2, 199_628)
    }

    func testDay2() throws {
        let sampleInput = try fetchSampleData(day: 2, filename: "sample_input")
        XCTAssertNotEqual(sampleInput, "")
        let realInput = try fetchSampleData(day: 2, filename: "real_input")
        XCTAssertNotEqual(realInput, "")

        let solver = Day2()

        let sampleAnswer1 = try XCTUnwrap(solver.solve1(input: sampleInput))
        XCTAssertEqual(sampleAnswer1, 15)

        let sampleAnswer2 = try XCTUnwrap(solver.solve2(input: sampleInput))
        XCTAssertEqual(sampleAnswer2, 12)

        let realAnswer1 = try XCTUnwrap(solver.solve1(input: realInput))
        XCTAssertEqual(realAnswer1, 13_268)

        let realAnswer2 = solver.solve2(input: realInput)
        XCTAssertEqual(realAnswer2, 15_508)
    }

}
