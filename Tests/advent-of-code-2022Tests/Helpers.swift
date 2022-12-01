import Foundation

func fetchSampleData(day: Int, filename: String) throws -> String {
    let input = Bundle.module.path(
        forResource: "Testcases/Day \(day)/\(filename)",
        ofType: "io"
    )!
    let fileContent = try String(contentsOfFile: input)
    return fileContent
}
