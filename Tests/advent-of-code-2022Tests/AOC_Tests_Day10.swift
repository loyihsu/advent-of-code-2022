//
//  AOC_Tests_Day10.swift
//
//
//  Created by Loyi Hsu on 2022/12/2.
//

@testable import advent_of_code_2022
import XCTest

final class AOC_Tests_Day10: XCTestCase {
    let day = 10
    let solver = Day10()

    func test_sample_question1() throws {
        let input = try XCTUnwrap(try? fetchSampleData(day: day, filename: "sample_input"))
        let answer = try XCTUnwrap(solver.solve1(input: input))
        XCTAssertEqual(answer, 13140)
    }

    func test_sample_question2() throws {
        let input = try XCTUnwrap(try? fetchSampleData(day: day, filename: "sample_input"))
        let answer = try XCTUnwrap(solver.solve2(input: input))

        let sampleAnswer = """
        ##..##..##..##..##..##..##..##..##..##..
        ###...###...###...###...###...###...###.
        ####....####....####....####....####....
        #####.....#####.....#####.....#####.....
        ######......######......######......####
        #######.......#######.......#######.....
        """

        XCTAssertEqual(answer, sampleAnswer)
    }

    func test_real_question1() throws {
        let input = try XCTUnwrap(try? fetchSampleData(day: day, filename: "real_input"))
        let answer = try XCTUnwrap(solver.solve1(input: input))
        XCTAssertEqual(answer, 14820)
    }

    func test_real_question2() throws {
        let input = try XCTUnwrap(try? fetchSampleData(day: day, filename: "real_input"))
        let answer = solver.solve2(input: input)

        let realAnswer = """
        ###..####.####.#..#.####.####.#..#..##..
        #..#....#.#....#.#..#....#....#..#.#..#.
        #..#...#..###..##...###..###..####.#..#.
        ###...#...#....#.#..#....#....#..#.####.
        #.#..#....#....#.#..#....#....#..#.#..#.
        #..#.####.####.#..#.####.#....#..#.#..#.
        """

        XCTAssertEqual(answer, realAnswer)
    }
}
