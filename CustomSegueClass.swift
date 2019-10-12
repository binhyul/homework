//
//  CustomSegueClass.swift
//  homework
//
//  Created by wlswnwns on 2019/10/12.
//  Copyright © 2019 wlswnwns. All rights reserved.
//

import Foundation
import UIKit

 // RightViewController  뷰 이동
 class SegueRightToLeft: UIStoryboardSegue {
    override func perform() {
        let src = self.source
        let dst = self.destination
        src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
        dst.view.transform = CGAffineTransform(translationX: src.view.frame.size.width, y: 0)
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseInOut, animations: {
            dst.view.transform = CGAffineTransform(translationX: 0, y: 0)}, completion: {
                finished in src.present(dst, animated: false, completion: nil)
                
        })
        
    }
    
}

class SegueLeftToRight: UIStoryboardSegue {
    override func perform() {
        let src = self.source
        let dst = self.destination
        src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
        dst.view.transform = CGAffineTransform(translationX: -src.view.frame.size.width, y: 0)
        UIView.animate(withDuration: 0.25, delay: 0.0, options:
            UIView.AnimationOptions.curveEaseInOut, animations: {
            dst.view.transform = CGAffineTransform(translationX: 0, y: 0)
                
        }) { (finished) in src.present(dst, animated: false, completion: nil) }
        
    }
    
}

