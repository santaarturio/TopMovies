//
//  MoviesStateSpec.swift
//  TopMoviesTests
//
//  Created by Macbook Pro  on 10.03.2021.
//

@testable import TopMovies
import Quick
import Nimble

class MoviesStateSpec: QuickSpec {
  override func spec() {
    describe("movies state") {
      
      var state: MoviesState!
      beforeEach {
        state = MoviesState(relational: [mockMovie.id: mockMovie])
      }
      
      context("movies downloading action should be reduced") {
        it("should add new movies key&value pair to relational") {
          let action = MoviesDownloadingAction.completed(mockMovieCategory2, [mockMovie2])
          state = MoviesState.reduce(action: action, state: state)
          expect(state.relational.count) == 2
          expect(state.relational[mockMovie2.id]) == mockMovie2
        }
      }
      
      context("completed movies categories action should be reduced") {
        it("should add new movies key&value pair to relational") {
          let action = CompletedMovieCategoriesAction(categories: [mockMovieCategory2],
                                                      moviesRelational: [mockMovie2.id: mockMovie2],
                                                      relational: [mockMovieCategory2.id : [mockMovie2.id]])
          state = MoviesState.reduce(action: action, state: state)
          expect(state.relational.count) == 2
          expect(state.relational[mockMovie2.id]) == mockMovie2
        }
      }
      
      context("completed movies list action should be reduced") {
        it("should add new movies key&value pair to relational") {
          let action = CompletedMoviesListAction(categoryId: mockMovieCategory2.id,
                                                 requestType: .loadMore,
                                                 list: [mockMovie2],
                                                 nextPage: 2)
          state = MoviesState.reduce(action: action, state: state)
          expect(state.relational.count) == 2
          expect(state.relational[mockMovie2.id]) == mockMovie2
        }
      }
    }
  }
}
