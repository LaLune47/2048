//
//  ClassicSkin.swift
//  final_2048
//
//  Created by 我柯 on 2021/11/1.
//

import UIKit

class ClassicSkin: AbstractSkin {

    override var sheet: [Int : Style] {
        return [
            2   : Style(content: "2", labelColor: .darkGray, backgroundColor: UIColor(red:0.93, green:0.89, blue:0.86, alpha:1.00)),
            4   : Style(content: "4", labelColor: .darkGray, backgroundColor: UIColor(red:0.93, green:0.88, blue:0.79, alpha:1.00)),
            8   : Style(content: "8", labelColor: .white, backgroundColor: UIColor(red:0.94, green:0.69, blue:0.51, alpha:1.00)),
            16  : Style(content: "16", labelColor: .white, backgroundColor: UIColor(red:0.91, green:0.55, blue:0.38, alpha:1.00)),
            32  : Style(content: "32", labelColor: .white, backgroundColor: UIColor(red:0.95, green:0.49, blue:0.40, alpha:1.00)),
            64  : Style(content: "64", labelColor: .white, backgroundColor: UIColor(red:0.91, green:0.36, blue:0.27, alpha:1.00)),
            128 : Style(content: "128", labelColor: .white, backgroundColor: UIColor(red:0.95, green:0.84, blue:0.47, alpha:1.00)),
            256 : Style(content: "256", labelColor: .white, backgroundColor: UIColor(red:0.94, green:0.81, blue:0.38, alpha:1.00)),
            512 : Style(content: "512", labelColor: .white, backgroundColor: UIColor(red:0.88, green:0.74, blue:0.28, alpha:1.00)),
            1024: Style(content: "1024", labelColor: .white, backgroundColor: UIColor(red:0.92, green:0.76, blue:0.24, alpha:1.00)),
            2048: Style(content: "2048", labelColor: .white, backgroundColor: UIColor(red:0.92, green:0.76, blue:0.24, alpha:1.00))
        ]
    }
    
}
