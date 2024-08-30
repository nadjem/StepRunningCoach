//
//  Helper.swift
//  interval Running
//
//  Created by Nadjem Medjdoub on 19/08/2024.
//
import UIKit
import Foundation

struct AppFontName {
  static let regular = "MontserratRoman-Regular"
  static let bold = "MontserratRoman-Bold"
  static let light = "MontserratRoman-Light"
  static let thin = "Montserrat-Thin"
}
//customise font
extension UIFontDescriptor.AttributeName {
  static let nsctFontUIUsage = UIFontDescriptor.AttributeName(rawValue: "NSCTFontUIUsageAttribute")
}

extension UIFont {

  @objc class func mySystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.regular, size: size)!
  }

  @objc class func myBoldSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.bold, size: size)!
  }

  @objc class func myLightSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.light, size: size)!
  }
  
  @objc class func myThinSystemFont(ofSize size: CGFloat) -> UIFont {
          return UIFont(name: AppFontName.thin, size: size)!
  }

  @objc convenience init(myCoder aDecoder: NSCoder) {
    guard
        let fontDescriptor = aDecoder.decodeObject(forKey: "UIFontDescriptor") as? UIFontDescriptor,
        let fontAttribute = fontDescriptor.fontAttributes[.nsctFontUIUsage] as? String else {
        self.init(myCoder: aDecoder)
        return
    }
    var fontName = ""
    switch fontAttribute {
    case "CTFontRegularUsage":
        fontName = AppFontName.regular
    case "CTFontEmphasizedUsage", "CTFontBoldUsage":
        fontName = AppFontName.bold
    case "CTFontLightUsage":
        fontName = AppFontName.light
    case "CTFontThinUsage":
        fontName = AppFontName.thin
    default:
        fontName = AppFontName.regular
    }
    self.init(name: fontName, size: fontDescriptor.pointSize)!
  }

  class func overrideInitialize() {
    guard self == UIFont.self else { return }

    if let systemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:))),
        let mySystemFontMethod = class_getClassMethod(self, #selector(mySystemFont(ofSize:))) {
        method_exchangeImplementations(systemFontMethod, mySystemFontMethod)
    }

    if let boldSystemFontMethod = class_getClassMethod(self, #selector(boldSystemFont(ofSize:))),
        let myBoldSystemFontMethod = class_getClassMethod(self, #selector(myBoldSystemFont(ofSize:))) {
        method_exchangeImplementations(boldSystemFontMethod, myBoldSystemFontMethod)
    }

   /* if let lightSystemFontMethod = class_getClassMethod(self, #selector(italicSystemFont(ofSize:))),
        let lightSystemFontMethod = class_getClassMethod(self, #selector(myLightSystemFont(ofSize:))) {
        method_exchangeImplementations(lightSystemFontMethod, lightSystemFontMethod)
    }*/

    if let initCoderMethod = class_getInstanceMethod(self, #selector(UIFontDescriptor.init(coder:))), // Trick to get over the lack of UIFont.init(coder:))
        let myInitCoderMethod = class_getInstanceMethod(self, #selector(UIFont.init(myCoder:))) {
        method_exchangeImplementations(initCoderMethod, myInitCoderMethod)
    }
  }
}
