// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {

  internal enum App {
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
        /// Rating
        internal static let rating = L10n.tr("Localizable", "app.home.movie.rating")
        /// Reload in progress...
        internal static let reloadInProgress = L10n.tr("Localizable", "app.home.movie.reloadInProgress")
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
      /// out of
      internal static let outOf = L10n.tr("Localizable", "app.movieDetail.outOf")
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
      /// unknown
      internal static let unknownBudget = L10n.tr("Localizable", "app.movieDetail.unknownBudget")
      /// votes
      internal static let votes = L10n.tr("Localizable", "app.movieDetail.votes")
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
