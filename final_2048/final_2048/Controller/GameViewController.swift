//
//  GameViewController.swift
//  final_2048
//
//  Created by 我柯 on 2021/11/1.
//


import UIKit

class GameViewController: UIViewController, GameViewDelegate {

    private let gameSize = 4
    private lazy var game = Game(size: gameSize)
    @IBOutlet weak var gameView: GameView! {
        didSet {
            gameView.size = gameSize
            gameView.skin = ClassicSkin()
        }
    }
 
    private var maskView: UIView {
        let view = UIView()
        view.backgroundColor = .white
        view.alpha = 0.0
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.game.goal = 2048
        gameView.delegate = self
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
            self.startGame()
        }
    }
    
    private func startGame() {
        self.game.start { (startCards) in
            self.gameView.performActions(startCards)
        }
    }
    
    func slideEnded(offset: CGPoint) {
        if game.status == .ended { return }
        let direction: Direction
        if offset.y > offset.x {
            if offset.y > -offset.x {
                direction = .down
            } else {
                direction = .left
            }
        } else {
            if offset.y > -offset.x {
                direction = .right
            } else {
                direction = .up
            }
        }
        game.move(to: direction) { (actions) in
            gameView.performActions(actions)
            if let last = actions.last {
                switch last {
                case .failure:
                    showFailureView()
                    game.status = .ended
                case .success:
                    showSuccessView()
                    game.status = .ended
                default: break
                }
            }
        }
    }
    
    private func showMaskView(_ mask: UIView) {
        UIViewPropertyAnimator.runningPropertyAnimator(
            withDuration: 0.5,
            delay: 0.0,
            options: [],
            animations: {
                mask.alpha = 0.2
            }
        )
    }
    
    private func configMaskView(_ mask: inout UIView) {
        view.addSubview(mask)
        view.bringSubviewToFront(mask)
        
        mask.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mask.topAnchor.constraint(equalTo: view.topAnchor),
            mask.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mask.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mask.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ])
    }
    
    private func showSuccessView() {
        var mask = maskView
        configMaskView(&mask)
        showMaskView(mask)
    }
    
    private func showFailureView() {
        var mask = maskView
        configMaskView(&mask)
        showMaskView(mask)
    }

}
