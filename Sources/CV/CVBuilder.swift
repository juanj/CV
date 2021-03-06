//
//  CVBuilder.swift
//  CV
//
//  Created by Juan on 25/12/20.
//

import Foundation
import AppKit

class CVBuilder {
    private let metaData = [
        kCGPDFContextAuthor: "Juan José Meneses",
        kCGPDFContextCreator: "https://github.com/juanj/CV"
    ]
    private var a4Size = CGRect(x: 0, y: 0, width: 8.3 * 72, height: 11.7 * 72)

    private var data: Data?
    private let path: String
    private let bundle: Bundle

    init(path: String, bundle: Bundle = .module) {
        self.path = path
        self.bundle = bundle
    }

    func build() throws {
        let context = try setUpContext()
        let page1 = Page1(bundle: bundle)
        let page2 = Page2(bundle: bundle)

        context.beginPage(mediaBox: &a4Size)
        flipCoordinates(context)
        page1.draw(in: context)
        context.endPage()

        context.beginPage(mediaBox: &a4Size)
        flipCoordinates(context)
        page2.draw(in: context)
        context.endPage()
        context.closePDF()
    }

    private func flipCoordinates(_ context: CGContext) {
        // (0, 0) = Top left
        context.translateBy(x: 0, y: a4Size.height)
        context.scaleBy(x: 1, y: -1)
    }

    private func setUpContext() throws -> CGContext {
        guard let url = CFURLCreateWithFileSystemPath(nil, path as CFString, .cfurlposixPathStyle, false) else {
            throw CVBuilderError.contextCreationFail
        }

        guard let context = CGContext(url, mediaBox: &a4Size, metaData as CFDictionary) else {
            throw CVBuilderError.contextCreationFail
        }

        NSGraphicsContext.current = NSGraphicsContext(cgContext: context, flipped: true)

        return context
    }
}
