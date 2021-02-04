//
//  MovieTarget.swift
//  TopMovies
//
//  Created by anikolaenko on 04.02.2021.
//

import Moya

enum MovieTarget {
    static private let apiKey = "4c863658028fbff309081bee90439c33"
    static private let apiReadAccessToke = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0Yzg2MzY1ODAyOGZiZmYzMDkwODFiZWU5MDQzOWMzMyIsInN1YiI6IjYwMWJjMGQyMTEwOGE4MDAzZWMyY2I0MyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.TDPNBw8bMqPVG8LuzFFJdpKX0PIi-pWoamoXs5_r150"

    case marvelMovies
}

extension MovieTarget: TargetType {
    var baseURL: URL {
        URL(string: "https://api.themoviedb.org/4")!
    }
    var path: String {
        "/list/1"
    }
    var method: Method {
        switch self {
        case .marvelMovies: return .get
        }
    }
    var sampleData: Data {
        Data()
    }
    var task: Task {
        .requestParameters(parameters: ["page": 1, "api_key": MovieTarget.apiKey], encoding: URLEncoding.default)
    }
    var headers: [String : String]? {
        ["Content-Type": "application/json;charset=utf-8"]
    }
}
