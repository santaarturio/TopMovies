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
    case marvelMovies
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
    URL(string: "https://api.themoviedb.org/4")!
  }
  var path: String {
    "/list/1"
  }
  var method: Moya.Method {
    switch target {
    case.marvelMovies: return .get
    }
  }
  var sampleData: Data {
    Data()
  }
  var task: Task {
    switch target {
    case.marvelMovies:
      return .requestParameters(
        parameters: [
          "page": 1,
          "api_key": key,
          "sort_by": "vote_average.desc"
        ],
        encoding: URLEncoding.default)
    }
  }
  var headers: [String : String]? {
    ["Content-Type": "application/json;charset=utf-8"]
  }
}
