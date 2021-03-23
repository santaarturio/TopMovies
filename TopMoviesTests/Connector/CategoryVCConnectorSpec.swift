//
//  CategoryVCConnectorSpec.swift
//  TopMoviesTests
//
//  Created by anikolaenko on 17.03.2021.
//

@testable import TopMovies
import Quick
import Nimble

class CategoryVCConnectorSpec: QuickSpec {
  override func spec() {
    describe("CategoryVCConnector") {
      
      var newProps: MoviesCategoryVCProps?
      var connector: CategoryVCConnector<MockStoreProvider<MainState>>!
      var provider: MockStoreProvider<MainState>!
      
      beforeEach {
        newProps = nil
        connector = .init(categoryId: mockMovieCategory.id,
                          updateProps: { props in newProps = props },
                          provider: MockStoreProvider<MainState>.init(onStateUpdate: ))
        provider = connector.provider
      }
      
      context("connector init") {
        it("should dispatch RequestedMoviesListAction()") {
          expect(provider.dispatchedActions.count) == 1
          expect(provider.dispatchedActions.first).to(beAnInstanceOf(RequestedMoviesListAction.self))
        }
      }
      context("props should be created") {
        it("should create 1 TopMoviesProps with 2 MovieCategoryProps inside") {
          provider.onStateUpdate(mockMainStateSomeCategoryCompleted)
          expect(newProps?.categoryName) == mockMovieCategory.title
          expect(newProps?.movies.first?.posterURL) == mockMovie.poster
        }
      }
      context("props shouldn't be created") {
        it("should be anything inside propsArray") {
          provider.onStateUpdate(mockMainStateSomeCategoryReload) // random state
          expect(newProps).to(beNil())
        }
      }
    }
  }
}
