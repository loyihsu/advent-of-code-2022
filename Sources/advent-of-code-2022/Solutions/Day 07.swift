//
//  Day 07.swift
//
//
//  Created by Yu-Sung Loyi Hsu on 2022/12/4.
//

class Day7 {
    func solve1(input: String) -> Int {
        parseFileSystem(input: input)
            .findAllDirectories()
            .map(\.1)
            .filter {
                $0 < 100_000
            }
            .sum()
    }

    func solve2(input: String) -> Int {
        let fileSystem = parseFileSystem(input: input)
        let totalSize = 70_000_000, requiredSpace = 30_000_000
        let remainSpace = totalSize - fileSystem.size
        let threshold = requiredSpace - remainSpace

        let smallestBigger = fileSystem
            .findAllDirectories()
            .filter {
                $0.1 > threshold
            }
            .min(by: {
                $0.1 < $1.1
            })?
            .1

        return smallestBigger ?? 0
    }

    private func parseFileSystem(input: String) -> Entry {
        let lines = input.splitLines(shouldTrimWhitespacesAndNewlines: true)
        var structure: [String] = []
        let fileSystem = Directory(name: "/", sub: [])

        lines
            .forEach { line in
                if let command = makeCommand(string: line) {
                    command.handle(with: &structure)
                } else {
                    fileSystem
                        .insertOrUpdate(
                            makeEntry(string: line),
                            structure: structure
                        )
                }
            }

        return fileSystem
    }

    private func makeCommand(string: String) -> Command? {
        guard string.hasPrefix("$") else { return nil }
        let tokens = string.components(separatedBy: .whitespaces)
        if tokens[1] == "cd" {
            return .changeDirectory(nextPosition: tokens[2])
        }
        if tokens[1] == "ls" {
            return .list
        }
        fatalError("Undefined command!")
    }

    private func makeEntry(string: String) -> Entry {
        let tokens = string.components(separatedBy: .whitespaces)
        if tokens[0] == "dir" {
            return Directory(name: tokens[1], sub: [])
        } else {
            return File(name: tokens[1], size: Int(tokens[0])!)
        }
    }
}

// MARK: - Command

private enum Command {
    case changeDirectory(nextPosition: String)
    case list

    func handle(with currentPosition: inout [String]) {
        switch self {
        case let .changeDirectory(nextPosition):
            if nextPosition == ".." {
                currentPosition.removeLast()
            } else if nextPosition == "/" {
                currentPosition = ["/"]
            } else {
                currentPosition.append(nextPosition)
            }
        case .list:
            return
        }
    }
}

// MARK: - Entry

private protocol Entry: AnyObject {
    var name: String { get }
    var size: Int { get }
    func insertOrUpdate(_ entry: Entry, structure: [String])
}

private extension Entry {
    func insertOrUpdate(_: Entry, structure _: [String]) {}

    func findAllDirectories() -> [(String, Int)] {
        var output = [(String, Int)]()
        guard let entry = self as? Directory else { return output }
        output.append((entry.name, entry.size))
        for item in entry.sub {
            output.append(contentsOf: item.findAllDirectories())
        }
        return output
    }
}

private class Directory: Entry {
    let name: String
    var sub: [Entry]

    var size: Int {
        sub
            .map(\.size)
            .sum()
    }

    init(name: String, sub: [Entry]) {
        self.name = name
        self.sub = sub
    }

    func insertOrUpdate(_ entry: Entry, structure: [String]) {
        var structure = structure
        var current = self

        while let first = structure.popFirst() {
            if let found = current.sub.first(where: { $0.name == first }) as? Directory {
                current = found
            }

            if structure.isEmpty {
                current.sub.append(entry)
            }
        }
    }
}

class File: Entry {
    let name: String
    let size: Int

    init(name: String, size: Int) {
        self.name = name
        self.size = size
    }
}
