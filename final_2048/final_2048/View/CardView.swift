//
//  CardView.swift
//  final_2048
//
//  Created by 我柯 on 2021/11/1.
//

import UIKit

class CardView: UIView {
    
    private var skin = AbstractSkin()
    private let label = UILabel()
    private var value: Int = 0 {
        didSet {
            if value == 0 {
                self.isHidden = true
            } else {
                self.isHidden = false
                let style = skin.sheet[value]!
                self.backgroundColor = style.backgroundColor
                label.text = style.content
                label.textColor = style.labelColor
            }
        }
    }

    init(frame: CGRect, value: Int, skin: AbstractSkin) {
        super.init(frame: frame)
        self.frame = frame
        self.skin = skin
        self.backgroundColor = .orange
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10.0
        set(value: value)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func set(value: Int) {
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 36.0)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        self.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5.0),
            label.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5.0)
        ])
        updateValue(to: value)

    }
    
    func updateValue(to newValue: Int) {
        value = newValue
    }
    
    func createAnimation() {
        transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1)
        UIViewPropertyAnimator.runningPropertyAnimator(
            withDuration: 0.1,
            delay: 0.0,
            options: [],
            animations: {
                self.transform = .identity
            }
        )
    }
    
    func flash(withValue value: Int = 0) {
        transform = CGAffineTransform.identity.scaledBy(x: 0.8, y: 0.8)
        updateValue(to: value)
        UIViewPropertyAnimator.runningPropertyAnimator(
            withDuration: 0.08,
            delay: 0.0,
            options: [.repeat],
            animations: {
                self.transform = CGAffineTransform.identity.scaledBy(x: 1.1, y: 1.1)
            }, completion: { position in
                self.transform = .identity
            }
        )
    }

}
