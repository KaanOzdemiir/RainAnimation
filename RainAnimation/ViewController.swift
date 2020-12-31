//
//  ViewController.swift
//  RainAnimation
//
//  Created by Kaan Ozdemir on 31.12.2020.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        imageView.isHidden = true
        
        setTimer()
        
        let curvedView = CurvedView(frame: view.frame)
        curvedView.backgroundColor = .clear
        
        view.addSubview(curvedView)
        
    }
    
    func setTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
    }

    @objc func fireTimer() {
        print("Timer fired!")
        generateViews()
    }
    
    func generateViews() {
        
        let viewCount = Int(drand48() * 10)
        
//        (0...viewCount).forEach { (_) in
            let animView = UIImageView()
        animView.image = #imageLiteral(resourceName: "dribble").withRenderingMode(.alwaysTemplate)
        animView.tintColor = .white
            
            let dimension = 34 + drand48() * 10
            animView.frame = .init(x: -50 , y: -50, width: dimension, height: dimension)
            
            let animation = CAKeyframeAnimation(keyPath: "position")
            animation.path = view.customPath().cgPath
            animation.duration = 10
            animation.fillMode = .forwards
            animation.isRemovedOnCompletion = false
//        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            
            
            animView.layer.add(animation, forKey: nil)
            view.addSubview(animView)
//        }
    }
}



class CurvedView: UIView {
    
    
    override func draw(_ rect: CGRect) {
        let path = customPath()
        
        path.lineWidth = 0
        path.stroke()
    }
}


extension UIView {
    
    func generateRandomX() -> CGFloat {
        return CGFloat(drand48()) * frame.width
    }
    
    func generateRandomY() -> CGFloat {
        return CGFloat(drand48()) * frame.height
    }
    
    func customPath() -> UIBezierPath {
        let path = UIBezierPath()
        let randomXShift1 = generateRandomX()

        path.move(to: .init(x: randomXShift1, y: 0))
        
        let endPoint = CGPoint(x: generateRandomX(), y: frame.maxY + 50)
        
        
        let randomX = generateRandomX()
        let randomY = generateRandomY()
        let cp1 = CGPoint(x: randomX, y: 200)
        let cp2 = CGPoint(x: generateRandomX() , y: 600)

        path.addCurve(to: endPoint, controlPoint1: cp1, controlPoint2: cp2)
        
        return path
    }
}
