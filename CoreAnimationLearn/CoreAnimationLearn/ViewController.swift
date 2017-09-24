//
//  ViewController.swift
//  CoreAnimationLearn
//
//  Created by zhangalan on 23/09/2017.
//  Copyright © 2017 zhangalan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    var mainLayer: CALayer!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mainLayer = CALayer()
        mainLayer.backgroundColor = UIColor.blue.cgColor
        mainLayer.bounds = CGRect(x: 0.0, y: 0.0, width: 70, height: 70)
//        mainLayer.position = CGPoint(x: 55.0, y: UIScreen.main.bounds.height - 55.0)
        mainLayer.position = CGPoint(x: UIScreen.main.bounds.width - 55.0, y: UIScreen.main.bounds.height - 55.0)
        view.layer.addSublayer(mainLayer)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func keyframeAnimation(_ sender: Any) {
        let thePath = CGMutablePath()
        thePath.move(to: CGPoint(x: 55.0, y: UIScreen.main.bounds.height - 55.0))
//        thePath.addQuadCurve(to: CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height - 55.0), control: CGPoint(x: UIScreen.main.bounds.width / 4, y: UIScreen.main.bounds.height - 200));
        thePath.addCurve(to: CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height - 55.0), control1: CGPoint(x: 55.0, y: UIScreen.main.bounds.height - 300.0), control2: CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height - 300.0))
        
        thePath.addQuadCurve(to: CGPoint(x: UIScreen.main.bounds.width - 55.0, y: UIScreen.main.bounds.height - 55.0), control: CGPoint(x: UIScreen.main.bounds.width * 3 / 4, y: UIScreen.main.bounds.height - 300));
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.timingFunctions = [CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut), CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseIn)]
        animation.keyTimes = [NSNumber(value: 0.0), NSNumber(value: 0.5),NSNumber(value: 1)]
        animation.path = thePath
        animation.duration = 5.0
        mainLayer.add(animation, forKey: "position")
    }
    @IBAction func animation(_ sender: Any) {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 1.0
        animation.toValue = 0.0
        animation.duration = 1.0
        mainView.layer.add(animation, forKey: "opacity")
        mainView.layer.opacity = 0.0
    }
    @IBAction func animationGroup(_ sender: UIButton) {
        //Animation 1
        let Animi1 = CAKeyframeAnimation(keyPath: "borderWidth")
        let widthValues = [1.0, 10.0, 5.0, 30.0, 0.5, 15.0, 2.0, 50.0, 0.0]
        Animi1.values = widthValues
        Animi1.calculationMode = kCAAnimationPaced
        
        //Animation 2
        let Anima2 = CAKeyframeAnimation(keyPath: "borderColor")
        let colorValue = [UIColor.green.cgColor, UIColor.red.cgColor, UIColor.blue.cgColor]
        Anima2.values = colorValue
        Anima2.calculationMode = kCAAnimationPaced
        
        //animation group
        let group = CAAnimationGroup()
        group.animations = [Animi1, Anima2]
        group.duration = 5
        mainLayer.add(group, forKey: "BorderChanges")
    }
}

