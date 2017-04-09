//: [Previous](@previous)

import Foundation
import AppleHardwareIcons

let tag = "com.apple.device-model-code"
let model = "iPhone6,1"
let uti = UTTypeCreatePreferredIdentifierForTag(tag as CFString, model as CFString, nil)?.takeUnretainedValue()

let utiDecl = UTTypeCopyDeclaration(uti!)?.takeUnretainedValue() as? [String:AnyObject]

let utis = UTTypeCreateAllIdentifiersForTag(tag as CFString, model as CFString, nil)?.takeUnretainedValue()

//: [Next](@next)
