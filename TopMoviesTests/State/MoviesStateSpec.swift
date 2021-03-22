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
        state = MoviesState(detailInfo: [:],
                            relational: [mockMovie.id: mockMovie])
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
      
      context("request movie detail action should be reduced") {
        it("should add new movies key&value pair to detailInfo and shouldn't update value in the reletional") {
          let action = RequestMovieDetailAction(movieId: mockMovie.id)
          state = MoviesState.reduce(action: action, state: state)
          expect(state.relational.count) == 1
          expect(state.relational[mockMovie.id]) == mockMovie
          expect(state.detailInfo.count) == 1
          expect(state.detailInfo[mockMovie.id]) == .requested
        }
      }
      context("downloading movie detail action should be reduced") {
        it("should update value or add new movies key&value pair to detailInfo and shouldn't affect on the reletional") {
          let action = DownloadingMovieDetailAction(movieId: mockMovie.id)
          state = MoviesState.reduce(action: action, state: state)
          expect(state.relational.count) == 1
          expect(state.relational[mockMovie.id]) == mockMovie
          expect(state.detailInfo.count) == 1
          expect(state.detailInfo[mockMovie.id]) == .downloading
        }
      }
      context("completed movie detail action should be reduced") {
        it("should update value or add new movies key&value pair to detailInfo and update value in the relational") {
          let action = CompletedMovieDetailAction(movie: mockUpdatedMovie)
          state = MoviesState.reduce(action: action, state: state)
          expect(state.relational.count) == 1
          expect(state.relational[mockMovie.id]) == mockUpdatedMovie
          expect(state.detailInfo.count) == 1
          expect(state.detailInfo[mockMovie.id]) == .updated
        }
      }
      context("failed movie detail action should be reduced") {
        it("should update value or add new movies key&value pair to detailInfo and shouldn't affect on the reletional") {
          let mockError = MockError(description: "failed movie detail error")
          let action = FailedMovieDetailAction(movieId: mockMovie.id,
                                               error: mockError)
          state = MoviesState.reduce(action: action, state: state)
          expect(state.relational.count) == 1
          expect(state.relational[mockMovie.id]) == mockMovie
          expect(state.detailInfo.count) == 1
          let storedError = state.detailInfo[mockMovie.id].failed
          expect({
            guard
              let myError = storedError as? MockError,
              myError.description == mockError.description
            else { return { .failed(reason: "wrong error associated value") } }
            return { .succeeded }
          }).to(succeed())
        }
      }
    }
  }
}
