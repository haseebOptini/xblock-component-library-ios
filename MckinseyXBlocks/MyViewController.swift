//
//  MyViewController.swift
//  MckinseyXBlocks
//
//  Created by Shafqat Muneer on 8/18/17.
//  Copyright © 2017 Salman Jamil. All rights reserved.
//

import UIKit

public class MyViewController: UIViewController {

    @IBOutlet weak var cellView: UIView!
    override public func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //cellView.addShadow()
        
        
        let topBorder: CALayer = CALayer()
        topBorder.frame = CGRect(x: 0, y: 0, width: cellView.frame.size.width, height: 1) //CGRect(0.0, 0.0, cellView.frame.size.width, 3.0)
        topBorder.backgroundColor = UIColor(red: 247/255, green: 192/255, blue: 202/255, alpha: 1.0).cgColor
        cellView.layer.addSublayer(topBorder)
        
        
        
        let bottomBorder: CALayer = CALayer()
        bottomBorder.frame = CGRect(x: 0, y: cellView.frame.size.height - 1, width: cellView.frame.size.width, height: 1) //CGRect(0.0, 0.0, cellView.frame.size.width, 3.0)
        bottomBorder.backgroundColor = UIColor(red: 247/255, green: 192/255, blue: 202/255, alpha: 1.0).cgColor
        cellView.layer.addSublayer(bottomBorder)

        
        
        cellView.backgroundColor = UIColor(red: 246/255, green: 224/255, blue: 228/255, alpha: 1.0)
        
//        let layer = cellView.layer
        
//        layer.shadowColor = UIColor.black.cgColor
//        layer.shadowOffset = CGSize(width: 10, height: 10)
//        layer.shadowOpacity = 0.4
//        layer.shadowRadius = 1
        
//        applyMyShadow(view: cellView)
//        applyHoverShadow(view: cellView)
    }
    
    func applyMyShadow(view: UIView) {
        let radius = CGFloat(3)
        let cornerRadius = CGFloat(5)
        
        let layer = view.layer
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowRadius = radius
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.cornerRadius = cornerRadius
    }
    
    func applyCurvedShadow(view: UIView) {
        let size = view.bounds.size
        let width = size.width
        let height = size.height
        let depth = CGFloat(11.0)
        let lessDepth = 0.8 * depth
        let curvyness = CGFloat(5)
        let radius = CGFloat(1)
        
        let path = UIBezierPath()
        
        // top left
        path.move(to: CGPoint(x: radius, y: height))
        
        // top right
        path.addLine(to: CGPoint(x: width - 2*radius, y: height))
        
        // bottom right + a little extra
        path.addLine(to: CGPoint(x: width - 2*radius, y: height + depth))
        
        // path to bottom left via curve
        path.addCurve(to: CGPoint(x: radius, y: height + depth),
                             controlPoint1: CGPoint(x: width - curvyness, y: height + lessDepth - curvyness),
                             controlPoint2: CGPoint(x: curvyness, y: height + lessDepth - curvyness))
        
        let layer = view.layer
        layer.shadowPath = path.cgPath
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowRadius = radius
        layer.shadowOffset = CGSize(width: 0, height: -3)
    }
    
    func applyHoverShadow(view: UIView) {
        let size = view.bounds.size
        let width = size.width
        let height = size.height
        
        let ovalRect = CGRect(x: 5, y: height + 5, width: width - 10, height: 15)
        let path = UIBezierPath(roundedRect: ovalRect, cornerRadius: 10)
        
        let layer = view.layer
        layer.shadowPath = path.cgPath
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 0)
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
