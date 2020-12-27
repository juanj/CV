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
    private let subSectionsSpacing: CGFloat = 10
    private let valueSpacing: CGFloat = 5

    private var data: Data?
    private let path: String
    private let bundle: Bundle

    init(path: String, bundle: Bundle = .module) {
        self.path = path
        self.bundle = bundle
    }

    func build() throws {
        let context = try setUpContext()
        context.beginPage(mediaBox: &a4Size)

        flipCoordinates(context)
        drawHeader(context)
        drawSidebar(context)
        drawContent(context)

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

        let title = NSLocalizedString("JOB_TITLE", bundle: bundle, comment: "Job title")
        title.draw(at: CGPoint(x: 15, y: 40),
                   withAttributes: TextAttributes.whiteSubTitle)

        context.restoreGState()
    }

    private func drawSidebar(_ context: CGContext) {
        context.saveGState()

        context.setFillColor(NSColor.superLightPurple.cgColor)
        context.fill(CGRect(x: a4Size.width * (2/3), y: 75, width: a4Size.width * (1/3), height: a4Size.height - 75))

        // Set origin to top left corner of side bar
        context.translateBy(x: a4Size.width * (2/3), y: 75)

        var verticalPosition = drawPersonalInfoSubSection(context)
        context.translateBy(x: 0, y: verticalPosition)

        verticalPosition = drawSkillsSubSection(context)
        context.translateBy(x: 0, y: verticalPosition)

        verticalPosition = drawLanguagesSubSection(context)
        context.translateBy(x: 0, y: verticalPosition)

        context.restoreGState()
    }

    private func drawContent(_ context: CGContext) {
        context.saveGState()

        let title = NSLocalizedString("ABOUT_ME", bundle: bundle, comment: "About me")
        let content = NSLocalizedString("ABOUT", bundle: bundle, comment: "About content")

        // Set origin to top left corner of content section
        context.translateBy(x: 0, y: 75)
        title.draw(at: CGPoint(x: 15, y: 15), withAttributes: TextAttributes.sectionTitle)
        content.draw(in: CGRect(x: 0, y: 40, width: a4Size.width * (2/3), height: a4Size.height - 75), withAttributes: TextAttributes.content)

        context.restoreGState()
    }

    private func drawPersonalInfoSubSection(_ context: CGContext) -> CGFloat {
        context.saveGState()
        var verticalPosition: CGFloat = 0

        let contactTitle = NSLocalizedString("CONTACT", bundle: bundle, comment: "Contact")
        let contactTitleSize = contactTitle.size(withAttributes: TextAttributes.sidebarTitle)
        contactTitle.draw(at: CGPoint(x: 15, y: 15), withAttributes: TextAttributes.sidebarTitle)
        verticalPosition += 15 + contactTitleSize.height

        context.setFillColor(NSColor.white.cgColor)
        context.fill(CGRect(x: 7, y: verticalPosition + 5, width: a4Size.width * (1/3) - 14, height: 1))
        verticalPosition += 6

        let phoneTitle = NSLocalizedString("PHONE", bundle: bundle, comment: "Phone")
        let phoneTitleSize = phoneTitle.size(withAttributes: TextAttributes.sidebarSubTitle)
        phoneTitle.draw(at: CGPoint(x: 15, y: verticalPosition + 4), withAttributes: TextAttributes.sidebarSubTitle)
        verticalPosition += phoneTitleSize.height + 4

        let phoneNumber = "+57 000 000 0000"
        let phoneNumberSize = phoneNumber.size()
        phoneNumber.draw(at: CGPoint(x: 15, y: verticalPosition + valueSpacing))
        verticalPosition += phoneNumberSize.height + valueSpacing

        let emailTitle = NSLocalizedString("EMAIL", bundle: bundle, comment: "Email")
        let emailTitleSize = emailTitle.size(withAttributes: TextAttributes.sidebarSubTitle)
        emailTitle.draw(at: CGPoint(x: 15, y: verticalPosition + subSectionsSpacing), withAttributes: TextAttributes.sidebarSubTitle)
        verticalPosition += emailTitleSize.height + subSectionsSpacing

        let email = "myemailaddress@mail.com"
        let emailSize = email.size()
        email.draw(at: CGPoint(x: 15, y: verticalPosition + valueSpacing))
        verticalPosition += emailSize.height + valueSpacing

        let cityTitle = NSLocalizedString("CITY", bundle: bundle, comment: "City")
        let cityTileSize = cityTitle.size(withAttributes: TextAttributes.sidebarSubTitle)
        cityTitle.draw(at: CGPoint(x: 15, y: verticalPosition + subSectionsSpacing), withAttributes: TextAttributes.sidebarSubTitle)
        verticalPosition += cityTileSize.height + subSectionsSpacing

        let city = "Bogotá, Colombia"
        let citySize = city.size()
        city.draw(at: CGPoint(x: 15, y: verticalPosition + valueSpacing))
        verticalPosition += citySize.height + valueSpacing

        let githubTitle = "GitHub"
        let githubTitleSize = githubTitle.size(withAttributes: TextAttributes.sidebarSubTitle)
        githubTitle.draw(at: CGPoint(x: 15, y: verticalPosition + subSectionsSpacing), withAttributes: TextAttributes.sidebarSubTitle)
        verticalPosition += githubTitleSize.height + subSectionsSpacing

        let github = "https://github.com/juanj"
        let githubSize = city.size()
        github.draw(at: CGPoint(x: 15, y: verticalPosition + valueSpacing))
        verticalPosition += githubSize.height + valueSpacing

        context.restoreGState()
        return verticalPosition
    }

    private func drawSkillsSubSection(_ context: CGContext) -> CGFloat {
        context.saveGState()
        var verticalPosition: CGFloat = 0

        let skillsTitle = NSLocalizedString("SKILLS", bundle: bundle, comment: "Contact")
        let skillsTitleSize = skillsTitle.size(withAttributes: TextAttributes.sidebarTitle)
        skillsTitle.draw(at: CGPoint(x: 15, y: 15), withAttributes: TextAttributes.sidebarTitle)
        verticalPosition += 15 + skillsTitleSize.height

        context.setFillColor(NSColor.white.cgColor)
        context.fill(CGRect(x: 7, y: verticalPosition + 5, width: a4Size.width * (1/3) - 14, height: 1))
        verticalPosition += 6

        context.restoreGState()
        return verticalPosition
    }

    private func drawLanguagesSubSection(_ context: CGContext) -> CGFloat {
        context.saveGState()
        var verticalPosition: CGFloat = 0

        let languagesTitle = NSLocalizedString("LANGUAGES", bundle: bundle, comment: "Languages")
        let languagesTitleSize = languagesTitle.size(withAttributes: TextAttributes.sidebarTitle)
        languagesTitle.draw(at: CGPoint(x: 15, y: 15), withAttributes: TextAttributes.sidebarTitle)
        verticalPosition += 15 + languagesTitleSize.height

        context.setFillColor(NSColor.white.cgColor)
        context.fill(CGRect(x: 7, y: verticalPosition + 5, width: a4Size.width * (1/3) - 14, height: 1))
        verticalPosition += 6

        let spanishTitle = NSLocalizedString("SPANISH", bundle: bundle, comment: "Spanish")
        let spanishTitleSize = spanishTitle.size(withAttributes: TextAttributes.sidebarSubTitle)
        spanishTitle.draw(at: CGPoint(x: 15, y: verticalPosition + subSectionsSpacing), withAttributes: TextAttributes.sidebarSubTitle)
        verticalPosition += spanishTitleSize.height + subSectionsSpacing
        context.setFillColor(NSColor.purple.cgColor)
        let spanishBarFill = NSBezierPath(roundedRect: NSRect(x: 15, y: verticalPosition + valueSpacing, width: a4Size.width * (1/3) - 30, height: 10), xRadius: 2.5, yRadius: 2.5)
        spanishBarFill.fill()
        verticalPosition += 10 + valueSpacing

        let englishTitle = NSLocalizedString("ENGLISH", bundle: bundle, comment: "English")
        let englishTitleSize = englishTitle.size(withAttributes: TextAttributes.sidebarSubTitle)
        englishTitle.draw(at: CGPoint(x: 15, y: verticalPosition + subSectionsSpacing), withAttributes: TextAttributes.sidebarSubTitle)
        verticalPosition += englishTitleSize.height + subSectionsSpacing
        context.setFillColor(NSColor.lightGray.cgColor)
        let englishBarPath = NSBezierPath(roundedRect: NSRect(x: 15, y: verticalPosition + valueSpacing, width: a4Size.width * (1/3) - 30, height: 10), xRadius: 2.5, yRadius: 2.5)
        englishBarPath.fill()
        context.setFillColor(NSColor.purple.cgColor)
        let englishBarFill = NSBezierPath(roundedRect: NSRect(x: 15, y: verticalPosition + valueSpacing, width: (a4Size.width * (1/3) - 30) * (2/3), height: 10), xRadius: 2.5, yRadius: 2.5)
        englishBarFill.fill()
        verticalPosition += 10 + valueSpacing

        let japaneseTitle = NSLocalizedString("JAPANESE", bundle: bundle, comment: "Japanese")
        let japaneseTitleSize = japaneseTitle.size(withAttributes: TextAttributes.sidebarSubTitle)
        japaneseTitle.draw(at: CGPoint(x: 15, y: verticalPosition + subSectionsSpacing), withAttributes: TextAttributes.sidebarSubTitle)
        verticalPosition += japaneseTitleSize.height + subSectionsSpacing
        context.setFillColor(NSColor.lightGray.cgColor)
        let japaneseBarPath = NSBezierPath(roundedRect: NSRect(x: 15, y: verticalPosition + valueSpacing, width: a4Size.width * (1/3) - 30, height: 10), xRadius: 2.5, yRadius: 2.5)
        japaneseBarPath.fill()
        context.setFillColor(NSColor.purple.cgColor)
        let japaneseBarFill = NSBezierPath(roundedRect: NSRect(x: 15, y: verticalPosition + valueSpacing, width: (a4Size.width * (1/3) - 30) * (1/4), height: 10), xRadius: 2.5, yRadius: 2.5)
        japaneseBarFill.fill()
        verticalPosition += 10 + valueSpacing

        context.restoreGState()
        return verticalPosition
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
