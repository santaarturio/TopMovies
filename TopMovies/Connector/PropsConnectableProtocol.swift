//
//  PropsConnectableProtocol.swift
//  TopMovies
//
//  Created by anikolaenko on 12.02.2021.
//

import Foundation

protocol PropsConnectable {
  associatedtype Props
  var propsConnector: BaseConnector<Props>? { get set }
  func configureConnectionWith(connector: BaseConnector<Props>)
  func connect(props: Props)
}
