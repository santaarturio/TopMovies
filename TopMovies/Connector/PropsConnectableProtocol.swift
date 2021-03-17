//
//  PropsConnectableProtocol.swift
//  TopMovies
//
//  Created by anikolaenko on 12.02.2021.
//

protocol PropsConnectable {
  associatedtype Props
  associatedtype Provider: StoreProviderProtocol
  
  typealias Connector = BaseConnector<Props, Provider>
  var propsConnector: Connector? { get set }
  
  func configureConnectionWith(connector: Connector)
  func connect(props: Props)
}
