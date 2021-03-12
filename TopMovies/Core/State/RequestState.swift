//
//  RequestState.swift
//  TopMovies
//
//  Created by anikolaenko on 03.02.2021.
//

enum RequestState<T> {
  case initial
  case requested
  case downloading
  case completed(data: T)
  case failed(error: Error)
}

extension RequestState {
  var isInitial: Bool { guard case .initial = self else { return false }; return true}
  var isRequested: Bool { guard case .requested = self else { return false }; return true }
  var isDownloading: Bool { guard case .downloading = self else { return false }; return true }
  var completedData: T? { guard case let .completed(data) = self else { return nil }; return data }
  var failedError: Error? { guard case let .failed(error) = self else { return nil }; return error }
}
