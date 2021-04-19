//
//  RequestState.swift
//  TopMovies
//
//  Created by anikolaenko on 03.02.2021.
//

enum RequestState<T>: AutoEnum {
  case initial
  case requested
  case downloading
  case completed(data: T)
  case failed(error: Error)
}
