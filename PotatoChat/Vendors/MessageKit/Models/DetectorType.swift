//
//  DetectorType.swift
//  MessageExample
//
//  Created by 黄中山 on 2017/11/25.
//  Copyright © 2017年 黄中山. All rights reserved.
//

import Foundation

/// 标记消息中包含什么文本类型
enum DetectorType: Hashable {
    
    case address
    case date
    case phoneNumber
    case url
    case transitInformation
    case custom(NSRegularExpression)
    
    // swiftlint:disable force_try
    static var hashtag = DetectorType.custom(try! NSRegularExpression(pattern: "#[a-zA-Z0-9]{4,}", options: []))
    static var mention = DetectorType.custom(try! NSRegularExpression(pattern: "@[a-zA-Z0-9]{4,}", options: []))
    // swiftlint:enable force_try
    
    internal var textCheckingType: NSTextCheckingResult.CheckingType {
        switch self {
        case .address: return .address
        case .date: return .date
        case .phoneNumber: return .phoneNumber
        case .url: return .link
        case .transitInformation: return .transitInformation
        case .custom: return .regularExpression
        }
    }
    
    /// Simply check if the detector type is a .custom
    public var isCustom: Bool {
        switch self {
        case .custom: return true
        default: return false
        }
    }
    
    ///The hashValue of the `DetectorType` so we can conform to `Hashable` and be sorted.
    func hash(into hasher: inout Hasher) {
        hasher.combine(toInt())
    }
    
    /// Return an 'Int' value for each `DetectorType` type so `DetectorType` can conform to `Hashable`
    private func toInt() -> Int {
        switch self {
        case .address: return 0
        case .date: return 1
        case .phoneNumber: return 2
        case .url: return 3
        case .transitInformation: return 4
        case .custom(let regex): return regex.hashValue
        }
    }
    
}
