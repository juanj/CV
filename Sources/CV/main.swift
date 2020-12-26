//
//  main.swift
//  CV
//
//  Created by Juan on 25/12/20.
//

import Foundation

let builder = CVBuilder(path: "./cv.pdf")
do {
    try builder.build()
    print("Build")
    print(FileManager.default.currentDirectoryPath)
} catch {
    print("Error creating pdf")
}
