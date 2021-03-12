//
//  AppFlowStateSpec.swift
//  TopMoviesTests
//
//  Created by Macbook Pro  on 09.03.2021.
//

@testable import TopMovies
import Quick
import Nimble

class AppFlowStateSpec: QuickSpec {
  override func spec() {
    describe("App flow state") {
      
      var action: AppFlowAction!
      var state: AppFlowState!
      beforeSuite {
        state = .launching
      }
      
      context("state is .launching by default") {
        it("should be .launching") {
          expect(state) == .launching
        }
      }
      
      context("application did finish launching action should be reduced") {
        it("should set state to .foreground") {
          action = .applicationDidFinishLaunching
          state = AppFlowState.reduce(action: action,
                                      state: state)
          expect(state) == .foreground
        }
      }
      
      context("application will enter foreground action should be reduced") {
        it("should set state to .foreground") {
          action = .applicationWillEnterForeground
          state = AppFlowState.reduce(action: action,
                                      state: state)
          expect(state) == .foreground
        }
      }
      
      context("application did enter background action should be reduced") {
        it("should set state to .background") {
          action = .applicationDidEnterBackground
          state = AppFlowState.reduce(action: action,
                                      state: state)
          expect(state) == .background
        }
      }
      
      context("application will terminate action should be reduced") {
        it("should set state to .terminating") {
          action = .applicationWillTerminate
          state = AppFlowState.reduce(action: action,
                                      state: state)
          expect(state) == .terminating
        }
      }
    }
  }
}
