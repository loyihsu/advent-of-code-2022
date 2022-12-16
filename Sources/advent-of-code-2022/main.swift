//
//  main.swift
//
//
//  Created by Loyi Hsu on 2022/12/1.
//

let sample = try! fetchSampleData(filename: "Inputs/Sample")
let input = try! fetchSampleData(filename: "Inputs/Input")

let solver = Day15()

let sample1 = solver.solve1(input: sample, caringRow: 10)
print("SAMPLE 1 -->")
print(sample1)

let result1 = solver.solve1(input: input, caringRow: 2_000_000)
print("RESULT 1 -->")
print(result1)

let sample2 = solver.solve2(input: sample, range: 0 ... 20)
print("SAMPLE 2 -->")
print(sample2)

let result2 = solver.solve2(input: input, range: 0 ... 4_000_000)
print("RESULT 2 -->")
print(result2)
