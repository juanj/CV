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
    private let appSpacing: CGFloat = 20

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

        var offset = drawApp(context, icon: Bundle.module.image(forResource: "app1"), name: "App1", date: "~2015-2016", description: NSLocalizedString("APP1_DESCRIPTION", bundle: bundle, comment: "App 1 description"))
        context.translateBy(x: 0, y: offset + appSpacing)

        offset = drawApp(context, icon: Bundle.module.image(forResource: "app2"), name: "App2", date: "~2016-2017", description: NSLocalizedString("APP2_DESCRIPTION", bundle: bundle, comment: "App 2 description"))
        context.translateBy(x: 0, y: offset + appSpacing)

        offset = drawApp(context, icon: Bundle.module.image(forResource: "app3"), name: "App3", date: "~2018", description: NSLocalizedString("APP3_DESCRIPTION", bundle: bundle, comment: "App 3 description"), addBorder: true)
        context.translateBy(x: 0, y: offset + appSpacing)

        offset = drawApp(context, icon: Bundle.module.image(forResource: "app4"), name: "App4", date: "2020", description: NSLocalizedString("APP4_DESCRIPTION", bundle: bundle, comment: "App 4 description"))
        context.translateBy(x: 0, y: offset + appSpacing)

        offset = drawApp(context, icon: Bundle.module.image(forResource: "kantanmanga"), name: "Kantan Manga", link: "https://github.com/juanj/KantanManga", date: "2020", description: NSLocalizedString("KANTANMANGA_DESCRIPTION", bundle: bundle, comment: "Kantan Manga description"), addBorder: true)
        context.translateBy(x: 0, y: offset + appSpacing)

        context.restoreGState()
    }

    private func drawApp(_ context: CGContext, icon: NSImage?, name: String, link: String? = nil, date: String, description: String, addBorder: Bool = false) -> CGFloat {
        context.saveGState()
        let icon = icon ?? Bundle.module.image(forResource: "placeholder")
        var verticalPosition: CGFloat = 0

        let clipPath = NSBezierPath(roundedRect: NSRect(x: 15, y: 15, width: 100, height: 100), xRadius: 15, yRadius: 15)
        clipPath.setClip()
        icon?.draw(in: NSRect(x: 15, y: 15, width: 100, height: 100))
        context.resetClip()

        if addBorder {
            context.setStrokeColor(NSColor.black.cgColor)
            clipPath.stroke()
        }
        context.translateBy(x: 115, y: 0)

        let nameAttributes: [NSAttributedString.Key: Any]
        if let link = link {
            nameAttributes = TextAttributes.attributes(TextAttributes.educationName, with: link)
        } else {
            nameAttributes = TextAttributes.educationName
        }
        let nameSize = name.size(withAttributes: nameAttributes)
        name.draw(at: CGPoint(x: 15, y: 15), withAttributes: nameAttributes)
        date.draw(at: CGPoint(x: 25 + nameSize.width, y: 18), withAttributes: TextAttributes.educationDate)
        context.translateBy(x: 0, y: nameSize.height + 15)
        verticalPosition += nameSize.height + 15

        let attributedDescription = TextAttributes.parseLinksIn(description, withAttributes: TextAttributes.content)
        let descriptionSize = attributedDescription.boundingRect(with: CGSize(width: a4Size.width - 115, height: .greatestFiniteMagnitude), options: [.usesLineFragmentOrigin, .usesFontLeading])
        attributedDescription.draw(in: CGRect(x: 0, y: 5, width: a4Size.width - 115, height: a4Size.height - 90))
        context.translateBy(x: 0, y: descriptionSize.height + 5)
        verticalPosition += descriptionSize.height + 5

        context.restoreGState()
        return max(verticalPosition, 115)
    }
}
