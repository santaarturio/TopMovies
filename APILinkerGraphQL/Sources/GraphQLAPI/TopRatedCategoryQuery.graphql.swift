// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class TopRatedCategoryQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query TopRatedCategory($cursor: String) {
      movies {
        __typename
        topRated(after: $cursor) {
          __typename
          ...MovieCategoryFragment
        }
      }
    }
    """

  public let operationName: String = "TopRatedCategory"

  public let operationIdentifier: String? = "de828c64d59b1aa395ef3f0d60f94c0186fb06a9539b7fa4593c0379cf277705"

  public var queryDocument: String {
    var document: String = operationDefinition
    document.append("\n" + MovieCategoryFragment.fragmentDefinition)
    document.append("\n" + MoviePreviewFragment.fragmentDefinition)
    return document
  }

  public var cursor: String?

  public init(cursor: String? = nil) {
    self.cursor = cursor
  }

  public var variables: GraphQLMap? {
    return ["cursor": cursor]
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
          GraphQLField("topRated", arguments: ["after": GraphQLVariable("cursor")], type: .nonNull(.object(TopRated.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(topRated: TopRated) {
        self.init(unsafeResultMap: ["__typename": "Movies", "topRated": topRated.resultMap])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var topRated: TopRated {
        get {
          return TopRated(unsafeResultMap: resultMap["topRated"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "topRated")
        }
      }

      public struct TopRated: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["MovieConnection"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("edges", type: .list(.object(Edge.selections))),
            GraphQLField("pageInfo", type: .nonNull(.object(PageInfo.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(edges: [Edge?]? = nil, pageInfo: PageInfo) {
          self.init(unsafeResultMap: ["__typename": "MovieConnection", "edges": edges.flatMap { (value: [Edge?]) -> [ResultMap?] in value.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } } }, "pageInfo": pageInfo.resultMap])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var edges: [Edge?]? {
          get {
            return (resultMap["edges"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Edge?] in value.map { (value: ResultMap?) -> Edge? in value.flatMap { (value: ResultMap) -> Edge in Edge(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Edge?]) -> [ResultMap?] in value.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } } }, forKey: "edges")
          }
        }

        public var pageInfo: PageInfo {
          get {
            return PageInfo(unsafeResultMap: resultMap["pageInfo"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "pageInfo")
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

          public var movieCategoryFragment: MovieCategoryFragment {
            get {
              return MovieCategoryFragment(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
        }

        public struct Edge: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["MovieEdge"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("cursor", type: .nonNull(.scalar(String.self))),
              GraphQLField("node", type: .object(Node.selections)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(cursor: String, node: Node? = nil) {
            self.init(unsafeResultMap: ["__typename": "MovieEdge", "cursor": cursor, "node": node.flatMap { (value: Node) -> ResultMap in value.resultMap }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var cursor: String {
            get {
              return resultMap["cursor"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "cursor")
            }
          }

          public var node: Node? {
            get {
              return (resultMap["node"] as? ResultMap).flatMap { Node(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "node")
            }
          }

          public struct Node: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["DetailedMovie", "Movie", "MovieResult"]

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
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public static func makeDetailedMovie(id: Int, title: String, overview: String, poster: String? = nil, backdrop: String? = nil, isAdult: Bool, releaseDate: String? = nil, rating: Double) -> Node {
              return Node(unsafeResultMap: ["__typename": "DetailedMovie", "id": id, "title": title, "overview": overview, "poster": poster, "backdrop": backdrop, "isAdult": isAdult, "releaseDate": releaseDate, "rating": rating])
            }

            public static func makeMovie(id: Int, title: String, overview: String, poster: String? = nil, backdrop: String? = nil, isAdult: Bool, releaseDate: String? = nil, rating: Double) -> Node {
              return Node(unsafeResultMap: ["__typename": "Movie", "id": id, "title": title, "overview": overview, "poster": poster, "backdrop": backdrop, "isAdult": isAdult, "releaseDate": releaseDate, "rating": rating])
            }

            public static func makeMovieResult(id: Int, title: String, overview: String, poster: String? = nil, backdrop: String? = nil, isAdult: Bool, releaseDate: String? = nil, rating: Double) -> Node {
              return Node(unsafeResultMap: ["__typename": "MovieResult", "id": id, "title": title, "overview": overview, "poster": poster, "backdrop": backdrop, "isAdult": isAdult, "releaseDate": releaseDate, "rating": rating])
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

              public var moviePreviewFragment: MoviePreviewFragment {
                get {
                  return MoviePreviewFragment(unsafeResultMap: resultMap)
                }
                set {
                  resultMap += newValue.resultMap
                }
              }
            }
          }
        }

        public struct PageInfo: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["PageInfo"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("hasNextPage", type: .nonNull(.scalar(Bool.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(hasNextPage: Bool) {
            self.init(unsafeResultMap: ["__typename": "PageInfo", "hasNextPage": hasNextPage])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var hasNextPage: Bool {
            get {
              return resultMap["hasNextPage"]! as! Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "hasNextPage")
            }
          }
        }
      }
    }
  }
}
