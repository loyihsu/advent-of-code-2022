@testable import advent_of_code_2022
import XCTest

final class advent_of_code_2022Tests: XCTestCase {
    func testDay1() throws {
        let sampleInput1 = try fetchSampleData(day: 1, filename: "sample_input_1")
        XCTAssertNotEqual(sampleInput1, "")

        let day1 = Day1()

        let sampleAnswer1 = try XCTUnwrap(day1.solve1(input: sampleInput1))
        XCTAssertEqual(sampleAnswer1, 24000)

        let realInput1 = try fetchSampleData(day: 1, filename: "real_input_1")
        XCTAssertNotEqual(realInput1, "")

        let realAnswer1 = try XCTUnwrap(day1.solve1(input: realInput1))
        XCTAssertEqual(realAnswer1, 67633)

        let realAnswer2 = day1.solve2(input: realInput1)
        XCTAssertEqual(realAnswer2, 199_628)
    }
}
