//
//  ErrorType.swift
//  TestCit
//
//  Created by Vitor Costa on 25/09/25.
//


import Foundation

enum ErrorType {
    case post(message: String)
    case comment(message: String)
    
    var type: CaseType {
        switch self {
        case .post: return .post
        case .comment: return .comment
        }
    }
    
    var message: String {
        switch self {
        case .post(let msg): return msg
        case .comment(let msg): return msg
        }
    }
}
