//: AppleHardwareIcons - convert sysctl hw.model -> name and image

import Cocoa
import AppleHardwareIcons

let hardware = Hardware()

let currentModelNameAndImage = hardware.nameAndImageForCurrentModel()
let currentModelImage = currentModelNameAndImage?.1

let test = hardware.namesAndImages(forModels: ["iPhone"]).first?.1

let phoneNamesAndImages = hardware.namesAndImages(forModels: ["iPhone1,1", "iPhone2,1", "iPhone3,1", "iPhone4,1", "iPhone5,1", "iPhone6,1", "iPhone6,2", "iPhone7,1", "iPhone7,2", "iPhone8,1", "iPhone8,2", "iPhone9,1", "iPhone9,2"])
let phoneImages = phoneNamesAndImages.flatMap { $0.1 }

let padNamesAndImages = hardware.namesAndImages(forModels: ["iPad1,1", "iPad2,1", "iPad3,1", "iPad4,1", "iPad5,1"])
let padImages = padNamesAndImages.flatMap { $0.1 }

let macBookProNamesAndImages = hardware.namesAndImages(forModels: ["MacBookPro1,1", "MacBookPro2,1", "MacBookPro3,1", "MacBookPro4,1", "MacBookPro5,1", "MacBookPro6,1", "MacBookPro7,1", "MacBookPro8,1", "MacBookPro9,1", "MacBookPro10,1", "MacBookPro11,1", "MacBookPro12,1", "MacBookPro13,1", "MacBookPro14,1"])
let macBookProImages = macBookProNamesAndImages.flatMap { $0.1 }
