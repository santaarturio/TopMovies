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
  var isRequested: Bool { guard case .requested = self else { return false }; return true }
  var isDownloading: Bool { guard case .downloading = self else { return false }; return true }
}
