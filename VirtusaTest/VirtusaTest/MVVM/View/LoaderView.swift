//
//  LoaderView.swift
//  VirtusaTest
//
//  Created by Virat on 10/12/23.
//

import UIKit


class LoaderView: UIView {
    
    static var loader = LoaderView()
    static var activityIndicator = UIActivityIndicatorView()
    
    //MARK:- View Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        LoaderView.activityIndicator.style =  .large
        LoaderView.activityIndicator.startAnimating()
        let label = UILabel.init(frame: CGRect(x: 5, y: 70, width: 90, height: 20))
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        label.textAlignment = NSTextAlignment.center
        label.text = "Please wait...."
        
        let myView = UIView()
        myView.frame = CGRect(x: (UIScreen.main.bounds.size.width - 100)/2, y: (UIScreen.main.bounds.size.height/2) - 110, width: 100, height: 110)
        myView.backgroundColor = UIColor.init(white: 0.0, alpha: 0.5)
        myView.layer.cornerRadius = 4
        LoaderView.activityIndicator.center = CGPoint(x: myView.frame.size.width/2, y:  myView.frame.size.height/2 - 10)
        myView.addSubview(LoaderView.activityIndicator)
        myView.addSubview(label)
        
        self.addSubview(myView)
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
    }
    
    public static func addOn(View view : UIView) {
        if !view.subviews.contains(loader) {
            loader = LoaderView.init(frame: view.frame)
            view.addSubview(loader)
        }
    }
    
    public static func hide() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.loader.removeFromSuperview()
        }
    }
}
