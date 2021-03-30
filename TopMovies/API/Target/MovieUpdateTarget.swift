//
//  MovieUpdateTarget.swift
//  TopMovies
//
//  Created by Macbook Pro  on 24.03.2021.
//

import Moya
import ReSwift

class MovieUpdateTarget {
  @Inject private var mainStore: MainStore
  private let movieId: MoviePreview.ID
  private var key: String {
    mainStore.state.configurationState.configuredAPIKey ?? ""
  }
  
  init(movieId: MoviePreview.ID) {
    self.movieId = movieId
  }
}

extension MovieUpdateTarget: TargetType {
  var baseURL: URL {
    URL(string: "https://api.themoviedb.org/3/movie")!
  }
  var path: String {
    movieId.value
  }
  var method: Moya.Method {
    .get
  }
  var sampleData: Data {
    Data()
  }
  var task: Task {
    .requestParameters(
      parameters: [
        "api_key": key,
        "language": "en"
      ],
      encoding: URLEncoding.default)
  }
  var headers: [String : String]? {
    ["Content-Type": "application/json;charset=utf-8"]
  }
}
