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
}
