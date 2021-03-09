//
//  MovieCategoriesStateSpec.swift
//  TopMoviesTests
//
//  Created by Macbook Pro  on 09.03.2021.
//

@testable import TopMovies
import Quick
import Nimble

class MovieCategoriesStateSpec: QuickSpec {
  override func spec() {
    describe("Movie categories state") {
      
      var state: MovieCategoriesState!
      beforeEach {
        state = .init(relational: [mockMovieCategory.id: mockMovieCategory],
                      categoriesList: .initial)
      }
      
      context("request movie categories action should be reduced") {
        it("shouldn't affect on relational and set categoriesList to .requested") {
          let action = RequestMovieCategoriesAction()
          state = MovieCategoriesState.reduce(action: action,
                                              state: state)
          expect(state.relational.count == 1
                  && state.relational[mockMovieCategory.id] == mockMovieCategory).to(beTrue())
          expect(state.categoriesList.isRequested).to(beTrue())
        }
      }
      
      context("downloading movie categories action should be reduced") {
        it("shouldn't affect on relational and set categoriesList to .downloading") {
          let action = DownloadingMovieCategoriesAction()
          state = MovieCategoriesState.reduce(action: action,
                                              state: state)
          expect(state.relational.count == 1
                  && state.relational[mockMovieCategory.id] == mockMovieCategory).to(beTrue())
          expect(state.categoriesList.isDownloading).to(beTrue())
        }
      }
      
      context("completed movie categories action should be reduced") {
        it("should replace 1 item in the relational and set categoriesList to .completed([mockMovieCategory2.id])") {
          let action = CompletedMovieCategoriesAction(categories: [mockMovieCategory2],
                                                      moviesRelational: [mockMovie2.id: mockMovie2],
                                                      relational: [mockMovieCategory2.id : [mockMovie2.id]])
          state = MovieCategoriesState.reduce(action: action,
                                              state: state)
          expect(state.relational.count == 1).to(beTrue())
          expect({
            guard case let .completed(kategoriesIdArray) = state.categoriesList
            else { return { .failed(reason: "wrong enum case") } }
            if [mockMovieCategory2.id] != kategoriesIdArray {
              return { .failed(reason: "wrong associated value")}
            }
            return { .succeeded }
          }).to(succeed())
        }
      }
      
      context("failed movie categories action should be reduced") {
        it("shouldn't affect on relational and set categoriesList to .failed(error)") {
          let error = MockError(description: "failed movie categories action error")
          let action = FailedMovieCategoriesAction(error: error)
          state = MovieCategoriesState.reduce(action: action,
                                              state: state)
          expect(state.relational.count == 1
                  && state.relational[mockMovieCategory.id] == mockMovieCategory).to(beTrue())
          expect({
            guard case let .failed(error) = state.categoriesList
            else { return { .failed(reason: "wrong enum case") } }
            guard
              let myError = error as? MockError,
              myError.description == "failed movie categories action error"
            else { return { .failed(reason: "wrong error associated value") } }
            return { .succeeded }
          }).to(succeed())
        }
      }
    }
  }
}
