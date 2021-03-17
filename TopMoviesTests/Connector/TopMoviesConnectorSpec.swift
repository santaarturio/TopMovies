//
//  TopMoviesConnectorSpec.swift
//  TopMoviesTests
//
//  Created by anikolaenko on 17.03.2021.
//

@testable import TopMovies
import Quick
import Nimble

class TopMoviesConnectorSpec: QuickSpec {
  override func spec() {
    describe("TopMoviesConnector") {
      
      var propsArray: [TopMoviesProps] = []
      var connector: TopMoviesConnector<MockStoreProvider<MainState>>!
      var provider: MockStoreProvider<MainState>!
      
      beforeEach {
        propsArray = []
        connector = .init(updateProps: { props in propsArray.append(props) },
                          provider: MockStoreProvider<MainState>.init(onStateUpdate: ))
        provider = connector.provider
      }
      
      context("connector init") {
        it("should dispatch RequestMovieCategoriesAction()") {
          expect(provider.dispatchedActions.count) == 1
          expect(provider.dispatchedActions.first).to(beAnInstanceOf(RequestMovieCategoriesAction.self))
        }
      }
      context("props should be created") {
        it("should create 1 TopMoviesProps with 2 MovieCategoryProps inside") {
          provider.onStateUpdate(mockMainStateAllCategoriesCompleted)
          expect(propsArray.count) == 1
          expect(propsArray.first?.movieCategories.count) == 2
          expect(propsArray.first?.movieCategories.first?.categoryNameText) == mockMovieCategory.title
          expect(propsArray.first?.movieCategories.last?.categoryNameText) == mockMovieCategory2.title
          expect(propsArray.first?.movieCategories.first?.movies.first?.posterURL) == mockMovie.poster
          expect(propsArray.first?.movieCategories.last?.movies.first?.posterURL) == mockMovie2.poster
        }
      }
      context("props shouldn't be created") {
        it("should be anything inside propsArray") {
          provider.onStateUpdate(mockMainStateSomeCategoryReload) // random state
          expect(propsArray.count) == 0
        }
      }
    }
  }
}
