//
//  EmptyRequestState.swift
//  TopMovies
//
//  Created by Macbook Pro  on 23.02.2021.
//

enum EmptyRequestState {
  case initial
  case requested
  case downloading
  case failed(error: Error)
}

extension EmptyRequestState {
  var isInitial: Bool { guard case .initial = self else { return false }; return true}
  var isRequested: Bool { guard case .requested = self else { return false }; return true }
  var isDownloading: Bool { guard case .downloading = self else { return false }; return true }
  var failedError: Error? { guard case let .failed(error) = self else { return nil }; return error }
}
