// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {

  internal enum App {
    internal enum Category {
      internal enum Name {
        /// Now Playing
        internal static let nowPlaying = L10n.tr("Localizable", "app.category.name.nowPlaying")
        /// Popular
        internal static let popular = L10n.tr("Localizable", "app.category.name.popular")
        /// Top Rated
        internal static let topRated = L10n.tr("Localizable", "app.category.name.topRated")
        /// Upcoming
        internal static let upcoming = L10n.tr("Localizable", "app.category.name.upcoming")
      }
    }
    internal enum Home {
      /// TopMovies
      internal static let title = L10n.tr("Localizable", "app.home.title")
      internal enum Movie {
        /// Adult
        internal static let adult = L10n.tr("Localizable", "app.home.movie.adult")
        /// No
        internal static let no = L10n.tr("Localizable", "app.home.movie.no")
        /// no overview
        internal static let overview = L10n.tr("Localizable", "app.home.movie.overview")
        /// Pull to refresh
        internal static let pullToRefresh = L10n.tr("Localizable", "app.home.movie.pullToRefresh")
        /// Rating
        internal static let rating = L10n.tr("Localizable", "app.home.movie.rating")
        /// Yes
        internal static let yes = L10n.tr("Localizable", "app.home.movie.yes")
      }
    }
    internal enum MovieDetail {
      /// Budget
      internal static let budget = L10n.tr("Localizable", "app.movieDetail.budget")
      /// Genres
      internal static let genres = L10n.tr("Localizable", "app.movieDetail.genres")
      /// minutes
      internal static let minutes = L10n.tr("Localizable", "app.movieDetail.minutes")
      /// no overview
      internal static let overview = L10n.tr("Localizable", "app.movieDetail.overview")
      /// Rating
      internal static let rating = L10n.tr("Localizable", "app.movieDetail.rating")
      /// Release
      internal static let release = L10n.tr("Localizable", "app.movieDetail.release")
      /// Runtime
      internal static let runtime = L10n.tr("Localizable", "app.movieDetail.runtime")
      /// Status
      internal static let status = L10n.tr("Localizable", "app.movieDetail.status")
      /// TMDB
      internal static let tmdb = L10n.tr("Localizable", "app.movieDetail.tmdb")
      /// unknown
      internal static let unknownBudget = L10n.tr("Localizable", "app.movieDetail.unknownBudget")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
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
