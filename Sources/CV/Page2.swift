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
        context.translateBy(x: 0, y: 75)

        _ = drawApp(context, icon: Bundle.module.image(forResource: "kantanmanga"), name: "Kantan Manga", date: "2020", description: NSLocalizedString("KANTANMANGA_DESCRIPTION", bundle: bundle, comment: "Kantan Manga description"), addBorder: true)

        context.restoreGState()
    }

    private func drawApp(_ context: CGContext, icon: NSImage?, name: String, date: String, description: String, addBorder: Bool = false) -> CGFloat {
        context.saveGState()
        var verticalPosition: CGFloat = 0

        let clipPath = NSBezierPath(roundedRect: NSRect(x: 15, y: 15, width: 100, height: 100), xRadius: 10, yRadius: 10)
        clipPath.setClip()
        icon?.draw(in: NSRect(x: 15, y: 15, width: 100, height: 100))
        context.resetClip()

        if addBorder {
            context.setStrokeColor(NSColor.black.cgColor)
            clipPath.stroke()
        }
        context.translateBy(x: 115, y: 0)

        let nameSize = name.size(withAttributes: TextAttributes.educationName)
        name.draw(at: CGPoint(x: 15, y: 15), withAttributes: TextAttributes.educationName)
        date.draw(at: CGPoint(x: 25 + nameSize.width, y: 18), withAttributes: TextAttributes.educationDate)
        context.translateBy(x: 0, y: nameSize.height + 15)
        verticalPosition += nameSize.height + 15

        let descriptionSize = description.boundingRect(with: CGSize(width: a4Size.width - 115, height: .greatestFiniteMagnitude), options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: TextAttributes.content)
        description.draw(in: CGRect(x: 0, y: 5, width: a4Size.width - 115, height: a4Size.height - 90), withAttributes: TextAttributes.content)
        context.translateBy(x: 0, y: descriptionSize.height + 5)
        verticalPosition += descriptionSize.height + 5

        context.restoreGState()
        return verticalPosition
    }
}
