
func fetchSampleData(filename: String) throws -> String {
    let input = Bundle.module.path(forResource: "\(filename)", ofType: "io")!
    let fileContent = try String(contentsOfFile: input)
    return fileContent
}
