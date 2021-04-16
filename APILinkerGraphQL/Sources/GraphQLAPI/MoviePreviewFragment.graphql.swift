// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public struct MoviePreviewFragment: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment MoviePreviewFragment on IMovie {
      __typename
      id
      title
      overview
      poster(size: W780)
      backdrop(size: W780)
      isAdult
      releaseDate
      rating
    }
    """

  public static let possibleTypes: [String] = ["DetailedMovie", "Movie", "MovieResult"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("id", type: .nonNull(.scalar(Int.self))),
      GraphQLField("title", type: .nonNull(.scalar(String.self))),
      GraphQLField("overview", type: .nonNull(.scalar(String.self))),
      GraphQLField("poster", arguments: ["size": "W780"], type: .scalar(String.self)),
      GraphQLField("backdrop", arguments: ["size": "W780"], type: .scalar(String.self)),
      GraphQLField("isAdult", type: .nonNull(.scalar(Bool.self))),
      GraphQLField("releaseDate", type: .scalar(String.self)),
      GraphQLField("rating", type: .nonNull(.scalar(Double.self))),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public static func makeDetailedMovie(id: Int, title: String, overview: String, poster: String? = nil, backdrop: String? = nil, isAdult: Bool, releaseDate: String? = nil, rating: Double) -> MoviePreviewFragment {
    return MoviePreviewFragment(unsafeResultMap: ["__typename": "DetailedMovie", "id": id, "title": title, "overview": overview, "poster": poster, "backdrop": backdrop, "isAdult": isAdult, "releaseDate": releaseDate, "rating": rating])
  }

  public static func makeMovie(id: Int, title: String, overview: String, poster: String? = nil, backdrop: String? = nil, isAdult: Bool, releaseDate: String? = nil, rating: Double) -> MoviePreviewFragment {
    return MoviePreviewFragment(unsafeResultMap: ["__typename": "Movie", "id": id, "title": title, "overview": overview, "poster": poster, "backdrop": backdrop, "isAdult": isAdult, "releaseDate": releaseDate, "rating": rating])
  }

  public static func makeMovieResult(id: Int, title: String, overview: String, poster: String? = nil, backdrop: String? = nil, isAdult: Bool, releaseDate: String? = nil, rating: Double) -> MoviePreviewFragment {
    return MoviePreviewFragment(unsafeResultMap: ["__typename": "MovieResult", "id": id, "title": title, "overview": overview, "poster": poster, "backdrop": backdrop, "isAdult": isAdult, "releaseDate": releaseDate, "rating": rating])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var id: Int {
    get {
      return resultMap["id"]! as! Int
    }
    set {
      resultMap.updateValue(newValue, forKey: "id")
    }
  }

  public var title: String {
    get {
      return resultMap["title"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "title")
    }
  }

  public var overview: String {
    get {
      return resultMap["overview"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "overview")
    }
  }

  public var poster: String? {
    get {
      return resultMap["poster"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "poster")
    }
  }

  public var backdrop: String? {
    get {
      return resultMap["backdrop"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "backdrop")
    }
  }

  public var isAdult: Bool {
    get {
      return resultMap["isAdult"]! as! Bool
    }
    set {
      resultMap.updateValue(newValue, forKey: "isAdult")
    }
  }

  public var releaseDate: String? {
    get {
      return resultMap["releaseDate"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "releaseDate")
    }
  }

  public var rating: Double {
    get {
      return resultMap["rating"]! as! Double
    }
    set {
      resultMap.updateValue(newValue, forKey: "rating")
    }
  }
}
