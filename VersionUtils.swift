
class VersionUtils {
    static func getVersionAsDouble(version: String? = nil) -> Double {
        var currentVersion: String = version ?? (Bundle.main.appVersion ?? "0")
        if (currentVersion.components(separatedBy: ".").count - 1) >= 2 {
            let lastDot = currentVersion.lastIndex(of: ".")
            currentVersion.remove(at: lastDot!)
        }
        return Double(currentVersion) ?? 0
    }
}