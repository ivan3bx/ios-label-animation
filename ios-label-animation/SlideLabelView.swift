//
//  SlideLabelView.swift
//  ios-label-animation
//
//  Created by Ivan M on 10/8/15.
//  Copyright © 2015 ivan3bx. All rights reserved.
//

import Foundation

import UIKit

/**
 Programmatic view with a ```text``` property that slides in
 to replace the previous contents, or flashes if the previous
 text is unchanged
*/
class SlideLabelView: UIView {
    
    let padding = CGFloat(6.0)
    let animationLength = NSTimeInterval(0.5)
    
    private var label1: UILabel = UILabel()
    private var label2: UILabel = UILabel()
    
    var text: String? {
        get {
            if label1.hidden {
                return label2.text
            } else {
                return label1.text
            }
        }

        set(value) {
            let target = (label1.hidden) ? label1 : label2
            let previous = (label1.hidden) ? label2 : label1

            target.text = value

            if previous.text == value {
                didUpdateToSameText(previous)
            } else {
                didUpdateText(labelToShow: target)
            }
        }
    }

    private var didSetConstraints = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    private func setupViews() {
        apply { label in
            label.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(label)
        }
        
        label1.tag = 101
        label2.tag = 102
        
        label1.hidden = false
        label2.hidden = true
        clipsToBounds = true
    }
    
    private func didUpdateToSameText(label:UILabel) {
        UIView.animateWithDuration(animationLength / 3, delay: 0.0, options: [.Repeat], animations: {
            UIView.setAnimationRepeatCount(2)
            label.alpha = 0.3
            }, completion: { isComplete in
                UIView.animateWithDuration(self.animationLength / 3, animations: { label.alpha = 1.0 })
            }
        )
    }
    
    private func didUpdateText(labelToShow toShow:UILabel) {
        let toHide = (toShow == label1) ? label2 : label1

        toShow.frame.origin.y = toShow.frame.origin.y + (toShow.frame.height + self.padding)
        toShow.hidden = false

        UIView.animateWithDuration(animationLength,
            animations: {
                toHide.frame.origin.y = toHide.frame.origin.y - (toHide.frame.height + self.padding)
                toShow.frame.origin.y = toShow.frame.origin.y - (toShow.frame.height + self.padding)
            },
            completion: { isComplete in
                toHide.frame.origin.y = toHide.frame.origin.y + (toHide.frame.height + self.padding)
                toHide.hidden = true
            }
        )
    }
    
    private func apply(inner:(label:UILabel) -> Void) {
        for label in [label1, label2] { inner(label: label) }
    }
    
    override func updateConstraints() {
        if !didSetConstraints {
            didSetConstraints = true

            apply({ label in
                self.addConstraints(
                    NSLayoutConstraint.constraintsWithVisualFormat(
                        "H:|-4-[label]-4-|", options: [], metrics: nil,
                        views: ["label":label])
                )
            })
            
            apply({ label in
                self.addConstraints(
                    NSLayoutConstraint.constraintsWithVisualFormat(
                        "V:|-4-[label]-4-|", options: [], metrics: nil,
                        views: ["label":label])
                )
            })
        }
        super.updateConstraints()
    }
}