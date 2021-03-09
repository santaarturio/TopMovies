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
  var isRequested: Bool { guard case .requested = self else { return false }; return true }
  var isDownloading: Bool { guard case .downloading = self else { return false }; return true }
}
