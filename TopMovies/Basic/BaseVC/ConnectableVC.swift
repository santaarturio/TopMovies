//
//  ConnectableVC.swift
//  TopMovies
//
//  Created by Macbook Pro  on 20.03.2021.
//

protocol ConnectableVC {
  associatedtype Props
  associatedtype Provider: StoreProviderProtocol
  
  typealias Connector = BaseConnector<Props, Provider>
  var propsConnector: Connector? { get }
  
  typealias PropsUpdate = (Props) -> Void
  func configureConnection(with connector: (@escaping PropsUpdate) -> Connector)
  
  func connect(props: Props)
}
