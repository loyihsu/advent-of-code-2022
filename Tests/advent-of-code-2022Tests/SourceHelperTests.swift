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

    func test_top_negative() {
        let array = [1, 2, 3, 4, 5]
        let top = array.top(-1)
        XCTAssertTrue(top.isEmpty)
    }

    func test_top_emptyArray() {
        let array = [Int]()
        let top = array.top(3)
        XCTAssertTrue(top.isEmpty)
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
        let items = text.splitParagraphs(shouldTrimWhitespacesAndNewlines: true)
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

        let items = text.splitLines(shouldTrimWhitespacesAndNewlines: true)
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

        let items = text.splitList(shouldTrimWhitespacesAndNewlines: true)
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

        let items = text.splitList(separator: ",", shouldTrimWhitespacesAndNewlines: true)
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

        let items = text.splitList(separator: ",", shouldTrimWhitespacesAndNewlines: true)
        XCTAssertTrue(items.contains("A"))
        XCTAssertTrue(items.contains("B"))
        XCTAssertTrue(items.contains("C"))
        XCTAssertTrue(items.contains("D"))
        XCTAssertTrue(items.contains("E"))
        XCTAssertTrue(items.contains("F"))
    }

    func test_integerList() {
        let text = "1 2 3 4 5"
        let list = text.integerList()
        XCTAssertEqual(list, Array(1 ... 5))
    }

    func test_integerList_byNewline() {
        let text = """
        1
        2
        3
        4
        5
        6
        7
        8
        9
        10

        """
        let list = text.integerList(separator: "\n")
        XCTAssertEqual(list, Array(1 ... 10))
    }

    func test_chunked_withoutRemainder() {
        let array = Array(1 ... 8).chunked(4)
        XCTAssertEqual(array, [[1, 2, 3, 4], [5, 6, 7, 8]])
    }

    func test_chunked_withRemainder() {
        let array = Array(1 ... 10).chunked(3)
        XCTAssertEqual(array, [[1, 2, 3], [4, 5, 6], [7, 8, 9], [10]])
    }

    func test_oneAndOnlyCommonCharacters() {
        let first = Array("abcde")
        let second = Array("efghijk")
        let firstCommonCharacter = first.findOneAndOnlyCommonCharacter(in: second, duplicationHandlingStrategy: .duplicatesConsideredDifferent)
        XCTAssertEqual(firstCommonCharacter, "e")
    }

    func test_oneAndOnlyCommonCharacters_notOneAndOnly() {
        let first = Array("abcdef")
        let second = Array("efghijk")
        let firstCommonCharacter = first.findOneAndOnlyCommonCharacter(in: second, duplicationHandlingStrategy: .duplicatesConsideredDifferent)
        XCTAssertNil(firstCommonCharacter)
    }

    func test_firstCommonCharacters_withDupes() {
        let first = Array("abcdeeeeee")
        let second = Array("feghijk")
        let firstCommonCharacterCanDupe = first.findOneAndOnlyCommonCharacter(in: second, duplicationHandlingStrategy: .duplicatesConsideredSame)
        XCTAssertEqual(firstCommonCharacterCanDupe, "e")
        let firstCommonCharacterCannotDupe = first.findOneAndOnlyCommonCharacter(in: second, duplicationHandlingStrategy: .duplicatesConsideredDifferent)
        XCTAssertEqual(firstCommonCharacterCannotDupe, nil)
    }

    func test_findAllCommonCharacters() {
        let first = Array("abcdeefghi")
        let second = Array("bcdefgk")
        let filtered = first.findCommonCharacters(in: second, duplicationHandlingStrategy: .duplicatesConsideredDifferent)
        XCTAssertFalse(filtered.contains("a"))
        XCTAssertTrue(filtered.contains("b"))
        XCTAssertTrue(filtered.contains("c"))
        XCTAssertTrue(filtered.contains("d"))
        XCTAssertTrue(filtered.contains("e"))
        XCTAssertTrue(filtered.contains("f"))
        XCTAssertTrue(filtered.contains("g"))
        XCTAssertFalse(filtered.contains("k"))
    }

    func test_contains_closedRangeCorrect() {
        let first = 1 ... 10
        let second = 1 ... 5
        XCTAssertTrue(first.contains(second))
        XCTAssertFalse(second.contains(first))
    }

    func test_contains_closedRangeIncorrect() {
        let first = 1 ... 10
        let second = 0 ... 5
        XCTAssertFalse(first.contains(second))
        XCTAssertFalse(second.contains(first))
    }

    func test_contains_arrayCorrect() {
        let first = [1, 2, 3, 4, 5]
        let second = [2, 4, 5]
        XCTAssertTrue(first.contains(second))
        XCTAssertFalse(second.contains(first))
    }

    func test_contains_arrayIncorrect() {
        let first = [1, 2, 3, 5]
        let second = [2, 4, 5]
        XCTAssertFalse(first.contains(second))
        XCTAssertFalse(second.contains(first))
    }

    func test_consume() {
        var string = "123 456 789"
        XCTAssertEqual(string.consumeFirst(3), "123")
        XCTAssertEqual(string.consumeFirst(1), " ")
        XCTAssertEqual(string.consumeFirst(3), "456")
        XCTAssertEqual(string.consumeFirst(1), " ")
        XCTAssertEqual(string.consumeFirst(3), "789")
        XCTAssertNil(string.consumeFirst(1))
    }
}
