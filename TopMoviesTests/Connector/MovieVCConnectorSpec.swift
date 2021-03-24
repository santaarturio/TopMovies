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
      var connector: MovieVCConnector<MockStoreProvider<MainState>>!
      var provider: MockStoreProvider<MainState>!
      
      beforeEach {
        newProps = nil
        connector = .init(movieId: mockMoviePreview.id,
                          updateProps: { props in newProps = props },
                          provider: MockStoreProvider<MainState>.init(onStateUpdate: ))
        provider = connector.provider
      }
      
      context("connector init") {
        it("should dispatch RequestMovieUpdateAction()") {
          expect(provider.dispatchedActions.count) == 1
          expect(provider.dispatchedActions.first).to(beAnInstanceOf(RequestMovieUpdateAction.self))
        }
      }
      context("props should be created") {
        it("should create MovieVCProps with valid properties") {
          provider.onStateUpdate(mockMainStateSomeMovieUpdateCompleted)
          expect(newProps).notTo(beNil())
          expect(newProps?.budgetLabelText) == mockUpdatedMovie.budget
          expect(newProps?.statusLabelText) == mockUpdatedMovie.status
          expect(newProps?.posterURL) == mockUpdatedMovie.poster
        }
      }
      context("props shouldn't be created") {
        it("newProps should be nil") {
          provider.onStateUpdate(mockMainStateSomeCategoryReload)
          expect(newProps).to(beNil())
        }
      }
    }
  }
}
