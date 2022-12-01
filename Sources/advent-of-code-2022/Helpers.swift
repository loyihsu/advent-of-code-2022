import Foundation

extension Array where Element == Int {
    func sum() -> Int {
        reduce(0, +)
    }

    func top(_ count: Int) -> [Int] {
        var copySelf = self

        guard count > 0 else { return [] }

        return (0 ..< count)
            .compactMap { _ in
                copySelf.maxAndPop()
            }
    }

    private mutating func maxAndPop() -> Int? {
        guard let max = enumerated()
            .max(by: { $0.element < $1.element })
        else {
            return nil
        }
        remove(at: max.offset)
        return max.element
    }
}

func fetchSampleData(filename: String) throws -> String {
    let input = Bundle.module.path(forResource: "\(filename)", ofType: "io")!
    let fileContent = try String(contentsOfFile: input)
    return fileContent
}
