
let sample = try! fetchSampleData(filename: "Inputs/Sample")
let input = try! fetchSampleData(filename: "Inputs/Input")
let result1 = Day1().solve1(input: input)
print(result1 ?? -1)

let result2 = Day1().solve2(input: input)
print(result2)
