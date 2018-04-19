//
//  ViewController.swift
//  Graphics
//
//  Created by Abdul Shamim on 4/18/18.
//  Copyright © 2018 Abdul Shamim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let keyPathToAnimate = "transform.scale"
   
    let (x1, y1) = (0.25, 0.2)
    let (x2, y2) = (0.66, 1.5)
   
    var controlPoints: [CGPoint] = []

    var bounds:CGRect = CGRect(x: 0, y: 0, width: 375, height: 667)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.controlPoints = [CGPoint(x: x1, y: y1), CGPoint(x: x2, y: y2)]
        self.addCurveView()
    }
    

    func addCurveView() {
        let size: CGFloat = 200
        let curveView = CurveView(controlPoints: controlPoints)
        curveView.backgroundColor = .clear
        
        curveView.frame = CGRect(x: 0, y: bounds.midY - size / 2, width: size, height: size)
        curveView.controlPoints = controlPoints
        self.view.addSubview(curveView)
    }
}

class CurveView: UIView {
    var controlPoints: [CGPoint] = []
    var viewBounds:CGRect = CGRect(x: 0, y: 0, width: 375, height: 667)
    
    convenience  init(controlPoints: [CGPoint]) {
        self.init()
        self.controlPoints = controlPoints
    }
    
    override func draw(_ rect: CGRect) {
        let frame = bounds.insetBy(dx: (bounds.midX)/2, dy: bounds.midY/2)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.addRect(frame)
        context.setStrokeColor(#colorLiteral(red: 0.2078431372549019, green: 0.2274509803921569, blue: 0.2509803921568627, alpha: 0.5).cgColor)
        context.strokePath()
        context.move(to: CGPoint(x: frame.minX, y: frame.maxY))
        context.addCurve(to: CGPoint(x: frame.maxX, y:frame.minY),
                         control1: CGPoint(x: frame.minX + controlPoints[0].x * frame.width, y: frame.maxY - controlPoints[0].y * frame.height),
                         control2: CGPoint(x: frame.minX + controlPoints[1].x * frame.width, y: frame.maxY - controlPoints[1].y * frame.height))
        
        context.setStrokeColor(#colorLiteral(red: 0.2078431372549019, green: 0.2274509803921569, blue: 0.2509803921568627, alpha: 1).cgColor)
        context.strokePath()
    }
}







