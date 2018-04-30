//
//  CardsViewController.swift
//  Tinder
//
//  Created by Trustin Harris on 4/29/18.
//  Copyright © 2018 Trustin Harris. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {
    
    @IBOutlet weak var Pictures: UIImageView!
    var cardInitialCenter: CGPoint!
    var newPic: UIImageView!
    var newPicOriginalCenter: CGPoint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func DraggingPicture(_ sender: UIPanGestureRecognizer) {
        let velocity = sender.velocity(in: view)
        let translation = sender.translation(in: view)
        
        if sender.state == .began {
            cardInitialCenter = Pictures.center
        }
        
        if sender.state == .changed {
            Pictures.center = CGPoint(x: cardInitialCenter.x + translation.x, y: cardInitialCenter.y)
            if translation.x > 0 {
                Pictures.transform = CGAffineTransform(rotationAngle:CGFloat(7 * M_PI/180))
                if translation.x > 65 {
           //*********** Swiping Right
                    let IV = sender.view as! UIImageView
                    newPic = UIImageView(image: IV.image)
                    view.addSubview(newPic)
                    Pictures.alpha = 1
                    newPic.alpha = 0
                    UIView.animate(withDuration: 2) {
                        self.Pictures.alpha = 0
                        self.newPic.alpha = 1
                        self.newPic.isUserInteractionEnabled = true
                    }
                }
            }
            if translation.x < 0 {
                Pictures.transform = CGAffineTransform(rotationAngle:CGFloat(-7 * M_PI/180))
                if translation.x < -65 {
        //******** Swiping Left 
                    let IV = sender.view as! UIImageView
                    newPic = UIImageView(image: IV.image)
                    view.addSubview(newPic)
                    Pictures.alpha = 1
                    newPic.alpha = 0
                    UIView.animate(withDuration: 2) {
                        self.Pictures.alpha = 0
                        self.newPic.alpha = 1
                        self.newPic.isUserInteractionEnabled = true
                    }
                }
            }
        }
        if sender.state == .ended {
            if Pictures == Pictures {
                Pictures.center = cardInitialCenter
                Pictures.transform = CGAffineTransform.identity
            } else {
                newPic.center = cardInitialCenter
                newPic.transform = CGAffineTransform.identity
            }
        }
    }
}
