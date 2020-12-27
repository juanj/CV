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
}
