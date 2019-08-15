import Foundation

extension Bundle {
    public var shortVersion: String? {
        return object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }

    public var buildVersion: String? {
        return object(forInfoDictionaryKey: "CFBundleVersion") as? String
    }
}
