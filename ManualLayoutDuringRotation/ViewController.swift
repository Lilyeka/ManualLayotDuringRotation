//
//  ViewController.swift
//  ManualLayoutDuringRotation
//
//  Created by Лилия Левина on 01/07/2019.
//  Copyright © 2019 Лилия Левина. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var greenView : UIView!
    
    var statusBarHide = false
    override var prefersStatusBarHidden: Bool {
        return self.statusBarHide
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .brown
        
        self.greenView = UIView()
        self.greenView.backgroundColor = .green
        self.view.addSubview(self.greenView)
        
        let hideStatusBarButton = UIButton()
        hideStatusBarButton.setTitle("Show/hide status bar", for: .normal)
        hideStatusBarButton.backgroundColor = .red
        hideStatusBarButton.addTarget(self, action: #selector(hideStatusBarAction), for: .touchUpInside)
        hideStatusBarButton.sizeToFit()
        self.view.addSubview(hideStatusBarButton)
        hideStatusBarButton.translatesAutoresizingMaskIntoConstraints = false

        hideStatusBarButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
         hideStatusBarButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true     
    }
    
    @objc func hideStatusBarAction(_ sender:UIButton) {
        self.statusBarHide.toggle()
        UIView.animate(withDuration: 0.4) {
            self.setNeedsStatusBarAppearanceUpdate()
            self.view.layoutIfNeeded()
        }
    }
        
    override func viewWillLayoutSubviews() {
        func greenViewShouldAppear() -> Bool {
            let tc = self.traitCollection
            let sz = self.view.bounds.size
            if tc.horizontalSizeClass == .regular {
                if sz.width > sz.height {
                    return true
                }
            }
            return false
        }
        if greenViewShouldAppear() {
            self.greenView.frame = CGRect(
                x:0, y:0,
                width:self.view.bounds.width/3.0, height:self.view.bounds.height
            )
        } else {
            self.greenView.frame = CGRect(x:-self.view.bounds.width/3.0, y:0,
                                          width:self.view.bounds.width/3.0, height:self.view.bounds.height)
        }
    }
}

