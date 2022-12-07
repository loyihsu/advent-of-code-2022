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
        let fileSystem = Entry.makeDirectory(name: "/", substructure: [])

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
            return Entry.makeDirectory(name: tokens[1], substructure: [])
        } else {
            return Entry.makeFile(name: tokens[1], size: Int(tokens[0])!)
        }
    }
}

enum Command {
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

class Entry {
    enum EntryType: Equatable {
        case directory
        case file(size: Int)
    }

    let name: String
    let type: EntryType
    var substructure: [Entry]?

    private init(name: String, type: EntryType, substructure: [Entry]?) {
        self.name = name
        self.type = type
        self.substructure = substructure
    }

    static func makeDirectory(name: String, substructure: [Entry]) -> Entry {
        Entry(
            name: name,
            type: .directory,
            substructure: substructure
        )
    }

    static func makeFile(
        name: String,
        size: Int
    ) -> Entry {
        Entry(
            name: name,
            type: .file(size: size),
            substructure: nil
        )
    }

    var size: Int {
        switch type {
        case .directory:
            return substructure!
                .map(\.size)
                .reduce(0, +)
        case let .file(size):
            return size
        }
    }

    func insertOrUpdate(_ entry: Entry, structure: [String]) {
        var structure = structure
        var current = self

        while let first = structure.popFirst() {
            switch current.type {
            case .directory:
                if let found = current.substructure?.first(where: { $0.name == first }) {
                    current = found
                }

                if structure.isEmpty {
                    current.substructure?.append(entry)
                }
            case .file:
                fatalError("This is a file")
            }
        }
    }

    func findAllDirectories() -> [(String, Int)] {
        var output = [(String, Int)]()
        if type == .directory {
            output.append((name, size))
        }
        for item in substructure ?? [] {
            output.append(contentsOf: item.findAllDirectories())
        }
        return output
    }
}
