//
//  AOC_Tests_Day2.swift
//
//
//  Created by Loyi Hsu on 2022/12/2.
//

@testable import advent_of_code_2022
import XCTest

final class AOC_Tests_Day2: XCTestCase {
    let day = 2
    let solver = Day2()

    func test_sample_question1() throws {
        let input = try fetchSampleData(day: day, filename: "sample_input")
        XCTAssertNotEqual(input, "")

        let answer = try XCTUnwrap(solver.solve1(input: input))
        XCTAssertEqual(answer, 15)
    }

    func test_sample_question2() throws {
        let input = try fetchSampleData(day: day, filename: "sample_input")
        XCTAssertNotEqual(input, "")

        let answer = try XCTUnwrap(solver.solve2(input: input))
        XCTAssertEqual(answer, 12)
    }

    func test_real_question1() throws {
        let input = try fetchSampleData(day: day, filename: "real_input")
        XCTAssertNotEqual(input, "")

        let answer = try XCTUnwrap(solver.solve1(input: input))
        XCTAssertEqual(answer, 13268)
    }

    func test_real_question2() throws {
        let input = try fetchSampleData(day: day, filename: "real_input")
        XCTAssertNotEqual(input, "")

        let answer = solver.solve2(input: input)
        XCTAssertEqual(answer, 15508)
    }
}
