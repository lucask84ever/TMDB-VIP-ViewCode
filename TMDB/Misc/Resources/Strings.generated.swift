// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum TMDBStrings {
  /// Duração
  internal static let detailMovieDuration = TMDBStrings.tr("Localizable", "DetailMovieDuration", fallback: "Duração")
  /// Lançamento
  internal static let detailMovieReleaseYear = TMDBStrings.tr("Localizable", "DetailMovieReleaseYear", fallback: "Lançamento")
  /// Detalhes
  internal static let navigationBarDetailMovieTitle = TMDBStrings.tr("Localizable", "NavigationBarDetailMovieTitle", fallback: "Detalhes")
  /// Buscar filme
  internal static let tabbarSearchMovieTitle = TMDBStrings.tr("Localizable", "TabbarSearchMovieTitle", fallback: "Buscar filme")
  /// Em breve
  internal static let tabbarUpcomingMovieTitle = TMDBStrings.tr("Localizable", "TabbarUpcomingMovieTitle", fallback: "Em breve")
  internal enum Home {
    internal enum Label {
      /// What do you want to watch?
      internal static let wantToWatch = TMDBStrings.tr("Localizable", "Home.Label.WantToWatch", fallback: "What do you want to watch?")
    }
    internal enum ListMovie {
      /// Now playing
      internal static let nowPlaying = TMDBStrings.tr("Localizable", "Home.ListMovie.NowPlaying", fallback: "Now playing")
      /// Popular
      internal static let popular = TMDBStrings.tr("Localizable", "Home.ListMovie.Popular", fallback: "Popular")
      /// Top rated
      internal static let topRated = TMDBStrings.tr("Localizable", "Home.ListMovie.TopRated", fallback: "Top rated")
      /// Upcoming
      internal static let upcoming = TMDBStrings.tr("Localizable", "Home.ListMovie.Upcoming", fallback: "Upcoming")
    }
    internal enum Textfield {
      /// Search
      internal static let searchPlaceHolder = TMDBStrings.tr("Localizable", "Home.Textfield.SearchPlaceHolder", fallback: "Search")
    }
  }
  internal enum Tabbar {
    /// Home
    internal static let home = TMDBStrings.tr("Localizable", "Tabbar.home", fallback: "Home")
    /// Search
    internal static let search = TMDBStrings.tr("Localizable", "Tabbar.search", fallback: "Search")
    /// Watch list
    internal static let watchList = TMDBStrings.tr("Localizable", "Tabbar.watchList", fallback: "Watch list")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension TMDBStrings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
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
