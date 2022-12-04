//
//  AOC_Tests_Day4.swift
//
//
//  Created by Loyi Hsu on 2022/12/2.
//

@testable import advent_of_code_2022
import XCTest

final class AOC_Tests_Day4: XCTestCase {
    let day = 4
    let solver = Day4()

    func test_sample_question1() throws {
        let input = try XCTUnwrap(try? fetchSampleData(day: day, filename: "sample_input"))
        let answer = try XCTUnwrap(solver.solve1(input: input))
        XCTAssertEqual(answer, 2)
    }

    func test_sample_question2() throws {
        let input = try XCTUnwrap(try? fetchSampleData(day: day, filename: "sample_input"))
        let answer = try XCTUnwrap(solver.solve2(input: input))
        XCTAssertEqual(answer, 4)
    }

    func test_real_question1() throws {
        let input = try XCTUnwrap(try? fetchSampleData(day: day, filename: "real_input"))
        let answer = try XCTUnwrap(solver.solve1(input: input))
        XCTAssertEqual(answer, 431)
    }

    func test_real_question2() throws {
        let input = try XCTUnwrap(try? fetchSampleData(day: day, filename: "real_input"))
        let answer = solver.solve2(input: input)
        XCTAssertEqual(answer, 823)
    }
}
