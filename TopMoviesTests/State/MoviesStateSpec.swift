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
        state = MoviesState(previewsRelational: [mockMoviePreview.id: mockMoviePreview],
                            moviesRelational: [:])
      }
      
      context("completed movies categories action should be reduced") {
        it("should add new movies key&value pair to previewsRelational") {
          let action = CompletedMovieCategoriesAction(categories: [mockMovieCategory2],
                                                      previewsRelational: [mockMoviePreview2.id: mockMoviePreview2],
                                                      relational: [mockMovieCategory2.id : [mockMoviePreview2.id]])
          state = MoviesState.reduce(action: action, state: state)
          expect(state.previewsRelational.count) == 2
          expect(state.previewsRelational[mockMoviePreview2.id]) == mockMoviePreview2
        }
      }
      
      context("completed movies list action should be reduced") {
        it("should add new movies key&value pair to previewsRelational") {
          let action = CompletedPreviewsListAction(categoryId: mockMovieCategory2.id,
                                                   requestType: .loadMore,
                                                   list: [mockMoviePreview2],
                                                   nextPage: 2)
          state = MoviesState.reduce(action: action, state: state)
          expect(state.previewsRelational.count) == 2
          expect(state.previewsRelational[mockMoviePreview2.id]) == mockMoviePreview2
        }
      }
      
      context("completed movie update action should be reduced") {
        it("should update or add new movie to moviesRelational and update value in the previewsRelational") {
          let action = CompletedMovieUpdateAction(movie: mockUpdatedMovie)
          state = MoviesState.reduce(action: action, state: state)
          expect(state.previewsRelational.count) == 1
          expect(state.moviesRelational.count) == 1
          expect(state.previewsRelational[mockMoviePreview.id]?.id) == mockUpdatedMovie.id
          expect(state.previewsRelational[mockMoviePreview.id]?.releaseDate) == mockUpdatedMovie.releaseDate
          expect(state.previewsRelational[mockMoviePreview.id]?.poster) == mockUpdatedMovie.poster
        }
      }
    }
  }
}
