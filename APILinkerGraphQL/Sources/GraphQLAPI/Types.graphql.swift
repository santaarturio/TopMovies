// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public enum Status: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  case rumored
  case released
  case inProduction
  case cancelled
  case planned
  case postProduction
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "Rumored": self = .rumored
      case "Released": self = .released
      case "InProduction": self = .inProduction
      case "Cancelled": self = .cancelled
      case "Planned": self = .planned
      case "PostProduction": self = .postProduction
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .rumored: return "Rumored"
      case .released: return "Released"
      case .inProduction: return "InProduction"
      case .cancelled: return "Cancelled"
      case .planned: return "Planned"
      case .postProduction: return "PostProduction"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: Status, rhs: Status) -> Bool {
    switch (lhs, rhs) {
      case (.rumored, .rumored): return true
      case (.released, .released): return true
      case (.inProduction, .inProduction): return true
      case (.cancelled, .cancelled): return true
      case (.planned, .planned): return true
      case (.postProduction, .postProduction): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [Status] {
    return [
      .rumored,
      .released,
      .inProduction,
      .cancelled,
      .planned,
      .postProduction,
    ]
  }
}
