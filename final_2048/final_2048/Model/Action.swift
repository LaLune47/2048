//
//  Action.swift
//  final_2048
//
//  Created by 我柯 on 2021/11/1.
//

import Foundation

enum Action {
    case move(from: Position, to: Position)
    case upgrade(from: Position, to: Position, newValue: Int)
    case new(at: Position, value: Int)
    case success
    case failure
}
