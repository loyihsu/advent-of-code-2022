//
//  SourceHelperTests.swift
//
//
//  Created by Loyi Hsu on 2022/12/2.
//

@testable import advent_of_code_2022
import XCTest

final class SourceHelperTests: XCTestCase {
    func test_sum() {
        let array = [1, 2, 3, 4, 5]
        XCTAssertEqual(array.sum(), 15)
    }

    func test_top() {
        let array = [1, 2, 3, 4, 5]
        let top3 = array.top(3)
        XCTAssertTrue(top3.contains(3))
        XCTAssertTrue(top3.contains(4))
        XCTAssertTrue(top3.contains(5))
    }

    func test_top_over() {
        let array = [1, 2, 3]
        let top5 = array.top(5)
        XCTAssertEqual(top5.count, 3)
    }

    func test_top_dupes() {
        let array = [1, 2, 3, 4, 4, 4]
        let top4 = array.top(4)
        XCTAssertEqual(top4.filter { $0 == 3 }.count, 1)
        XCTAssertEqual(top4.filter { $0 == 4 }.count, 3)
    }

    func test_splitParagraphs() {
        let text = """
        A

        B

        C

        """
        let items = text.splitParagraphs()
        XCTAssertTrue(items.contains("A"))
        XCTAssertTrue(items.contains("B"))
        XCTAssertTrue(items.contains("C"))
    }

    func test_splitLine() {
        let text = """
        A
        B
        C
        D
        E

        """

        let items = text.splitLines()
        XCTAssertTrue(items.contains("A"))
        XCTAssertTrue(items.contains("B"))
        XCTAssertTrue(items.contains("C"))
        XCTAssertTrue(items.contains("D"))
        XCTAssertTrue(items.contains("E"))
    }

    func test_splitList() {
        let text = """
        A B C D E F

        """

        let items = text.splitList()
        XCTAssertTrue(items.contains("A"))
        XCTAssertTrue(items.contains("B"))
        XCTAssertTrue(items.contains("C"))
        XCTAssertTrue(items.contains("D"))
        XCTAssertTrue(items.contains("E"))
        XCTAssertTrue(items.contains("F"))
    }

    func test_splitList_csv() {
        let text = """
        A,B,C,D,E,F

        """

        let items = text.splitList(separator: ",")
        XCTAssertTrue(items.contains("A"))
        XCTAssertTrue(items.contains("B"))
        XCTAssertTrue(items.contains("C"))
        XCTAssertTrue(items.contains("D"))
        XCTAssertTrue(items.contains("E"))
        XCTAssertTrue(items.contains("F"))
    }

    func test_splitList_commaHumanReadableList() {
        let text = """
        A, B, C, D, E, F

        """

        let items = text.splitList(separator: ",")
        XCTAssertTrue(items.contains("A"))
        XCTAssertTrue(items.contains("B"))
        XCTAssertTrue(items.contains("C"))
        XCTAssertTrue(items.contains("D"))
        XCTAssertTrue(items.contains("E"))
        XCTAssertTrue(items.contains("F"))
    }
}
