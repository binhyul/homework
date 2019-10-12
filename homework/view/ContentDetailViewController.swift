//
//  ContentDetailViewController.swift
//  homework
//
//  Created by wlswnwns on 2019/10/12.
//  Copyright © 2019 wlswnwns. All rights reserved.
//

import Foundation
import UIKit

class ContentDetailViewController : UIViewController, UIScrollViewDelegate{
    @IBOutlet weak var ContentTextView: UITextView!
    @IBOutlet weak var ContentImgView: UIImageView!
    
    var cotentText : String = ""
    var contentImgPath : String = ""
    
    var ImageView : UIImageView?
    
    var backGoundView : UIView?

    @IBAction func onBackBtn(_ sender: Any) {
        let transition: CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: nil)
        self.dismiss(animated: false, completion: nil)
    }
    override func viewDidLoad() {
          super.viewDidLoad()
        
        self.ContentTextView.text = cotentText
        self.ContentTextView.backgroundColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
        self.ContentTextView.isScrollEnabled = false
        self.ContentTextView.textAlignment = NSTextAlignment.left
        
        let sizeThatFitsTextView =  self.ContentTextView.sizeThatFits(CGSize(width: self.ContentTextView.frame.size.width, height: CGFloat(MAXFLOAT)))
                            
        let heightOfText = sizeThatFitsTextView.height
        
        self.ContentTextView.frame.size = CGSize(width: 340.0 , height: heightOfText)
        
        
        self.ContentImgView.frame.origin.y =  self.ContentTextView.frame.size.height + self.ContentTextView.frame.origin.y + 10
        
        let url : URL! = URL(string: contentImgPath)
                      let task = URLSession.shared.dataTask(with: url){ (data,response,error) in
                          if error == nil{
                             let img = UIImage(data: data!)
                           
                           
                             DispatchQueue.main.async(){
                                self.ContentImgView.image = img
                   
                                self.ContentImgView.contentMode = UIView.ContentMode.scaleToFill
                               self.ContentImgView.clipsToBounds = true
                                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.buttonTapped))
                                self.ContentImgView.isUserInteractionEnabled = true
                                self.ContentImgView.addGestureRecognizer(tapGesture)

                               
             
                           }
                           
                          }
                      }
               task.resume()
          
          
      }
    
    
     @objc func zoombuttonTapped(sender: UITapGestureRecognizer) {
        
        if sender.state == .ended{
        }
    }
    
    
    @objc func buttonTapped(sender: UITapGestureRecognizer) {


            backGoundView = UIView(frame: self.view.frame)
            backGoundView!.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        
        let scrollview = UIScrollView(frame: self.view.frame)
        backGoundView!.addSubview(scrollview)
        
            
            ImageView =  UIImageView(frame: CGRect(x: 0, y: 0, width: 375, height: 375))
        ImageView!.image = self.ContentImgView.image
        ImageView!.center = CGPoint(x: backGoundView!.frame.size.width  / 2,y: backGoundView!.frame.size.height / 2)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.zoombuttonTapped))
        self.ImageView!.isUserInteractionEnabled = true
        self.ImageView!.addGestureRecognizer(tapGesture)
        
        scrollview.addSubview(ImageView!)
        
        scrollview.alwaysBounceVertical = false
        scrollview.alwaysBounceHorizontal = false
        scrollview.maximumZoomScale = 2.0
        scrollview.minimumZoomScale = 1.0
        scrollview.delegate = self
        
        
                let Textview =  UITextView(frame: CGRect(x: 0, y: 0, width: self.ContentTextView.frame.size.width, height: self.ContentTextView.frame.size.height))
                   Textview.text = self.ContentTextView.text
        
                let sizeThatFitsTextView =  Textview.sizeThatFits(CGSize(width: Textview.frame.size.width, height: CGFloat(MAXFLOAT)))
                                   
               let heightOfText = sizeThatFitsTextView.height
               
               Textview.frame.size = CGSize(width: 340.0 , height: heightOfText)
        Textview.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        
        Textview.frame.origin.y = ImageView!.frame.size.height + ImageView!.frame.origin.y + 10
        
           // Textview.center = CGPoint(x: backgroundView.frame.size.width  / 2,y: backgroundView.frame.size.height / 2)
                backGoundView!.addSubview(Textview)
        
            
            self.view.addSubview(backGoundView!)
            
            
           
        
    }

    @available(iOS 2.0, *)
      public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
          return self.ImageView!
      }
    
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
         backGoundView!.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
          self.ContentImgView.isHidden = true
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
       self.ContentImgView.isHidden = false
    }
    
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        
        
      if scrollView.isZoomBouncing{
            print(scrollView.zoomScale)
            
            if scrollView.zoomScale == (scrollView.minimumZoomScale ){
                
                       backGoundView!.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
                       backGoundView!.removeFromSuperview()
            }else{
               
                backGoundView!.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
           }
      }else{
       
         backGoundView!.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "finish"{

            dismiss(animated: true, completion: nil)
               
           }
           
           
       }

    
}
