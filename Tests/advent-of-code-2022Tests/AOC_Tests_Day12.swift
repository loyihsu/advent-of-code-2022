//
//  AOC_Tests_Day12.swift
//
//
//  Created by Loyi Hsu on 2022/12/2.
//

@testable import advent_of_code_2022
import XCTest

final class AOC_Tests_Day12: XCTestCase {
    let day = 12
    let solver = Day12()

    func test_sample_question1() throws {
        let input = try XCTUnwrap(try? fetchSampleData(day: day, filename: "sample_input"))
        let answer = try XCTUnwrap(solver.solve1(input: input))
        XCTAssertEqual(answer, 31)
    }

    func test_sample_question2() throws {
        let input = try XCTUnwrap(try? fetchSampleData(day: day, filename: "sample_input"))
        let answer = try XCTUnwrap(solver.solve2(input: input))
        XCTAssertEqual(answer, 29)
    }

    func test_real_question1() throws {
        let input = try XCTUnwrap(try? fetchSampleData(day: day, filename: "real_input"))
        let answer = try XCTUnwrap(solver.solve1(input: input))
        XCTAssertEqual(answer, 449)
    }

    func test_real_question2() throws {
        let input = try XCTUnwrap(try? fetchSampleData(day: day, filename: "real_input"))
        let answer = solver.solve2(input: input)
        XCTAssertEqual(answer, 443)
    }
}
