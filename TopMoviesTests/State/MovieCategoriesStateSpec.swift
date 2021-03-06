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
        state = MovieCategoriesState
          .init(relational: [mockMovieCategory.id: mockMovieCategory],
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
                                                      previewsRelational: [mockMoviePreview2.id: mockMoviePreview2],
                                                      relational: [mockMovieCategory2.id : [mockMoviePreview2.id]])
          state = MovieCategoriesState.reduce(action: action,
                                              state: state)
          expect(state.relational.count == 1).to(beTrue())
          expect(state.categoriesList.completed).notTo(beNil())
          expect(state.categoriesList.completed == [mockMovieCategory2.id]).to(beTrue())
        }
      }
      
      context("failed movie categories action should be reduced") {
        it("shouldn't affect on relational and set categoriesList to .failed(error)") {
          let mockError = MockError(description: "failed movie categories action error")
          let action = FailedMovieCategoriesAction(error: mockError)
          state = MovieCategoriesState.reduce(action: action,
                                              state: state)
          expect(state.relational.count == 1
                  && state.relational[mockMovieCategory.id] == mockMovieCategory).to(beTrue())
          expect(state.categoriesList.failed).notTo(beNil())
          expect({
            guard
              let myError = state.categoriesList.failed as? MockError,
              myError.description == mockError.description
            else { return { .failed(reason: "wrong error associated value") } }
            return { .succeeded }
          }).to(succeed())
        }
      }
    }
  }
}
