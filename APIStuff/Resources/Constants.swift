//
//  Constants.swift
//  APIStuff
//
//  Created by David Jabech on 7/20/22.
//

import UIKit

    // Basic constants intended for framing/constraining UIViews

struct Constants {
    
    static let semibold = UIFont.systemFont(ofSize: 20, weight: .semibold)
    static let smallFont = UIFont.systemFont(ofSize: 15)
    static let cornerRadius: CGFloat = 15
    
    static let width: CGFloat = 250
    static let smallWidth: CGFloat = 50
    static let height: CGFloat = 60
    static let padding: CGFloat = 20
    static let smallPadding: CGFloat = 15
}

    // System names for UIImages (SFSymbols)

struct SFSymbol {
    static let incomplete = "circle"
    static let complete = "circle.circle.fill"
    static let APITab = "app.connected.to.app.below.fill"
}
