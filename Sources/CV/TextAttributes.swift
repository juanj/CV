//
//  TextAttributes.swift
//  CV
//
//  Created by Juan on 25/12/20.
//

import AppKit

struct TextAttributes {
    static let whiteBigTitle: [NSAttributedString.Key: Any] = [
        .foregroundColor: NSColor.white,
        .font: NSFont.systemFont(ofSize: 25, weight: .semibold)
    ]

    static let whiteSubTitle: [NSAttributedString.Key: Any] = [
        .foregroundColor: NSColor.white,
        .font: NSFont.systemFont(ofSize: 15, weight: .thin)
    ]

    static let sectionTitle: [NSAttributedString.Key: Any] = [
        .foregroundColor: NSColor.darkGray,
        .font: NSFont.systemFont(ofSize: 15, weight: .semibold)
    ]

    static let content: [NSAttributedString.Key: Any] = [
        .foregroundColor: NSColor.darkGray,
        .font: NSFont.systemFont(ofSize: 12, weight: .regular),
        .paragraphStyle: paddedParagraphStyle
    ]

    static let paddedParagraphStyle: NSParagraphStyle = {
        let style = NSMutableParagraphStyle()

        style.headIndent = 15
        style.firstLineHeadIndent = 15
        style.tailIndent = -15

        return style
    }()

    static let educationDate: [NSAttributedString.Key: Any] = [
        .font: NSFont.systemFont(ofSize: 10, weight: .semibold)
    ]

    static let educationName: [NSAttributedString.Key: Any] = [
        .font: NSFont.systemFont(ofSize: 12, weight: .bold)
    ]

    static let sidebarTitle: [NSAttributedString.Key: Any] = [
        .foregroundColor: NSColor.lightPurple,
        .font: NSFont.systemFont(ofSize: 15, weight: .bold)
    ]

    static let sidebarSubTitle: [NSAttributedString.Key: Any] = [
        .foregroundColor: NSColor.lightPurple,
        .font: NSFont.systemFont(ofSize: 11, weight: .bold)
    ]

    static let language: [NSAttributedString.Key: Any] = [
        .foregroundColor: NSColor.black,
        .font: NSFont.systemFont(ofSize: 11, weight: .regular)
    ]

    static func parseLinksIn(_ text: String, withAttributes attributes: [NSAttributedString.Key: Any]) -> NSAttributedString {
        let pattern = #"\(([^\)]+)\)\[([^\]]+)\]"#
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            return NSAttributedString(string: text, attributes: attributes)
        }

        let matches = regex.matches(in: text, options: [], range: NSRange(location: 0, length: text.count))
        var offset = 0
        var urls = [(range: NSRange, url: String)]()
        var cleanedString = text
        for match in matches {
            let newTextRange = NSRange(location: match.range(at: 1).location - 1 - offset, length: match.range(at: 1).length)
            let onlyText: String
            if let textRange = Range(match.range(at: 1), in: text) {
                onlyText = String(text[textRange])
            } else {
                onlyText = ""
            }

            let url: String
            if let urlRange = Range(match.range(at: 2), in: text) {
                url = String(text[urlRange])
            } else {
                url = ""
            }

            if let fullRange = Range(NSRange(location: match.range(at: 0).location - offset, length: match.range(at: 0).length), in: cleanedString) {
                cleanedString = cleanedString.replacingCharacters(in: fullRange, with: onlyText)
                offset += match.range(at: 0).length - onlyText.count
            }
            urls.append((range: newTextRange, url: url))
        }

        let string = NSMutableAttributedString(string: cleanedString, attributes: attributes)

        for url in urls {
            string.addAttribute(.link, value: url.url, range: url.range)
            string.addAttribute(.foregroundColor, value: NSColor.blue, range: url.range)
            string.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: url.range)
        }

        return string
    }
}
