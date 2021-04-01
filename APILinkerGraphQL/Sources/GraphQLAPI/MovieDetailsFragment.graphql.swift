// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public struct MovieDetailsFragment: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment MovieDetailsFragment on DetailedMovie {
      __typename
      id
      title
      overview
      poster(size: W780)
      backdrop(size: W780)
      isAdult
      releaseDate
      rating
      budget
      runtime
      tagline
      status
      genres {
        __typename
        name
      }
      productionCompanies {
        __typename
        name
        logo(size: W500)
      }
    }
    """

  public static let possibleTypes: [String] = ["DetailedMovie"]

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
      GraphQLField("budget", type: .scalar(Int.self)),
      GraphQLField("runtime", type: .nonNull(.scalar(Int.self))),
      GraphQLField("tagline", type: .nonNull(.scalar(String.self))),
      GraphQLField("status", type: .nonNull(.scalar(Status.self))),
      GraphQLField("genres", type: .nonNull(.list(.nonNull(.object(Genre.selections))))),
      GraphQLField("productionCompanies", type: .nonNull(.list(.nonNull(.object(ProductionCompany.selections))))),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: Int, title: String, overview: String, poster: String? = nil, backdrop: String? = nil, isAdult: Bool, releaseDate: String? = nil, rating: Double, budget: Int? = nil, runtime: Int, tagline: String, status: Status, genres: [Genre], productionCompanies: [ProductionCompany]) {
    self.init(unsafeResultMap: ["__typename": "DetailedMovie", "id": id, "title": title, "overview": overview, "poster": poster, "backdrop": backdrop, "isAdult": isAdult, "releaseDate": releaseDate, "rating": rating, "budget": budget, "runtime": runtime, "tagline": tagline, "status": status, "genres": genres.map { (value: Genre) -> ResultMap in value.resultMap }, "productionCompanies": productionCompanies.map { (value: ProductionCompany) -> ResultMap in value.resultMap }])
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

  public var budget: Int? {
    get {
      return resultMap["budget"] as? Int
    }
    set {
      resultMap.updateValue(newValue, forKey: "budget")
    }
  }

  public var runtime: Int {
    get {
      return resultMap["runtime"]! as! Int
    }
    set {
      resultMap.updateValue(newValue, forKey: "runtime")
    }
  }

  public var tagline: String {
    get {
      return resultMap["tagline"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "tagline")
    }
  }

  public var status: Status {
    get {
      return resultMap["status"]! as! Status
    }
    set {
      resultMap.updateValue(newValue, forKey: "status")
    }
  }

  public var genres: [Genre] {
    get {
      return (resultMap["genres"] as! [ResultMap]).map { (value: ResultMap) -> Genre in Genre(unsafeResultMap: value) }
    }
    set {
      resultMap.updateValue(newValue.map { (value: Genre) -> ResultMap in value.resultMap }, forKey: "genres")
    }
  }

  public var productionCompanies: [ProductionCompany] {
    get {
      return (resultMap["productionCompanies"] as! [ResultMap]).map { (value: ResultMap) -> ProductionCompany in ProductionCompany(unsafeResultMap: value) }
    }
    set {
      resultMap.updateValue(newValue.map { (value: ProductionCompany) -> ResultMap in value.resultMap }, forKey: "productionCompanies")
    }
  }

  public struct Genre: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Genre"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("name", type: .nonNull(.scalar(String.self))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(name: String) {
      self.init(unsafeResultMap: ["__typename": "Genre", "name": name])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var name: String {
      get {
        return resultMap["name"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "name")
      }
    }
  }

  public struct ProductionCompany: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["ProductionCompany"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("name", type: .nonNull(.scalar(String.self))),
        GraphQLField("logo", arguments: ["size": "W500"], type: .scalar(String.self)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(name: String, logo: String? = nil) {
      self.init(unsafeResultMap: ["__typename": "ProductionCompany", "name": name, "logo": logo])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var name: String {
      get {
        return resultMap["name"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "name")
      }
    }

    public var logo: String? {
      get {
        return resultMap["logo"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "logo")
      }
    }
  }
}
