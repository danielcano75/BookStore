//
//  DesignSystem+Font.swift
//  BookStore
//
//  Created by Daniel Cano on 7/17/26.
//

import SwiftUI

extension Font {
    enum Weight: String {
        case bold = "NewYorkLarge-Bold"
        case regular = "NewYork"
        case italic = "NewYorkItalic"
        case medium = "NewYorkMedium-Medium"
        case semiBold = "NewYorkMedium-Semibold"
        case heavy = "NewYorkMedium-Heavy"
        
        var weight: String {
            rawValue
        }
    }
    
    static let title = Font.custom(Weight.heavy.weight, size: 17)
    static let titleRegular = Font.custom(Weight.regular.weight, size: 17)
    static let title2 = Font.custom(Weight.bold.weight, size: 18)
    static let title3 = Font.custom(Weight.bold.weight, size: 24)
    static let text = Font.custom(Weight.regular.weight, size: 14)
    static let textBold = Font.custom(Weight.bold.weight, size: 14)
    static let textMedium = Font.custom(Weight.medium.weight, size: 14)
    static let textSemiBold = Font.custom(Weight.medium.weight, size: 14)
    static let smallText = Font.custom(Weight.regular.weight, size: 12)
    static let icon = Font.custom(Weight.regular.weight, size: 24)
    static let icon2 = Font.custom(Weight.regular.weight, size: 20)
}
