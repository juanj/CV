//
//  Page2.swift
//  CV
//
//  Created by Juan on 28/12/20.
//

import AppKit

struct Page2 {
    private var a4Size = CGRect(x: 0, y: 0, width: 8.3 * 72, height: 11.7 * 72)
    private let bundle: Bundle

    init(bundle: Bundle) {
        self.bundle = bundle
    }

    func draw(in context: CGContext) {
        drawHeader(context)
    }

    private func drawHeader(_ context: CGContext) {
        context.saveGState()

        context.setFillColor(NSColor.lightPurple.cgColor)
        context.fill(CGRect(origin: .zero, size: CGSize(width: a4Size.width, height: 75)))

        let name = NSLocalizedString("EXPERIENCE", bundle: bundle, comment: "Experience")
        name.draw(at: CGPoint(x: 15, y: 10), withAttributes: TextAttributes.whiteBigTitle)

        let title = NSLocalizedString("JOB_TITLE", bundle: bundle, comment: "Job title")
        title.draw(at: CGPoint(x: 15, y: 40),
                   withAttributes: TextAttributes.whiteSubTitle)

        context.restoreGState()
    }
}
