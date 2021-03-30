//
//  MovieTarget.swift
//  TopMovies
//
//  Created by anikolaenko on 04.02.2021.
//
import ReSwift
import Moya

class MovieTarget{
  @Inject private var mainStore: MainStore
  typealias StoreSubscriberStateType = MainState
  private let requestedCategory: RequestedCategory
  private var key: String {
    mainStore.state.configurationState.configuredAPIKey ?? ""
  }
  
  init(requestedCategory: RequestedCategory) {
    self.requestedCategory = requestedCategory
  }
  
  enum RequestedCategory {
    case nowPlaying(page: Int)
    case popular(page: Int)
    case topRated(page: Int)
    case upcoming(page: Int)
    
    func requestedPage() -> Int {
      switch self {
      case let .nowPlaying(page),
           let .popular(page),
           let .topRated(page),
           let .upcoming(page):
        return page
      }
    }
  }
}

extension MovieTarget: TargetType {
  var baseURL: URL {
    URL(string: "https://api.themoviedb.org/3/movie")!
  }
  var path: String {
    switch requestedCategory {
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
    .requestParameters(
        parameters: [
          "api_key": key,
          "language": "en",
          "page": "\(requestedCategory.requestedPage())"
        ],
        encoding: URLEncoding.default)
  }
  var headers: [String : String]? {
    ["Content-Type": "application/json;charset=utf-8"]
  }
}
