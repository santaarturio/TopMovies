//
//  MovieVCConnectorSpec.swift
//  TopMoviesTests
//
//  Created by Macbook Pro  on 22.03.2021.
//

@testable import TopMovies
import Quick
import Nimble

class MovieVCConnectorSpec: QuickSpec {
  override func spec() {
    describe("MovieVC Connector") {
      
      var newProps: MovieVCProps?
      var connector: MovieVCConnector!
      var provider: MockStoreProvider<MainState>!
      
      beforeEach {
        newProps = nil
        connector = .init(movieId: mockMovie.id,
                          updateProps: { props in newProps = props },
                          provider: MockStoreProvider<MainState>.init(onStateUpdate: ))
        provider = connector.provider
      }
      
      context("connector init") {
        it("should dispatch RequestedMovieDetailAction()") {
          expect(provider.dispatchedActions.count) == 1
          expect(provider.dispatchedActions.first).to(beAnInstanceOf(RequestMovieDetailAction.self))
        }
      }
      context("props should be created") {
        it("should create MovieVCProps with valid properties") {
          provider.onStateUpdate(mockMainStateSomeMovieDetailCompleted)
          expect(newProps?.titleLabelText) == mockMovie.title
          expect(newProps?.posterURL) == mockMovie.poster
        }
      }
      context("props shouldn't be created") {
        it("newProps should be nil") {
          provider.onStateUpdate(mockMainStateSomeCategoryReload) // random state
          expect(newProps).to(beNil())
        }
      }
    }
  }
}
