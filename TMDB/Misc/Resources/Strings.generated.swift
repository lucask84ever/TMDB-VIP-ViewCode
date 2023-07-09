// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum TMDBStrings {
  internal enum Detail {
    /// Detail
    internal static let navigationTitle = TMDBStrings.tr("Localizable", "Detail.navigationTitle", fallback: "Detail")
    internal enum Detail {
      /// %.1f
      internal static func averageNoteFormat(_ p1: Float) -> String {
        return TMDBStrings.tr("Localizable", "Detail.detail.averageNoteFormat", p1, fallback: "%.1f")
      }
      /// %d Minutes
      internal static func durationFormat(_ p1: Int) -> String {
        return TMDBStrings.tr("Localizable", "Detail.detail.durationFormat", p1, fallback: "%d Minutes")
      }
    }
    internal enum Review {
      /// %d days ago
      internal static func dayReviewPlural(_ p1: Int) -> String {
        return TMDBStrings.tr("Localizable", "Detail.review.dayReviewPlural", p1, fallback: "%d days ago")
      }
      /// %d month ago
      internal static func dayReviewSingular(_ p1: Int) -> String {
        return TMDBStrings.tr("Localizable", "Detail.review.dayReviewSingular", p1, fallback: "%d month ago")
      }
      /// %d hours ago
      internal static func hourReviewPlural(_ p1: Int) -> String {
        return TMDBStrings.tr("Localizable", "Detail.review.hourReviewPlural", p1, fallback: "%d hours ago")
      }
      /// %d hour ago
      internal static func hourReviewSingular(_ p1: Int) -> String {
        return TMDBStrings.tr("Localizable", "Detail.review.hourReviewSingular", p1, fallback: "%d hour ago")
      }
      /// %d minutes ago
      internal static func minuteReviewPlural(_ p1: Int) -> String {
        return TMDBStrings.tr("Localizable", "Detail.review.minuteReviewPlural", p1, fallback: "%d minutes ago")
      }
      /// %d minute ago
      internal static func minuteReviewSingular(_ p1: Int) -> String {
        return TMDBStrings.tr("Localizable", "Detail.review.minuteReviewSingular", p1, fallback: "%d minute ago")
      }
      /// %d months ago
      internal static func monthReviewPlural(_ p1: Int) -> String {
        return TMDBStrings.tr("Localizable", "Detail.review.monthReviewPlural", p1, fallback: "%d months ago")
      }
      /// %d month ago
      internal static func monthReviewSingular(_ p1: Int) -> String {
        return TMDBStrings.tr("Localizable", "Detail.review.monthReviewSingular", p1, fallback: "%d month ago")
      }
      /// There is not reviews for this movie yet
      internal static let noReviews = TMDBStrings.tr("Localizable", "Detail.review.noReviews", fallback: "There is not reviews for this movie yet")
      /// %d years ago
      internal static func yearReviewPlural(_ p1: Int) -> String {
        return TMDBStrings.tr("Localizable", "Detail.review.yearReviewPlural", p1, fallback: "%d years ago")
      }
      /// %d year ago
      internal static func yearReviewSingular(_ p1: Int) -> String {
        return TMDBStrings.tr("Localizable", "Detail.review.yearReviewSingular", p1, fallback: "%d year ago")
      }
    }
    internal enum Selection {
      /// About Movie
      internal static let about = TMDBStrings.tr("Localizable", "Detail.selection.about", fallback: "About Movie")
      /// Cast
      internal static let cast = TMDBStrings.tr("Localizable", "Detail.selection.cast", fallback: "Cast")
      /// Reviews
      internal static let reviews = TMDBStrings.tr("Localizable", "Detail.selection.reviews", fallback: "Reviews")
      /// Trailer
      internal static let trailer = TMDBStrings.tr("Localizable", "Detail.selection.trailer", fallback: "Trailer")
    }
  }
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
  }
  internal enum Search {
    internal enum Cell {
      /// %.1f
      internal static func averageNoteFormat(_ p1: Float) -> String {
        return TMDBStrings.tr("Localizable", "Search.Cell.averageNoteFormat", p1, fallback: "%.1f")
      }
    }
    internal enum EmptyList {
      /// Find your movie by title
      internal static let subTitle = TMDBStrings.tr("Localizable", "Search.EmptyList.subTitle", fallback: "Find your movie by title")
      /// We are sorry, we can
      /// not find the movie 😔
      internal static let title = TMDBStrings.tr("Localizable", "Search.EmptyList.title", fallback: "We are sorry, we can\nnot find the movie 😔")
    }
    internal enum Textfield {
      /// Search
      internal static let searchPlaceHolder = TMDBStrings.tr("Localizable", "Search.Textfield.SearchPlaceHolder", fallback: "Search")
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
