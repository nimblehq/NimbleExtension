import Foundation

extension Bundle {
    var shortVersion: String? {
        return object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }

    var buildVersion: String? {
        return object(forInfoDictionaryKey: "CFBundleVersion") as? String
    }
}
