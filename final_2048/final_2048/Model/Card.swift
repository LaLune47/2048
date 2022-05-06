//
//  Card.swift
//  final_2048
//
//  Created by 我柯 on 2021/11/1.
//
import Foundation

class Card {
    
    private var value: Int
    
    init(value: Int = 0) {
        self.value = value
    }
    
    func getValue() -> Int {
        return value
    }
    
    func upgrade() -> Int {
        value *= 2
        return value
    }
    
}
