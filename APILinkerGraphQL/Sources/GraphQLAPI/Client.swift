//
//  File.swift
//  
//
//  Created by Macbook Pro  on 08.04.2021.
//

import Foundation
import Apollo

extension ApolloClient {
  public static let `default`: ApolloClient = {
    let urlString = Bundle.module.object(forInfoDictionaryKey: "CLIENT_URL") as? String
    return ApolloClient(url: urlString.flatMap(URL.init(string:))!)
  }()
}
