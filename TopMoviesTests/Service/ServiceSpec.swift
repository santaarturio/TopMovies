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
              expect(completedAction.relational) == [mockMovieCategory.id: [mockMovie.id],
                                                     mockMovieCategory2.id: [mockMovie2.id]]
              expect(completedAction.moviesRelational) == [mockMovie.id: mockMovie,
                                                           mockMovie2.id: mockMovie2]
              return { .succeeded }
            }).to(succeed())
          }
        }
        context("request some category for reload") {
          it("should dispatch 2 actions with right parameters, DownloadingMoviesListAction() and CompletedMoviesListAction() ") {
            provider.onStateUpdate(mockMainStateSomeCategoryReload)
            expect(provider.dispatchedActions.count) == 2
            expect({
              guard
                let downloadingAction = provider.dispatchedActions.first as? DownloadingMoviesListAction,
                let completedAction = provider.dispatchedActions.last as? CompletedMoviesListAction
              else { return { .failed(reason: "wrong action type")}}
              expect(downloadingAction.categoryId) == mockMovieCategory.id
              expect(downloadingAction.requestType) == .reload
              expect(completedAction.categoryId) == mockMovieCategory.id
              expect(completedAction.list) == [mockMovie]
              return { .succeeded }
            }).to(succeed())
          }
        }
        context("request some category for loadMore") {
          it("should dispatch 2 actions with right parameters, DownloadingMoviesListAction() and CompletedMoviesListAction() ") {
            provider.onStateUpdate(mockMainStateSomeCategoryLoadMore)
            expect(provider.dispatchedActions.count) == 2
            expect({
              guard
                let downloadingAction = provider.dispatchedActions.first as? DownloadingMoviesListAction,
                let completedAction = provider.dispatchedActions.last as? CompletedMoviesListAction
              else { return { .failed(reason: "wrong action type")}}
              expect(downloadingAction.categoryId) == mockMovieCategory.id
              expect(downloadingAction.requestType) == .loadMore
              expect(completedAction.categoryId) == mockMovieCategory.id
              expect(completedAction.list) == [mockMovie]
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
          it("should dispatch 2 actions with right parameters, DownloadingMoviesListAction() and FailedMoviesListAction() ") {
            provider.onStateUpdate(mockMainStateSomeCategoryReload)
            expect(provider.dispatchedActions.count) == 2
            expect({
              guard
                let downloadingAction = provider.dispatchedActions.first as? DownloadingMoviesListAction,
                let failedAction = provider.dispatchedActions.last as? FailedMoviesListAction,
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
          it("should dispatch 2 actions with right parameters, DownloadingMoviesListAction() and FailedMoviesListAction() ") {
            provider.onStateUpdate(mockMainStateSomeCategoryLoadMore)
            expect(provider.dispatchedActions.count) == 2
            expect({
              guard
                let downloadingAction = provider.dispatchedActions.first as? DownloadingMoviesListAction,
                let failedAction = provider.dispatchedActions.last as? FailedMoviesListAction,
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
      }
    }
  }
}
