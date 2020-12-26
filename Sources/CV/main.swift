//
//  main.swift
//  CV
//
//  Created by Juan on 25/12/20.
//

import Foundation
import ArgumentParser

enum Language: String, ExpressibleByArgument {
    case en, es
}

struct CV: ParsableCommand {
    @Option
    var lang: Language = .en

    @Option
    var out: String = "./cv.pdf"

    func run() {
        var bundle = Bundle.module
        if let bundlePath = Bundle.module.path(forResource: lang.rawValue, ofType: "lproj"), let langBundle = Bundle(path: bundlePath) {
            bundle = langBundle
        }

        let builder = CVBuilder(path: "./cv.pdf", bundle: bundle)
        do {
            try builder.build()
            print("Build")
            print(FileManager.default.currentDirectoryPath)
        } catch {
            print("Error creating pdf")
        }
    }
}

CV.main()
