//
//  CategoriesPaginationStateSpec.swift
//  TopMoviesTests
//
//  Created by Macbook Pro  on 10.03.2021.
//

@testable import TopMovies
import Quick
import Nimble

class CategoriesPaginationStateSpec: QuickSpec {
  override func spec() {
    describe("categories pagination state") {
      
      var state: CategoriesPaginationState!
      beforeEach {
        state = CategoriesPaginationState
          .init(paginated: [mockMovieCategory.id: .init(list: [mockMoviePreview.id],
                                                        reload: .initial,
                                                        loadMore: .initial,
                                                        pageInfo: .next(2))])
      }
      
      context("completed movie categories action should be reduced") {
        it("should replace 1 item in the state.paginated") {
          let action = CompletedMovieCategoriesAction(categories: [mockMovieCategory2],
                                                      previewsRelational: [mockMoviePreview2.id: mockMoviePreview2],
                                                      relational: [mockMovieCategory2.id: [mockMoviePreview2.id]])
          state = CategoriesPaginationState.reduce(action: action,
                                                   state: state)
          expect(state.paginated.count) == 1
          expect(state.paginated[mockMovieCategory2.id]?.list) == [mockMoviePreview2.id]
        }
      }
      
      context("requested movies list action should be reduced") {
        it("should add 1 item to the state.paginated and make it CategoryState.reload .requested") {
          let action = RequestedPreviewsListAction(categoryId: mockMovieCategory2.id,
                                                   requestType: .reload)
          state = CategoriesPaginationState.reduce(action: action,
                                                   state: state)
          expect(state.paginated.count) == 2
          expect(state.paginated[mockMovieCategory2.id]?.reload.isRequested).to(beTrue())
        }
        it("makes CategoryState.loadMore .requested, it shouldn't affect at paginated count") {
          let action = RequestedPreviewsListAction(categoryId: mockMovieCategory.id,
                                                   requestType: .loadMore)
          state = CategoriesPaginationState.reduce(action: action,
                                                   state: state)
          expect(state.paginated.count) == 1
          expect(state.paginated[mockMovieCategory.id]?.loadMore.isRequested).to(beTrue())
        }
      }
      
      context("downloading movie categories action should be reduced") {
        it("shouldn't affect at paginated count and should make CategoryState.reload .downloading") {
          let action = DownloadingPreviewsListAction(categoryId: mockMovieCategory.id,
                                                     requestType: .reload)
          state = CategoriesPaginationState.reduce(action: action,
                                                   state: state)
          expect(state.paginated.count) == 1
          expect(state.paginated[mockMovieCategory.id]?.reload.isDownloading).to(beTrue())
        }
        it("shouldn't affect at paginated count and should make CategoryState.loadMore .downloading") {
          let action = DownloadingPreviewsListAction(categoryId: mockMovieCategory.id,
                                                     requestType: .loadMore)
          state = CategoriesPaginationState.reduce(action: action,
                                                   state: state)
          expect(state.paginated.count) == 1
          expect(state.paginated[mockMovieCategory.id]?.loadMore.isDownloading).to(beTrue())
        }
      }
      
      context("completed movies list action should be reduced") {
        it("should replace list, store nextPage and make CategoryState.reload .initial") {
          let action = CompletedPreviewsListAction(categoryId: mockMovieCategory.id,
                                                   requestType: .reload,
                                                   list: [mockMoviePreview],
                                                   nextPage: 2)
          state = CategoriesPaginationState.reduce(action: action,
                                                   state: state)
          expect(state.paginated.count) == 1
          expect(state.paginated[mockMovieCategory.id]?.list) == [mockMoviePreview.id]
          expect({
            guard
              case let .next(page) = state.paginated[mockMovieCategory.id]?.pageInfo,
              page == 2
            else { return { .failed(reason: "wrong enum case") }}
            return { .succeeded }
          }).to(succeed())
          expect(state.paginated[mockMovieCategory.id]?.reload.isInitial).to(beTrue())
        }
        it("should add new movie to list, set pageState to .lastPage and make CategoryState.loadMore .initial") {
          let action = CompletedPreviewsListAction(categoryId: mockMovieCategory.id,
                                                   requestType: .loadMore,
                                                   list: [mockMoviePreview2],
                                                   nextPage: nil)
          state = CategoriesPaginationState.reduce(action: action,
                                                   state: state)
          expect(state.paginated.count) == 1
          expect(state.paginated[mockMovieCategory.id]?.list) == [mockMoviePreview.id, mockMoviePreview2.id]
          expect({
            guard case .lastPage = state.paginated[mockMovieCategory.id]?.pageInfo
            else { return { .failed(reason: "wrong enum case") }}
            return { .succeeded }
          }).to(succeed())
          expect(state.paginated[mockMovieCategory.id]?.loadMore.isInitial).to(beTrue())
        }
      }
      
      context("failed movies list action should be reduced") {
        it("shouldn't affect at paginated count and should make CategoryState.reload .failed(error)") {
          let mockError = MockError(description: "failed movies list error")
          let action = FailedPreviewsListAction(categoryId: mockMovieCategory.id,
                                                requestType: .reload,
                                                error: mockError)
          state = CategoriesPaginationState.reduce(action: action,
                                                   state: state)
          let storedError = state.paginated[mockMovieCategory.id]?.reload.failed
          expect(state.paginated.count) == 1
          expect(state.paginated[mockMovieCategory.id]?.list) == [mockMoviePreview.id]
          expect(storedError).notTo(beNil())
          expect({
            guard
              let myError = storedError as? MockError,
              myError.description == mockError.description
            else { return { .failed(reason: "wrong error associated value") } }
            return { .succeeded }
          }).to(succeed())
        }
        it("shouldn't affect at paginated count and should make CategoryState.loadMore .failed(error)") {
          let mockError = MockError(description: "failed movies list error")
          let action = FailedPreviewsListAction(categoryId: mockMovieCategory.id,
                                                requestType: .loadMore,
                                                error: mockError)
          state = CategoriesPaginationState.reduce(action: action,
                                                   state: state)
          let storedError = state.paginated[mockMovieCategory.id]?.loadMore.failed
          expect(state.paginated.count) == 1
          expect(state.paginated[mockMovieCategory.id]?.list) == [mockMoviePreview.id]
          expect(storedError).notTo(beNil())
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
