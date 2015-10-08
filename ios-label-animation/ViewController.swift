//
//  ViewController.swift
//  ios-label-animation
//
//  Created by Ivan M on 10/7/15.
//  Copyright © 2015 ivan3bx. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let PADDING = CGFloat(12.0)
    
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    
    @IBOutlet weak var customView: SlideLabelView!
    
    override func viewDidLoad() {
        firstLabel.hidden  = false
        secondLabel.hidden = true
    }
    
    func labelToHide() -> UILabel {
        if firstLabel.hidden {
            return secondLabel
        } else {
            return firstLabel
        }
    }
    
    func labelToShow() -> UILabel {
        if firstLabel.hidden {
            return firstLabel
        } else {
            return secondLabel
        }
    }
    
    @IBAction func toggleDifferent(sender: AnyObject) {
        customView.text = "Different: \(rand())"
        
    }
    /**
     Toggling with simple keyframe animation on two alternating labels
     */
    @IBAction func toggle(sender: AnyObject) {
        customView.text = "Flip!"
        
        let toHide = labelToHide()
        let toShow = labelToShow()
        
        UIView.animateKeyframesWithDuration(0.7, delay: 0, options: [],
            animations: {
                UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 0.0, animations: {
                    toShow.frame.origin.y = toShow.frame.origin.y + (toShow.frame.height + self.PADDING)
                    toShow.hidden = false
                })
                
                UIView.addKeyframeWithRelativeStartTime(0.1, relativeDuration: 1.0, animations: {
                    toHide.frame.origin.y = toHide.frame.origin.y - (toHide.frame.height + self.PADDING)
                    toShow.frame.origin.y = toShow.frame.origin.y - (toShow.frame.height + self.PADDING)
                })
            }, completion: { isComplete in
                toHide.frame.origin.y = toHide.frame.origin.y + (toHide.frame.height + self.PADDING)
                toHide.hidden = true
        })
    }
}
