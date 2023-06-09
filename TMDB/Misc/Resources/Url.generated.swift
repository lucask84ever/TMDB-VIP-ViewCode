// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Plist Files

// swiftlint:disable identifier_name line_length type_body_length
internal enum PlistFiles {
  private static let _document = PlistDocument(path: "Url.plist")
  internal static let authorization: String = _document["Authorization"]
  internal static let cast: String = _document["cast"]
  internal static let detail: String = _document["detail"]
  internal static let host: String = _document["host"]
  internal static let imageHost: String = _document["imageHost"]
  internal static let imagePath: String = _document["imagePath"]
  internal static let path: String = _document["path"]
  internal static let playingNow: String = _document["playingNow"]
  internal static let popular: String = _document["popular"]
  internal static let reviews: String = _document["reviews"]
  internal static let scheme: String = _document["scheme"]
  internal static let search: String = _document["search"]
  internal static let topRated: String = _document["topRated"]
  internal static let trailers: String = _document["trailers"]
  internal static let upcoming: String = _document["upcoming"]
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

private func arrayFromPlist<T>(at path: String) -> [T] {
  guard let url = BundleToken.bundle.url(forResource: path, withExtension: nil),
    let data = NSArray(contentsOf: url) as? [T] else {
    fatalError("Unable to load PLIST at path: \(path)")
  }
  return data
}

private struct PlistDocument {
  let data: [String: Any]

  init(path: String) {
    guard let url = BundleToken.bundle.url(forResource: path, withExtension: nil),
      let data = NSDictionary(contentsOf: url) as? [String: Any] else {
        fatalError("Unable to load PLIST at path: \(path)")
    }
    self.data = data
  }

  subscript<T>(key: String) -> T {
    guard let result = data[key] as? T else {
      fatalError("Property '\(key)' is not of type \(T.self)")
    }
    return result
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
