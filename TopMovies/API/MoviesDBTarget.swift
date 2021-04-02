//
//  MoviesDBTarget.swift
//  TopMovies
//
//  Created by anikolaenko on 04.02.2021.
//
import ReSwift
import Moya

enum MoviesDBTarget {
  @Inject static private var store: MainStore
  private var key: String {
    MoviesDBTarget.store.state.configurationState.configuredAPIKey ?? ""
  }
  
  case category(id: MovieCategory.ID, page: Int)
  case movie(id: MoviePreview.ID)
  
  func requestedCategoryPage() -> Int? {
    guard case let .category(_, page) = self else { return nil }
    return page
  }
}

extension MoviesDBTarget: TargetType {
  var baseURL: URL {
    URL(string: "https://api.themoviedb.org/3/movie")!
  }
  var path: String {
    switch self {
    case let .category(id, _):
      return id.value
    case let .movie(id):
      return id.value
    }
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
      ].merging(requestedCategoryPage() != nil ?
                  ["page" : "\(requestedCategoryPage()!)"] : [:]) { $1 },
      encoding: URLEncoding.default)
  }
  var headers: [String : String]? {
    ["Content-Type": "application/json;charset=utf-8"]
  }
}
