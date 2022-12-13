//
//  AOC_Tests_Day13.swift
//
//
//  Created by Loyi Hsu on 2022/12/2.
//

@testable import advent_of_code_2022
import XCTest

final class AOC_Tests_Day13: XCTestCase {
    let day = 13
    let solver = Day13()

    func test_sample_question1() throws {
        let input = try XCTUnwrap(try? fetchSampleData(day: day, filename: "sample_input"))
        let answer = try XCTUnwrap(solver.solve1(input: input))
        XCTAssertEqual(answer, 13)
    }

    func test_sample_question2() throws {
        let input = try XCTUnwrap(try? fetchSampleData(day: day, filename: "sample_input"))
        let answer = try XCTUnwrap(solver.solve2(input: input))
        XCTAssertEqual(answer, 140)
    }

    func test_real_question1() throws {
        let input = try XCTUnwrap(try? fetchSampleData(day: day, filename: "real_input"))
        let answer = try XCTUnwrap(solver.solve1(input: input))
        XCTAssertEqual(answer, 5659)
    }

    func test_real_question2() throws {
        let input = try XCTUnwrap(try? fetchSampleData(day: day, filename: "real_input"))
        let answer = solver.solve2(input: input)
        XCTAssertEqual(answer, 22110)
    }
}
