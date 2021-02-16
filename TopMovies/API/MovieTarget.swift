//
//  MovieTarget.swift
//  TopMovies
//
//  Created by anikolaenko on 04.02.2021.
//
import ReSwift
import Moya

class MovieTarget: StoreSubscriber {
  typealias StoreSubscriberStateType = MainState
  private let target: Target
  private var key = ""
  
  init(target: Target) {
    self.target = target
    mainStore.subscribe(self)
  }
  
  enum Target {
    case nowPlaying(page: Int = 1)
    case popular(page: Int = 1)
    case topRated(page: Int = 1)
    case upcoming(page: Int = 1)
  }
  
  func newState(state: MainState) {
    switch state.configurationState {
    case let .configuredAPIKey(key): self.key = key
    default: break
    }
  }
}

extension MovieTarget: TargetType {
  var baseURL: URL {
    URL(string: "https://api.themoviedb.org/3/movie")!
  }
  var path: String {
    switch target {
    case .nowPlaying:
      return "now_playing"
    case .popular:
      return "popular"
    case .topRated:
      return "top_rated"
    case .upcoming:
      return "upcoming"
    }
  }
  var method: Moya.Method {
    .get
  }
  var sampleData: Data {
    Data()
  }
  var task: Task {
    switch target {
    case let .nowPlaying(page):
      return .requestParameters(
        parameters: [
          "api_key": key,
          "language": "en",
          "page": "\(page)"
        ],
        encoding: URLEncoding.default)
    case let .popular(page):
      return .requestParameters(
        parameters: [
          "api_key": key,
          "language": "en",
          "page": "\(page)"
        ],
        encoding: URLEncoding.default)
    case let .topRated(page):
      return .requestParameters(
        parameters: [
          "api_key": key,
          "language": "en",
          "page": "\(page)"
        ],
        encoding: URLEncoding.default)
    case let .upcoming(page):
      return .requestParameters(
        parameters: [
          "api_key": key,
          "language": "en",
          "page": "\(page)"
        ],
        encoding: URLEncoding.default)
    }
  }
  var headers: [String : String]? {
    ["Content-Type": "application/json;charset=utf-8"]
  }
}
