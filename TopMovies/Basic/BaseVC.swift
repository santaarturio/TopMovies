//
//  BaseVC.swift
//  TopMovies
//
//  Created by anikolaenko on 18.03.2021.
//

import UIKit

class BaseVC<Props, Provider: StoreProviderProtocol>: UIViewController, ConnectableVC {
  typealias Connector = BaseConnector<Props, Provider>
  private(set) var propsConnector: Connector?
  
  typealias PropsUpdate = (Props) -> Void
  func configureConnection(with connector: (@escaping PropsUpdate) -> Connector) {
    propsConnector = connector { [unowned self] props in connect(props: props) }
  }
  
  func connect(props: Props) {
    fatalError("func connect(props:) should be overriden")
  }
}
