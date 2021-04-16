//
//  GraphQLResult+Extensions.swift
//  TopMovies
//
//  Created by Macbook Pro  on 13.04.2021.
//

import Apollo
import GraphQLAPI

extension MovieAPIGraphQL {
  struct AllApolloErrors: Swift.Error {
    let errors: [GraphQLError]?
  }
}

extension GraphQLResult {
  static func successfullResult(result: GraphQLResult) -> Result<Data, Error> {
    guard let data = result.data else {
      return .failure(MovieAPIGraphQL.AllApolloErrors(errors: result.errors))
    }
    return .success(data)
  }
}
