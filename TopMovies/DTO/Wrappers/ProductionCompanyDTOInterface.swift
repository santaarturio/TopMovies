//
//  ProductionCompanyDTOWrapper.swift
//  TopMovies
//
//  Created by Macbook Pro  on 03.04.2021.
//

import Foundation

struct ProductionCompanyDTOWrapper {
  var name: String 
  var logo: URL?
  
  init(name: String, logo: URL?) {
    self.name = name
    self.logo = logo
  }
}

extension ProductionCompany {
  init(dto: ProductionCompanyDTOWrapper) {
    name = dto.name
    logo = dto.logo
  }
}
