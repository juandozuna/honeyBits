//
//  ColorPallete.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 9/22/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import Foundation
import UIKit
import ChameleonFramework

enum Pallet: String {
    case PrimaryColor = "PrimaryColor"
    case PrimaryColorDark = "PrimaryColorDark"
    case SecondaryColor = "SecondaryColor"
    case Black = "Black"
    case White = "White"
    case Red = "Red"
    case FlatWhite = "FlatWhite"
    case Textbox = "Textbox"
    case Error = "Error"
    case ProgressBackground = "ProgressBackground"
    case Progress = "Progress"
    case Black50 = "Black50"
    case Light = "Light"
}

class ColorPallete {
    
    private let primaryColor = UIColor.flatYellow()
    private let primaryColorDark = UIColor(hexString: "#FF9B12")
    private let secondaryColor = UIColor(hexString: "#804600")
    private let black = UIColor.flatBlack()
    private let white = UIColor.white
    private let red = UIColor.red
    private let flatWhite = UIColor.flatWhite()
    private let textbox = UIColor.flatGray()
    private let error = UIColor.flatRed()
    private let progressBackground = UIColor.flatWhite()
    private let progress = UIColor(hexString: "#FF9B12")
    private let black50 = UIColor.flatBlack()?.lighten(byPercentage: 0.52)
    private let light = UIColor.flatBlack()?.lighten(byPercentage: 0.7)
    
    func getColor(_ color: String) -> UIColor? {
        if let parsedColor = Pallet(rawValue: color) {
            switch parsedColor {
            case .PrimaryColor:
                return primaryColor
            case .PrimaryColorDark:
                return primaryColorDark
            case .SecondaryColor:
                return secondaryColor
            case .Black:
                return black
            case .White:
                return white
            case .Red:
                return red
            case .FlatWhite:
                return flatWhite
            case .Textbox:
                return textbox
            case .Error:
                return error
            case .ProgressBackground:
                return progressBackground
            case .Progress:
                return progress
            case .Black50:
                return black50
            case .Light:
                return light
            }
        }
        return nil
    }
}
