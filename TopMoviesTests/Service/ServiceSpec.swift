//
//  ServiceSpec.swift
//  TopMoviesTests
//
//  Created by anikolaenko on 11.03.2021.
//

@testable import TopMovies
import Quick
import Nimble

class ServiceSpec: QuickSpec {
  override func spec() {
    describe("Movie Service") {
      
      var service: MovieService<MockStoreProvider<MainState>>!
      var provider: MockStoreProvider<MainState>!
      
      describe("successful API response") {
        beforeEach {
          service = .init(movieAPI: MockSuccessfulMovieAPI(),
                          storeProvider: MockStoreProvider<MainState>.init(onStateUpdate: ))
          provider = service.provider
        }
        context("request all categories") {
          it("should dispatch 2 actions, DownloadingMovieCategoriesAction() with no parameters and CompletedMovieCategoriesAction() with right parameters") {
            provider.onStateUpdate(mockMainStateAllCategories)
            expect(provider.dispatchedActions.count) == 2
            expect({
              guard
                let _ = provider.dispatchedActions.first as? DownloadingMovieCategoriesAction,
                let completedAction = provider.dispatchedActions.last as? CompletedMovieCategoriesAction
              else { return { .failed(reason: "wrong action type")}}
              expect(completedAction.categories) == [mockMovieCategory,
                                                     mockMovieCategory2]
              expect(completedAction.relational) == [mockMovieCategory.id: [mockMoviePreview.id],
                                                     mockMovieCategory2.id: [mockMoviePreview2.id]]
              expect(completedAction.previewsRelational) == [mockMoviePreview.id: mockMoviePreview,
                                                             mockMoviePreview2.id: mockMoviePreview2]
              return { .succeeded }
            }).to(succeed())
          }
        }
        context("request some category for reload") {
          it("should dispatch 2 actions with right parameters, DownloadingPreviewsListAction() and CompletedPreviewsListAction() ") {
            provider.onStateUpdate(mockMainStateSomeCategoryReload)
            expect(provider.dispatchedActions.count) == 2
            expect({
              guard
                let downloadingAction = provider.dispatchedActions.first as? DownloadingPreviewsListAction,
                let completedAction = provider.dispatchedActions.last as? CompletedPreviewsListAction
              else { return { .failed(reason: "wrong action type")}}
              expect(downloadingAction.categoryId) == mockMovieCategory.id
              expect(downloadingAction.requestType) == .reload
              expect(completedAction.categoryId) == mockMovieCategory.id
              expect(completedAction.list) == [mockMoviePreview]
              return { .succeeded }
            }).to(succeed())
          }
        }
        context("request some category for loadMore") {
          it("should dispatch 2 actions with right parameters, DownloadingPreviewsListAction() and CompletedPreviewsListAction() ") {
            provider.onStateUpdate(mockMainStateSomeCategoryLoadMore)
            expect(provider.dispatchedActions.count) == 2
            expect({
              guard
                let downloadingAction = provider.dispatchedActions.first as? DownloadingPreviewsListAction,
                let completedAction = provider.dispatchedActions.last as? CompletedPreviewsListAction
              else { return { .failed(reason: "wrong action type")}}
              expect(downloadingAction.categoryId) == mockMovieCategory.id
              expect(downloadingAction.requestType) == .loadMore
              expect(completedAction.categoryId) == mockMovieCategory.id
              expect(completedAction.list) == [mockMoviePreview]
              return { .succeeded }
            }).to(succeed())
          }
        }
        context("request some movie update") {
          it("should dispatch 2 actions with right parameters, DownloadingMovieUpdateAction() and CompletedMovieUpdateAction()") {
            provider.onStateUpdate(mockMainStateSomeMovieUpdateRequested)
            expect(provider.dispatchedActions.count) == 2
            expect({
              guard
                let downloadingAction = provider.dispatchedActions.first as? DownloadingMovieUpdateAction,
                let completedAction = provider.dispatchedActions.last as? CompletedMovieUpdateAction
              else { return { .failed(reason: "wrong action type")}}
              expect(downloadingAction.movieId) == mockMoviePreview.id
              expect(completedAction.movie.id) == mockMoviePreview.id
              expect(completedAction.movie) == mockUpdatedMovie
              return { .succeeded }
            }).to(succeed())
          }
        }
      }
      
      describe("unsuccessful API response") {
        beforeEach {
          service = .init(movieAPI: MockUnsuccessfulMovieAPI(),
                          storeProvider: MockStoreProvider<MainState>.init(onStateUpdate: ))
          provider = service.provider
        }
        context("request all categories") {
          it("should dispatch 2 actions, DownloadingMovieCategoriesAction() with no parameters and FailedMovieCategoriesAction() with right parameters") {
            provider.onStateUpdate(mockMainStateAllCategories)
            expect(provider.dispatchedActions.count) == 2
            expect({
              guard
                let _ = provider.dispatchedActions.first as? DownloadingMovieCategoriesAction,
                let failedAction = provider.dispatchedActions.last as? FailedMovieCategoriesAction,
                let myError = failedAction.error as? MockError
              else { return { .failed(reason: "wrong action type")}}
              expect(myError.description) == "failed all movie categories"
              return { .succeeded }
            }).to(succeed())
          }
        }
        context("request some category for reload") {
          it("should dispatch 2 actions with right parameters, DownloadingPreviewsListAction() and FailedPreviewsListAction() ") {
            provider.onStateUpdate(mockMainStateSomeCategoryReload)
            expect(provider.dispatchedActions.count) == 2
            expect({
              guard
                let downloadingAction = provider.dispatchedActions.first as? DownloadingPreviewsListAction,
                let failedAction = provider.dispatchedActions.last as? FailedPreviewsListAction,
                let myError = failedAction.error as? MockError
              else { return { .failed(reason: "wrong action type")}}
              expect(downloadingAction.categoryId) == mockMovieCategory.id
              expect(downloadingAction.requestType) == .reload
              expect(failedAction.categoryId) == mockMovieCategory.id
              expect(failedAction.requestType) == .reload
              expect(myError.description) == "failed movie category"
              return { .succeeded }
            }).to(succeed())
          }
        }
        context("request some category for loadMore") {
          it("should dispatch 2 actions with right parameters, DownloadingPreviewsListAction() and FailedPreviewsListAction() ") {
            provider.onStateUpdate(mockMainStateSomeCategoryLoadMore)
            expect(provider.dispatchedActions.count) == 2
            expect({
              guard
                let downloadingAction = provider.dispatchedActions.first as? DownloadingPreviewsListAction,
                let failedAction = provider.dispatchedActions.last as? FailedPreviewsListAction,
                let myError = failedAction.error as? MockError
              else { return { .failed(reason: "wrong action type")}}
              expect(downloadingAction.categoryId) == mockMovieCategory.id
              expect(downloadingAction.requestType) == .loadMore
              expect(failedAction.categoryId) == mockMovieCategory.id
              expect(failedAction.requestType) == .loadMore
              expect(myError.description) == "failed movie category"
              return { .succeeded }
            }).to(succeed())
          }
        }
        context("request some movie detail") {
          it("should dispatch 2 actions with right parameters, DownloadingMovieUpdateAction() and FailedMovieUpdateAction()") {
            provider.onStateUpdate(mockMainStateSomeMovieUpdateRequested)
            expect(provider.dispatchedActions.count) == 2
            expect({
              guard
                let downloadingAction = provider.dispatchedActions.first as? DownloadingMovieUpdateAction,
                let failedAction = provider.dispatchedActions.last as? FailedMovieUpdateAction,
                let myError = failedAction.error as? MockError
              else { return { .failed(reason: "wrong action type")}}
              expect(downloadingAction.movieId) == mockMoviePreview.id
              expect(failedAction.movieId) == mockMoviePreview.id
              expect(myError.description) == "failed movie update"
              return { .succeeded }
            }).to(succeed())
          }
        }
      }
    }
  }
}
