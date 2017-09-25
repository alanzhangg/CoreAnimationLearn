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
	let secView :UIView = UIView(frame: CGRect(x: 20, y: 20, width: 70, height: 70))
	let backView : UIView = UIView(frame: CGRect(x: 20, y: 20, width: 70, height: 70))
	let transformView : UIView = UIView(frame: CGRect(x: 20, y: 20, width: 70, height: 70))
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
		view.addSubview(backView)
		view.addSubview(secView)
		
		secView.backgroundColor = UIColor.yellow
		backView.backgroundColor = UIColor.purple
        mainLayer = CALayer()
        mainLayer.backgroundColor = UIColor.blue.cgColor
        mainLayer.bounds = CGRect(x: 0.0, y: 0.0, width: 70, height: 70)
        mainLayer.position = CGPoint(x: UIScreen.main.bounds.width - 55.0, y: UIScreen.main.bounds.height - 55.0)
        view.layer.addSublayer(mainLayer)
		print(mainLayer.convert(CGPoint(x: 50.0, y: 50.0), to: view.layer))
		
		mainView.addSubview(transformView)
		transformView.backgroundColor = UIColor.blue
		
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	@IBAction func pauseAnimation(_ sender: Any) {
		let pausedTime = secView.layer.convertTime(CACurrentMediaTime(), from: nil)
		secView.layer.speed = 0.0
		secView.layer.timeOffset = pausedTime
	}
	@IBAction func transformAnimation(_ sender: Any) {
		var perspective = CATransform3DIdentity
		perspective.m34 = -1.0 // eyepositon
		transformView.layer.sublayerTransform = perspective
	}
	
	@IBAction func resumeAnimation(_ sender: Any) {
		let pausedTime = secView.layer.timeOffset
		secView.layer.speed = 1.0
		secView.layer.timeOffset = 0.0
		secView.layer.beginTime = 0.0
		let timeSincePause = secView.layer.convertTime(CACurrentMediaTime(), from: nil)
		secView.layer.beginTime = timeSincePause
	}
	
	@IBAction func viewTransitionAnimation(_ sender: Any) {
		let transition = CATransition()
		transition.startProgress = 0.0
		transition.endProgress = 1.0
		transition.type = kCATransitionPush
		transition.subtype = kCATransitionFromBottom
		transition.duration = 0.2
		
		secView.layer.add(transition, forKey: "transition")
		backView.layer.add(transition, forKey: "transition")
		
		secView.isHidden = true
		backView.isHidden = false
		
	}
	
	@IBAction func viewLayerCoreAnimation(_ sender: Any) {
		let newPoint = CGPoint(x: 100, y: 100)
		UIView.animate(withDuration: 1.0) {
			self.secView.layer.opacity = 0.5
			let animation = CABasicAnimation(keyPath: "position")
			animation.fromValue = NSValue(cgPoint: self.secView.layer.position)
			animation.toValue = NSValue(cgPoint: newPoint)
			animation.duration = 5.0
			self.secView.layer.add(animation, forKey: "AnimateFrame")
		}
		self.secView.layer.position = newPoint
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

