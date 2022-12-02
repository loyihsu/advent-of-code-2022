//
//  AOC_Tests_Day1.swift
//
//
//  Created by Loyi Hsu on 2022/12/2.
//

@testable import advent_of_code_2022
import XCTest

final class AOC_Tests_Day1: XCTestCase {
    let day = 1
    let solver = Day1()

    func test_sample_question1() throws {
        let input = try fetchSampleData(day: day, filename: "sample_input")
        XCTAssertNotEqual(input, "")

        let answer = try XCTUnwrap(solver.solve1(input: input))
        XCTAssertEqual(answer, 24000)
    }

    func test_sample_question2() throws {
        let input = try fetchSampleData(day: day, filename: "sample_input")
        XCTAssertNotEqual(input, "")

        let answer = try XCTUnwrap(solver.solve2(input: input))
        XCTAssertEqual(answer, 45000)
    }

    func test_real_question1() throws {
        let input = try fetchSampleData(day: day, filename: "real_input")
        XCTAssertNotEqual(input, "")

        let answer = try XCTUnwrap(solver.solve1(input: input))
        XCTAssertEqual(answer, 67633)
    }

    func test_real_question2() throws {
        let input = try fetchSampleData(day: day, filename: "real_input")
        XCTAssertNotEqual(input, "")

        let answer = solver.solve2(input: input)
        XCTAssertEqual(answer, 199_628)
    }
}
