// Generated using Sourcery 1.3.4 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// macro associatedValueVarMultiType case
// macro associatedValueVarUnitType case
// macro associatedValueVar case
// macro simpleVar case
// macro setCase case

// MARK: - AutoEnum subsribers
extension AppFlowState {
  var isLaunching: Bool { guard case .launching = self else { return false }; return true }
  var isForeground: Bool { guard case .foreground = self else { return false }; return true }
  var isBackground: Bool { guard case .background = self else { return false }; return true }
  var isTerminating: Bool { guard case .terminating = self else { return false }; return true }
}
extension ConfigurationState {
  var isInitial: Bool { guard case .initial = self else { return false }; return true }
  var configuredAPIKey: String? { guard case let .configuredAPIKey(configuredAPIKey) = self else { return nil }; return configuredAPIKey }
}
extension EmptyRequestState {
  var isInitial: Bool { guard case .initial = self else { return false }; return true }
  var isRequested: Bool { guard case .requested = self else { return false }; return true }
  var isDownloading: Bool { guard case .downloading = self else { return false }; return true }
  var failed: Error? { guard case let .failed(failed) = self else { return nil }; return failed }
}
extension MovieCategoryRequest {
  var isNowPlaying: Bool { guard case .nowPlaying = self else { return false }; return true }
  var isPopular: Bool { guard case .popular = self else { return false }; return true }
  var isTopRated: Bool { guard case .topRated = self else { return false }; return true }
  var isUpcoming: Bool { guard case .upcoming = self else { return false }; return true }
}
extension RequestState {
  var isInitial: Bool { guard case .initial = self else { return false }; return true }
  var isRequested: Bool { guard case .requested = self else { return false }; return true }
  var isDownloading: Bool { guard case .downloading = self else { return false }; return true }
  var completed: T? { guard case let .completed(completed) = self else { return nil }; return completed }
  var failed: Error? { guard case let .failed(failed) = self else { return nil }; return failed }
}

/* add '// sourcery: autoGetter' before some case for usage */
// MARK: - Annotations
