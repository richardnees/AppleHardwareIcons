//: Playground - noun: a place where people can play

import Cocoa

func nameAndImage(forModel model: String) -> (String, NSImage)? {
    let tag = "com.apple.device-model-code"
    
    guard
        let uti = UTTypeCreatePreferredIdentifierForTag(tag as CFString, model as CFString, nil)?.takeUnretainedValue(),
        let utiDecl = UTTypeCopyDeclaration(uti)?.takeUnretainedValue() as? [String:AnyObject] else {
            return nil
    }
    
    var iconFileName: String?
    if let iconFileObject = utiDecl["UTTypeIconFile"] as? String {
        iconFileName = iconFileObject
    } else if let iconFileObject = utiDecl["_LSIconPath"] as? String {
        iconFileName = iconFileObject.components(separatedBy: "/").last!
    }
    
    guard
        let description = UTTypeCopyDescription(uti)?.takeUnretainedValue() as? String,
        let bundleURL = UTTypeCopyDeclaringBundleURL(uti)?.takeUnretainedValue() as? URL,
        let bundle = Bundle(url: bundleURL),
        let imageURL = bundle.url(forResource: iconFileName, withExtension: nil),
        let image = NSImage(contentsOf: imageURL) else {
            return nil
    }

    return (description, image)
}

func namesAndImages(forModels models: [String]) -> [(String, NSImage)] {
    return models.flatMap { [nameAndImage(forModel: $0)].flatMap { $0 } }
}

let phoneImages = namesAndImages(forModels: ["iPhone1,1", "iPhone2,1", "iPhone3,1", "iPhone4,1", "iPhone5,1", "iPhone6,1", "iPhone6,2", "iPhone7,1", "iPhone7,2", "iPhone8,1", "iPhone8,2", "iPhone9,1", "iPhone9,2"])

let padImages = namesAndImages(forModels: ["iPad1,1", "iPad2,1", "iPad3,1", "iPad4,1", "iPad5,1"])

let macBookProImages = namesAndImages(forModels: ["MacBookPro1,1", "MacBookPro2,1", "MacBookPro3,1", "MacBookPro4,1", "MacBookPro5,1", "MacBookPro6,1", "MacBookPro7,1", "MacBookPro8,1", "MacBookPro9,1", "MacBookPro10,1", "MacBookPro11,1", "MacBookPro12,1", "MacBookPro13,1", "MacBookPro14,1"])
