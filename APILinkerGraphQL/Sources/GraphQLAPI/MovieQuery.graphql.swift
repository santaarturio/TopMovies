// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class MovieQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query Movie($id: Int!) {
      movies {
        __typename
        movie(id: $id) {
          __typename
          details {
            __typename
            ...MovieDetailsFragment
          }
        }
      }
    }
    """

  public let operationName: String = "Movie"

  public let operationIdentifier: String? = "05c50fa1438b710c197beae5ab2d8f936c11ec27969ac133f050fe81e1479c9d"

  public var queryDocument: String {
    var document: String = operationDefinition
    document.append("\n" + MovieDetailsFragment.fragmentDefinition)
    return document
  }

  public var id: Int

  public init(id: Int) {
    self.id = id
  }

  public var variables: GraphQLMap? {
    return ["id": id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("movies", type: .nonNull(.object(Movie.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(movies: Movie) {
      self.init(unsafeResultMap: ["__typename": "Query", "movies": movies.resultMap])
    }

    public var movies: Movie {
      get {
        return Movie(unsafeResultMap: resultMap["movies"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "movies")
      }
    }

    public struct Movie: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Movies"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("movie", arguments: ["id": GraphQLVariable("id")], type: .nonNull(.object(Movie.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(movie: Movie) {
        self.init(unsafeResultMap: ["__typename": "Movies", "movie": movie.resultMap])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var movie: Movie {
        get {
          return Movie(unsafeResultMap: resultMap["movie"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "movie")
        }
      }

      public struct Movie: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["DetailedMovie", "Movie", "MovieResult"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("details", type: .nonNull(.object(Detail.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public static func makeDetailedMovie(details: Detail) -> Movie {
          return Movie(unsafeResultMap: ["__typename": "DetailedMovie", "details": details.resultMap])
        }

        public static func makeMovie(details: Detail) -> Movie {
          return Movie(unsafeResultMap: ["__typename": "Movie", "details": details.resultMap])
        }

        public static func makeMovieResult(details: Detail) -> Movie {
          return Movie(unsafeResultMap: ["__typename": "MovieResult", "details": details.resultMap])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var details: Detail {
          get {
            return Detail(unsafeResultMap: resultMap["details"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "details")
          }
        }

        public struct Detail: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["DetailedMovie"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
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

          public var fragments: Fragments {
            get {
              return Fragments(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }

          public struct Fragments {
            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public var movieDetailsFragment: MovieDetailsFragment {
              get {
                return MovieDetailsFragment(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
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
      }
    }
  }
}
