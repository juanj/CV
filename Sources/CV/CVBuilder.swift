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
        var lastHeight: CGFloat = 0

        let contactTitle = NSLocalizedString("CONTACT", bundle: bundle, comment: "Contact")
        lastHeight = drawSectionTitle(context, title: contactTitle)
        context.translateBy(x: 0, y: lastHeight)
        verticalPosition += lastHeight

        let phoneTitle = NSLocalizedString("PHONE", bundle: bundle, comment: "Phone")
        lastHeight = drawSubSectionValue(context, name: phoneTitle, value: "+57 000 000 0000")
        context.translateBy(x: 0, y: lastHeight)
        verticalPosition += lastHeight

        let emailTitle = NSLocalizedString("EMAIL", bundle: bundle, comment: "Email")
        lastHeight = drawSubSectionValue(context, name: emailTitle, value: "myemailaddress@mail.com")
        context.translateBy(x: 0, y: lastHeight)
        verticalPosition += lastHeight

        let cityTitle = NSLocalizedString("CITY", bundle: bundle, comment: "City")
        lastHeight = drawSubSectionValue(context, name: cityTitle, value: "Bogotá, Colombia")
        context.translateBy(x: 0, y: lastHeight)
        verticalPosition += lastHeight

        lastHeight = drawSubSectionValue(context, name: "GitHub", value: "https://github.com/juanj")
        context.translateBy(x: 0, y: lastHeight)
        verticalPosition += lastHeight

        context.restoreGState()
        return verticalPosition
    }

    private func drawSkillsSubSection(_ context: CGContext) -> CGFloat {
        context.saveGState()
        var verticalPosition: CGFloat = 0

        let skillsTitle = NSLocalizedString("SKILLS", bundle: bundle, comment: "Contact")
        verticalPosition = drawSectionTitle(context, title: skillsTitle)
        context.translateBy(x: 0, y: verticalPosition)

        let languages = NSLocalizedString("PROGRAMMING_LANGUAGES", bundle: bundle, comment: "Programming languages")
        let languagesSize = languages.size(withAttributes: TextAttributes.sidebarSubTitle)
        languages.draw(at: CGPoint(x: 15, y: subSectionsSpacing), withAttributes: TextAttributes.sidebarSubTitle)
        verticalPosition += languagesSize.height + subSectionsSpacing
        context.translateBy(x: 0, y: languagesSize.height + subSectionsSpacing)

        let image = Bundle.module.image(forResource: "swift")!
        image.draw(in: NSRect(x: 15, y: valueSpacing, width: 15, height: 15))

        let swift = "Swift"
        let swiftSize = swift.size()
        swift.draw(at: CGPoint(x: 35, y: valueSpacing))
        verticalPosition += swiftSize.height + valueSpacing
        context.translateBy(x: 0, y: swiftSize.height + valueSpacing)

        let objectiveC = "Objective-C"
        let objectiveCSize = swift.size()
        objectiveC.draw(at: CGPoint(x: 15, y: valueSpacing))
        verticalPosition += objectiveCSize.height + valueSpacing
        context.translateBy(x: 0, y: objectiveCSize.height + valueSpacing)

        let javascript = "Javascript"
        let javascriptSize = swift.size()
        javascript.draw(at: CGPoint(x: 15, y: valueSpacing))
        verticalPosition += javascriptSize.height + valueSpacing
        context.translateBy(x: 0, y: javascriptSize.height + valueSpacing)

        let python = "Python"
        let pythonSize = swift.size()
        python.draw(at: CGPoint(x: 15, y: valueSpacing))
        verticalPosition += pythonSize.height + valueSpacing
        context.translateBy(x: 0, y: pythonSize.height + valueSpacing)

        let frameworks = NSLocalizedString("FRAMEWORKS_LIBRARIES", bundle: bundle, comment: "Frameworks/Libraries")
        let frameworksSize = frameworks.size(withAttributes: TextAttributes.sidebarSubTitle)
        frameworks.draw(at: CGPoint(x: 15, y: subSectionsSpacing), withAttributes: TextAttributes.sidebarSubTitle)
        verticalPosition += frameworksSize.height + subSectionsSpacing
        context.translateBy(x: 0, y: frameworksSize.height + subSectionsSpacing)

        let uikit = "UIKit"
        let uikitSize = swift.size()
        uikit.draw(at: CGPoint(x: 15, y: valueSpacing))
        verticalPosition += uikitSize.height + valueSpacing
        context.translateBy(x: 0, y: uikitSize.height + valueSpacing)

        let swiftui = "SwiftUI"
        let swiftuiSize = swift.size()
        swiftui.draw(at: CGPoint(x: 15, y: valueSpacing))
        verticalPosition += swiftuiSize.height + valueSpacing
        context.translateBy(x: 0, y: swiftuiSize.height + valueSpacing)

        let coregraphics = "Core Graphics"
        let coregraphicsSize = swift.size()
        coregraphics.draw(at: CGPoint(x: 15, y: valueSpacing))
        verticalPosition += coregraphicsSize.height + valueSpacing
        context.translateBy(x: 0, y: coregraphicsSize.height + valueSpacing)

        let coredata = "Core Data"
        let coredataSize = swift.size()
        coredata.draw(at: CGPoint(x: 15, y: valueSpacing))
        verticalPosition += coredataSize.height + valueSpacing
        context.translateBy(x: 0, y: coredataSize.height + valueSpacing)

        let other = NSLocalizedString("OTHER_TOOLS", bundle: bundle, comment: "Other")
        let otherSize = other.size(withAttributes: TextAttributes.sidebarSubTitle)
        other.draw(at: CGPoint(x: 15, y: subSectionsSpacing), withAttributes: TextAttributes.sidebarSubTitle)
        verticalPosition += otherSize.height + subSectionsSpacing
        context.translateBy(x: 0, y: otherSize.height + subSectionsSpacing)

        let rest = "REST"
        let restSize = rest.size()
        rest.draw(at: CGPoint(x: 15, y: valueSpacing))
        verticalPosition += restSize.height + valueSpacing
        context.translateBy(x: 0, y: restSize.height + valueSpacing)

        let git = "Git"
        let gitSize = git.size()
        git.draw(at: CGPoint(x: 15, y: valueSpacing))
        verticalPosition += gitSize.height + valueSpacing
        context.translateBy(x: 0, y: gitSize.height + valueSpacing)

        let unitTests = NSLocalizedString("UNITTESTS", bundle: bundle, comment: "Unit tests")
        let unitTestsSize = unitTests.size()
        unitTests.draw(at: CGPoint(x: 15, y: valueSpacing))
        verticalPosition += unitTestsSize.height + valueSpacing
        context.translateBy(x: 0, y: unitTestsSize.height + valueSpacing)

        let ci = NSLocalizedString("CI", bundle: bundle, comment: "CI")
        let ciSize = unitTests.size()
        ci.draw(at: CGPoint(x: 15, y: valueSpacing))
        verticalPosition += ciSize.height + valueSpacing
        context.translateBy(x: 0, y: ciSize.height + valueSpacing)

        context.restoreGState()
        return verticalPosition
    }

    private func drawLanguagesSubSection(_ context: CGContext) -> CGFloat {
        context.saveGState()
        var verticalPosition: CGFloat = 0

        let languagesTitle = NSLocalizedString("LANGUAGES", bundle: bundle, comment: "Languages")
        verticalPosition = drawSectionTitle(context, title: languagesTitle)
        context.translateBy(x: 0, y: verticalPosition)

        let spanishTitle = NSLocalizedString("SPANISH", bundle: bundle, comment: "Spanish")
        verticalPosition = drawLanguageBar(context, language: spanishTitle, progress: 1)
        context.translateBy(x: 0, y: verticalPosition)

        let englishTitle = NSLocalizedString("ENGLISH", bundle: bundle, comment: "English")
        verticalPosition = drawLanguageBar(context, language: englishTitle, progress: 2/3)
        context.translateBy(x: 0, y: verticalPosition)

        let japaneseTitle = NSLocalizedString("JAPANESE", bundle: bundle, comment: "Japanese")
        verticalPosition = drawLanguageBar(context, language: japaneseTitle, progress: 1/4)
        context.translateBy(x: 0, y: verticalPosition)

        context.restoreGState()
        return verticalPosition
    }

    private func drawSectionTitle(_ context: CGContext, title: String) -> CGFloat {
        context.saveGState()
        var verticalPosition: CGFloat = 0

        let titleSize = title.size(withAttributes: TextAttributes.sidebarTitle)
        title.draw(at: CGPoint(x: 15, y: 15), withAttributes: TextAttributes.sidebarTitle)
        verticalPosition += 15 + titleSize.height

        context.setFillColor(NSColor.white.cgColor)
        context.fill(CGRect(x: 7, y: verticalPosition + 5, width: a4Size.width * (1/3) - 14, height: 1))
        verticalPosition += 6

        context.restoreGState()
        return verticalPosition
    }

    private func drawLanguageBar(_ context: CGContext, language: String, progress: CGFloat) -> CGFloat {
        context.saveGState()
        var verticalPosition: CGFloat = 0

        let languageSize = language.size(withAttributes: TextAttributes.sidebarSubTitle)
        language.draw(at: CGPoint(x: 15, y: verticalPosition + subSectionsSpacing), withAttributes: TextAttributes.sidebarSubTitle)
        verticalPosition += languageSize.height + subSectionsSpacing
        context.setFillColor(NSColor.lightGray.cgColor)
        let languageBarPath = NSBezierPath(roundedRect: NSRect(x: 15, y: verticalPosition + valueSpacing, width: a4Size.width * (1/3) - 30, height: 10), xRadius: 2.5, yRadius: 2.5)
        languageBarPath.fill()
        context.setFillColor(NSColor.purple.cgColor)
        let languageFillPath = NSBezierPath(roundedRect: NSRect(x: 15, y: verticalPosition + valueSpacing, width: (a4Size.width * (1/3) - 30) * progress, height: 10), xRadius: 2.5, yRadius: 2.5)
        languageFillPath.fill()
        verticalPosition += 10 + valueSpacing

        context.restoreGState()
        return verticalPosition
    }

    private func drawSubSectionValue(_ context: CGContext, name: String, value: String) -> CGFloat {
        context.saveGState()
        var verticalPosition: CGFloat = 0

        let nameSize = name.size(withAttributes: TextAttributes.sidebarSubTitle)
        name.draw(at: CGPoint(x: 15, y: verticalPosition + subSectionsSpacing), withAttributes: TextAttributes.sidebarSubTitle)
        verticalPosition += nameSize.height + subSectionsSpacing

        let valueSize = value.size()
        value.draw(at: CGPoint(x: 15, y: verticalPosition + valueSpacing))
        verticalPosition += valueSize.height + valueSpacing

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
