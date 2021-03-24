//
//  UpdateRequestState.swift
//  TopMovies
//
//  Created by Macbook Pro  on 24.03.2021.
//

enum UpdateRequestState: AutoEnum {
  case requested, downloading, updated
  case failed(Error)
}
