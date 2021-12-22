//
//  RowData.swift
//  PurchaseChallenge
//
//  Created by Silvia Kuzmova on 23.11.21.
//

import Foundation
import SwiftUI
import UIKit

enum RowData: CaseIterable, Identifiable {
    case now, fiveDays, sevenDays, empty

    var id: Self { self }

    var title: String {
        switch self {
        case .now:
            return "Right Now"
        case .fiveDays:
            return "In 5 days"
        case .sevenDays:
            return "In 7 days"
        case .empty:
            return ""
        }
    }

    var subTitle: String {
        switch self {
        case .now:
            return "You have full access to all the magic of Mate."
        case .fiveDays:
            return "We’ll send a reminder that your trial is ending soon."
        case .sevenDays:
            return "If you’re still enjoying Mate, we’ll accept your payment."
        case .empty:
            return ""
        }
    }

    var iconName: String? {
        switch self {
        case .now:
            return "face.smiling"
        case .fiveDays:
            return "bell"
        case .sevenDays:
            return "checkmark"
        case .empty:
            return nil
        }
    }

    var topColor: Color {
        return Color("gray-light")
    }

    var bottomColor: Color {
        switch self {
        case .empty:
            return Color("gray-extraLight")
        default:
            return Color("gray-light")
        }
    }

    var roundTopCorners: Bool {
        switch self {
        case .now:
            return true
        default:
            return false
        }
    }
}
