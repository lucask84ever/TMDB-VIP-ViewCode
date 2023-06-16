// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit.NSColor
  internal typealias Color = NSColor
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIColor
  internal typealias Color = UIColor
#endif

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Colors

// swiftlint:disable identifier_name line_length type_body_length
internal struct ColorName {
  internal let rgbaValue: UInt32
  internal var color: Color { return Color(named: self) }

  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#242a32"></span>
  /// Alpha: 100% <br/> (0x242a32ff)
  internal static let backgroundColor = ColorName(rgbaValue: 0x242a32ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#252836"></span>
  /// Alpha: 82% <br/> (0x252836d2)
  internal static let backgroundColorWithAlpha = ColorName(rgbaValue: 0x252836d2)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ff8700"></span>
  /// Alpha: 100% <br/> (0xff8700ff)
  internal static let noteColor = ColorName(rgbaValue: 0xff8700ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#0296e5"></span>
  /// Alpha: 100% <br/> (0x0296e5ff)
  internal static let tabBarLine = ColorName(rgbaValue: 0x0296e5ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ffffff"></span>
  /// Alpha: 100% <br/> (0xffffffff)
  internal static let textColor = ColorName(rgbaValue: 0xffffffff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#3a3f47"></span>
  /// Alpha: 100% <br/> (0x3a3f47ff)
  internal static let textfieldBackground = ColorName(rgbaValue: 0x3a3f47ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#67686d"></span>
  /// Alpha: 100% <br/> (0x67686dff)
  internal static let textfieldTextIcon = ColorName(rgbaValue: 0x67686dff)
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

internal extension Color {
  convenience init(rgbaValue: UInt32) {
    let components = RGBAComponents(rgbaValue: rgbaValue).normalized
    self.init(red: components[0], green: components[1], blue: components[2], alpha: components[3])
  }
}

private struct RGBAComponents {
  let rgbaValue: UInt32

  private var shifts: [UInt32] {
    [
      rgbaValue >> 24, // red
      rgbaValue >> 16, // green
      rgbaValue >> 8,  // blue
      rgbaValue        // alpha
    ]
  }

  private var components: [CGFloat] {
    shifts.map { CGFloat($0 & 0xff) }
  }

  var normalized: [CGFloat] {
    components.map { $0 / 255.0 }
  }
}

internal extension Color {
  convenience init(named color: ColorName) {
    self.init(rgbaValue: color.rgbaValue)
  }
}
