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

    init(path: String) {
        self.path = path
    }

    func build() throws {
        let context = try setUpContext()
        context.beginPage(mediaBox: &a4Size)

        flipCoordinates(context)
        drawHeader(context)
        drawSidebar(context)

        context.endPage()
        context.closePDF()
    }

    private func flipCoordinates(_ context: CGContext) {
        // (0, 0) = Top left
        context.translateBy(x: 0, y: a4Size.height)
        context.scaleBy(x: 1, y: -1)
    }

    private func drawHeader(_ context: CGContext) {
        context.saveGState()

        context.setFillColor(NSColor.lightPurple.cgColor)
        context.fill(CGRect(origin: .zero, size: CGSize(width: a4Size.width, height: 75)))

        let name = "Juan José Meneses"
        name.draw(at: CGPoint(x: 15, y: 10), withAttributes: TextAttributes.whiteBigTitle)

        let title = "iOS Developer"
        title.draw(at: CGPoint(x: 15, y: 40),
                   withAttributes: TextAttributes.whiteSubTitle)

        context.restoreGState()
    }

    private func drawSidebar(_ context: CGContext) {
        context.saveGState()

        context.setFillColor(NSColor.superLightPurple.cgColor)
        context.fill(CGRect(x: a4Size.width * (2/3), y: 75, width: a4Size.width * (1/3), height: a4Size.height - 75))

        context.restoreGState()
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
