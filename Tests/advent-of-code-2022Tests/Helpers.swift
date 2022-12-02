//
//  Helpers.swift
//
//
//  Created by Loyi Hsu on 2022/12/1.
//

import Foundation

func fetchSampleData(day: Int, filename: String) throws -> String {
    let input = Bundle.module.path(
        forResource: "Daily Tests/Day \(day)/\(filename)",
        ofType: "txt"
    )!
    let fileContent = try String(contentsOfFile: input)
    return fileContent
}
