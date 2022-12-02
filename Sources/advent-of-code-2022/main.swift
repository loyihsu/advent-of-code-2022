
let sample = try! fetchSampleData(filename: "Inputs/Sample")
let input = try! fetchSampleData(filename: "Inputs/Input")

let solver = Day2()

let result1 = solver.solve1(input: input)
print(result1)

let result2 = solver.solve2(input: input)
print(result2)
