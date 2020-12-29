//
//  Page1.swift
//  CV
//
//  Created by Juan on 28/12/20.
//

import AppKit

struct Page1 {
    private var a4Size = CGRect(x: 0, y: 0, width: 8.3 * 72, height: 11.7 * 72)
    private let subSectionsSpacing: CGFloat = 9
    private let valueSpacing: CGFloat = 4

    private let bundle: Bundle

    init(bundle: Bundle) {
        self.bundle = bundle
    }

    func draw(in context: CGContext) {
        drawHeader(context)
        drawSidebar(context)
        drawContent(context)
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

        // Set origin to top left corner of content section
        context.translateBy(x: 0, y: 75)

        let title = NSLocalizedString("ABOUT_ME", bundle: bundle, comment: "About me")
        let titleSize = title.size(withAttributes: TextAttributes.sectionTitle)
        title.draw(at: CGPoint(x: 15, y: 15), withAttributes: TextAttributes.sectionTitle)
        context.translateBy(x: 0, y: titleSize.height + 15)

        context.setFillColor(NSColor.darkGray.cgColor)
        context.fill(CGRect(x: 15, y: 0, width: titleSize.width, height: 0.5))

        let content = NSLocalizedString("ABOUT", bundle: bundle, comment: "About content")
        let contentSize = content.boundingRect(with: CGSize(width: a4Size.width * (2/3), height: .greatestFiniteMagnitude), options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: TextAttributes.content)
        content.draw(in: CGRect(x: 0, y: 5, width: a4Size.width * (2/3), height: a4Size.height - 75), withAttributes: TextAttributes.content)
        context.translateBy(x: 0, y: contentSize.height + 5)

        context.translateBy(x: 0, y: 30)
        let education = NSLocalizedString("EDUCATION", bundle: bundle, comment: "Education")
        let educationSize = education.size(withAttributes: TextAttributes.sectionTitle)
        education.draw(at: CGPoint(x: 15, y: 0), withAttributes: TextAttributes.sectionTitle)
        context.translateBy(x: 0, y: educationSize.height)

        context.setFillColor(NSColor.darkGray.cgColor)
        context.fill(CGRect(x: 15, y: 0, width: educationSize.width, height: 0.5))

        let educationDate = NSLocalizedString("EDUCATION_DATE", bundle: bundle, comment: "Education date")
        let educationDateSize = educationDate.size(withAttributes: TextAttributes.educationDate)
        educationDate.draw(at: CGPoint(x: 15, y: 7), withAttributes: TextAttributes.educationDate)

        let educationName = NSLocalizedString("EDUCATION_NAME", bundle: bundle, comment: "Education description")
        let educationNameSize = educationName.size(withAttributes: TextAttributes.educationName)
        educationName.draw(at: CGPoint(x: educationDateSize.width + 20, y: 5), withAttributes: TextAttributes.educationName)
        context.translateBy(x: 0, y: educationNameSize.height)

        let educationDescription = NSLocalizedString("EDUCATION_DESCRIPTION", bundle: bundle, comment: "Education description")
        let educationDescriptionSize = educationDescription.boundingRect(with: CGSize(width: a4Size.width * (2/3) - educationDateSize.width - 20, height: .greatestFiniteMagnitude), options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: TextAttributes.content)
        educationDescription.draw(in: CGRect(x: educationDateSize.width + 5, y: 5, width: a4Size.width * (2/3) - educationDateSize.width - 20, height: a4Size.height - 75), withAttributes: TextAttributes.content)
        context.translateBy(x: 0, y: educationDescriptionSize.height + 5)

        let sideNote = NSLocalizedString("NOTE", bundle: bundle, comment: "Side Note")
        sideNote.draw(in: CGRect(x: 0, y: 30, width: a4Size.width * (2/3), height: a4Size.height - 75), withAttributes: TextAttributes.content)

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

        let ageTitle = NSLocalizedString("AGE", bundle: bundle, comment: "Age")
        lastHeight = drawSubSectionValue(context, name: ageTitle, value: "21")
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
        var lastHeight: CGFloat = 0

        let skillsTitle = NSLocalizedString("SKILLS", bundle: bundle, comment: "Contact")
        lastHeight = drawSectionTitle(context, title: skillsTitle)
        context.translateBy(x: 0, y: lastHeight)
        verticalPosition += lastHeight

        let languages = NSLocalizedString("PROGRAMMING_LANGUAGES", bundle: bundle, comment: "Programming languages")
        lastHeight = drawSubSectionList(context, name: languages, values: ["Swift", "Objective-C", "Javascript", "Python"])
        context.translateBy(x: 0, y: lastHeight)
        verticalPosition += lastHeight

        let frameworks = NSLocalizedString("FRAMEWORKS_LIBRARIES", bundle: bundle, comment: "Frameworks/Libraries")
        lastHeight = drawSubSectionList(context, name: frameworks, values: ["UIKit", "SwiftUI", "Core Graphics", "Core Data"])
        context.translateBy(x: 0, y: lastHeight)
        verticalPosition += lastHeight

        let other = NSLocalizedString("OTHER_TOOLS", bundle: bundle, comment: "Other")
        lastHeight = drawSubSectionList(context, name: other, values: ["REST", "Git", NSLocalizedString("UNITTESTS", bundle: bundle, comment: "Unit tests"), NSLocalizedString("CI", bundle: bundle, comment: "CI")])
        context.translateBy(x: 0, y: lastHeight)
        verticalPosition += lastHeight

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

        let languageSize = language.size(withAttributes: TextAttributes.language)
        language.draw(at: CGPoint(x: 15, y: verticalPosition + subSectionsSpacing), withAttributes: TextAttributes.language)
        verticalPosition += languageSize.height + subSectionsSpacing
        context.setFillColor(NSColor.lightGray.cgColor)
        let languageBarPath = NSBezierPath(roundedRect: NSRect(x: 15, y: verticalPosition + valueSpacing, width: a4Size.width * (1/3) - 30, height: 10), xRadius: 2.5, yRadius: 2.5)
        languageBarPath.fill()
        context.setFillColor(NSColor.lightPurple.cgColor)
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

    private func drawSubSectionList(_ context: CGContext, name: String, values: [String]) -> CGFloat {
        context.saveGState()
        var verticalPosition: CGFloat = 0

        let nameSize = name.size(withAttributes: TextAttributes.sidebarSubTitle)
        name.draw(at: CGPoint(x: 15, y: subSectionsSpacing), withAttributes: TextAttributes.sidebarSubTitle)
        verticalPosition += nameSize.height + subSectionsSpacing
        context.translateBy(x: 0, y: nameSize.height + subSectionsSpacing)

        for value in values {
            let valueSize = value.size()
            value.draw(at: CGPoint(x: 15, y: valueSpacing))
            verticalPosition += valueSize.height + valueSpacing
            context.translateBy(x: 0, y: valueSize.height + valueSpacing)
        }
        verticalPosition -= valueSpacing

        context.restoreGState()
        return verticalPosition
    }
}
