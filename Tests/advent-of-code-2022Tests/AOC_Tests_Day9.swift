//
//  AOC_Tests_Day9.swift
//
//
//  Created by Loyi Hsu on 2022/12/2.
//

@testable import advent_of_code_2022
import XCTest

final class AOC_Tests_Day9: XCTestCase {
    let day = 9
    let solver = Day9()

    func test_sample_question1() throws {
        let input = try XCTUnwrap(try? fetchSampleData(day: day, filename: "sample_input_1"))
        let answer = try XCTUnwrap(solver.solve1(input: input))
        XCTAssertEqual(answer, 13)
    }

    func test_sample_question2() throws {
        let input = try XCTUnwrap(try? fetchSampleData(day: day, filename: "sample_input_1"))
        let answer = try XCTUnwrap(solver.solve2(input: input))
        XCTAssertEqual(answer, 0)
    }

    func test_another_sample_question2() throws {
        let input = try XCTUnwrap(try? fetchSampleData(day: day, filename: "sample_input_2"))
        let answer = try XCTUnwrap(solver.solve2(input: input))
        XCTAssertEqual(answer, 36)
    }

    func test_real_question1() throws {
        let input = try XCTUnwrap(try? fetchSampleData(day: day, filename: "real_input"))
        let answer = try XCTUnwrap(solver.solve1(input: input))
        XCTAssertEqual(answer, 5779)
    }

    func test_real_question2() throws {
        let input = try XCTUnwrap(try? fetchSampleData(day: day, filename: "real_input"))
        let answer = solver.solve2(input: input)
        XCTAssertEqual(answer, 2331)
    }
}
