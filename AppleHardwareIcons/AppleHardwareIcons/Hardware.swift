import Cocoa

public class Hardware {
    
    public init() {
        
    }
    
    public func model() -> String {
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            return "iOS Simulator"
        #elseif (arch(i386) || arch(x86_64)) && os(watchOS)
            return "watchOS Simulator"
        #elseif (arch(i386) || arch(x86_64)) && os(tvOS)
            return "tvOS Simulator"
        #else
            var size = 0
            sysctlbyname("hw.model", nil, &size, nil, 0)
            var machine = [CChar](repeating: 0,  count: Int(size))
            sysctlbyname("hw.model", &machine, &size, nil, 0)
            return String(cString: machine)
        #endif
    }
    
    public func nameAndImageForCurrentModel() -> (String, NSImage)? {
        return nameAndImage(forModel: model())
    }
    
    public func nameAndImage(forModel model: String) -> (String, NSImage)? {
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
            let description = UTTypeCopyDescription(uti)?.takeUnretainedValue() as String?,
            let bundleURL = UTTypeCopyDeclaringBundleURL(uti)?.takeUnretainedValue() as URL?,
            let bundle = Bundle(url: bundleURL),
            let imageURL = bundle.url(forResource: iconFileName, withExtension: nil),
            let image = NSImage(contentsOf: imageURL) else {
                return nil
        }
        
        return (description, image)
    }
    
    public func namesAndImages(forModels models: [String]) -> [(String, NSImage)] {
        return models.flatMap { [nameAndImage(forModel: $0)].flatMap { $0 } }
    }
}
