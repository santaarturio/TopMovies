//
//  ConfigurationStateSpec.swift
//  TopMoviesTests
//
//  Created by Macbook Pro  on 09.03.2021.
//

@testable import TopMovies
import Quick
import Nimble

class ConfigurationStateSpec: QuickSpec {
  override func spec() {
    describe("Configuration state") {
      
      var state: ConfigurationState!
      beforeEach {
        state = .initial
      }
      
      context("update configuration action with key should be reduced") {
        it("should store the key") {
          let apiKey = "apiKey"
          let action = UpdateConfigurationAction.configureAPIKey(apiKey)
          state = ConfigurationState.reduce(action: action,
                                            state: state)
          expect(state == .configuredAPIKey(apiKey)).to(beTrue())
        }
      }
    }
  }
}
