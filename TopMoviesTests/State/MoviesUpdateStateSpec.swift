//
//  MoviesUpdateStateSpec.swift
//  TopMoviesTests
//
//  Created by Macbook Pro  on 24.03.2021.
//

@testable import TopMovies
import Quick
import Nimble

class MoviesUpdateStateSpec: QuickSpec {
  override func spec() {
    describe("MoviesUpdateStateSpec") {
      
      var state: MoviesUpdateState!
      beforeEach {
        state = .init(relational: [:])
      }
      
      context("request movie update action should be reduced") {
        it("should add or update key&value pair into relational with value .requested") {
          let action = RequestMovieUpdateAction(movieId: mockMoviePreview.id)
          state = MoviesUpdateState.reduce(action: action, state: state)
          expect(state.relational.count) == 1
          expect(state.relational[mockMoviePreview.id]?.isRequested).to(beTrue())
        }
      }
      context("downloading movie update action should be reduced") {
        it("should add or update key&value pair into relational with value .downloading") {
          let action = DownloadingMovieUpdateAction(movieId: mockMoviePreview.id)
          state = MoviesUpdateState.reduce(action: action, state: state)
          expect(state.relational.count) == 1
          expect(state.relational[mockMoviePreview.id]?.isDownloading).to(beTrue())
        }
      }
      context("completed movie update action should be reduced") {
        it("should add or update key&value pair into relational with value .isInitial") {
          let action = CompletedMovieUpdateAction(movie: mockUpdatedMovie)
          state = MoviesUpdateState.reduce(action: action, state: state)
          expect(state.relational.count) == 1
          expect(state.relational[mockMoviePreview.id]?.isInitial).to(beTrue())
        }
      }
      context("failed movie detail action should be reduced") {
        it("should add or update key&value pair into relational with value .failed(error)") {
          let mockError = MockError(description: "failed movie update error")
          let action = FailedMovieUpdateAction(movieId: mockMoviePreview.id,
                                               error: mockError)
          state = MoviesUpdateState.reduce(action: action, state: state)
          expect(state.relational.count) == 1
          let storedError = state.relational[mockMoviePreview.id]?.failed
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
