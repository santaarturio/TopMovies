//
//  EmptyRequestState.swift
//  TopMovies
//
//  Created by Macbook Pro  on 23.02.2021.
//

enum EmptyRequestState: AutoEnum {
  case initial
  case requested
  case downloading
  case failed(error: Error)
}
