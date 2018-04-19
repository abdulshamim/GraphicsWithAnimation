//
//  AnimationsViewController.swift
//  Graphics
//
//  Created by cl-macmini-23 on 19/04/18.
//  Copyright © 2018 Abdul Shamim. All rights reserved.
//

import UIKit

class AnimationsViewController: UIViewController {
    
    @IBOutlet weak var yellowView: UIView!
    var rect: CGRect!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        self.yellowView.transform = CGAffineTransform(scaleX: 0, y: 0)
        self.rect = CGRect(x: self.view.center.x - 75, y: view.center.y - 75, width: 150, height: 150)
        
        self.makeRoundCornerView(yellowView)
    }
    
    @IBAction func animateView(_ sender: UIButton) {
        self.caBasicAnimation()
    }
    
    private func makeRoundCornerView(_ targetView: UIView) {
        targetView.layer.cornerRadius = targetView.bounds.size.width / 2
        targetView.layer.masksToBounds = true
    }
    
    // MARK : Animation
    func animateYellowView() {
        self.yellowView.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
            self.yellowView.transform = .identity
        }) { (success) in
            if success {
                print("Animation done")
            }
        }
    }
    
    // MARK : Animation using damping
    func animateViewWithDamping() {
        self.yellowView.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.yellowView.transform = .identity
        }, completion: nil)
    }
    
    // MARK : Animation using key frames
    func animateViewWithKeyFrames() {
        self.yellowView.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: .calculationModeCubic, animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                self.yellowView.transform = .identity
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                self.yellowView.transform = CGAffineTransform(scaleX: 0, y: 0)
            })
            
        }, completion: nil)
    }
    
    // MARK : Basic animation in CA
    func caBasicAnimation() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.timingFunction = CAMediaTimingFunction(controlPoints: 5/6, 0.2, 2/6, 0.9)
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 1
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        yellowView.layer.add(animation, forKey: nil)
    }
}

// MARK : Create circle using bezier path and shape layer
extension AnimationsViewController {
    func createCircleView() {
        let path = UIBezierPath(ovalIn: self.rect)
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.red.cgColor
        layer.strokeColor = UIColor.blue.cgColor
        layer.strokeStart = 0
        layer.strokeEnd = 1
        layer.lineWidth = 3
        layer.path = path.cgPath
        view.layer.addSublayer(layer)
    }
}
