//
//  ViewController.swift
//  homework
//
//  Created by wlswnwns on 2019/10/09.
//  Copyright © 2019 wlswnwns. All rights reserved.
//

import UIKit

class ContentListViewController: UIViewController,ContentListViewProtocol,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (presenter?.getContentListSize())!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "contentlistcell", for: indexPath) as! ContentListCell
        cell.index = indexPath.row
        cell.presenter = self.presenter
         setDescription(cell: cell)
        setMainImg(cell: cell)
       
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        HeigtView.text = presenter?.getContent(index: indexPath.row).description
              
        let sizeThatFitsTextView =  HeigtView.sizeThatFits(CGSize(width: HeigtView.frame.size.width, height: CGFloat(MAXFLOAT)))
              
        var heightOfText = sizeThatFitsTextView.height
              
           let sectionInset = (collectionViewLayout as! UICollectionViewFlowLayout).sectionInset
            let referenceHeight: CGFloat = 375.0 + heightOfText
           if #available(iOS 11.0, *) {
               let referenceWidth = collectionView.safeAreaLayoutGuide.layoutFrame.width
                   - sectionInset.left
                   - sectionInset.right
                   - collectionView.contentInset.left
                   - collectionView.contentInset.right
               
               return CGSize(width: referenceWidth, height: referenceHeight)
               
           } else {
               return CGSize(width: 375.0, height: referenceHeight)
           }

       }
    
    
   
    
    func setMainImg(cell :ContentListCell){
        
         cell.MainImageView.frame.origin.x = 0
        
        
        let url : URL! = URL(string: (presenter?.getContent(index: cell.index).image_url)!)
               let task = URLSession.shared.dataTask(with: url){ (data,response,error) in
                   if error == nil{
                      let img = UIImage(data: data!)
                    
                    
                      DispatchQueue.main.async(){
                  
                        
//                        cell.MainImageView.autoresizingMask = UIView.AutoresizingMask(rawValue: UIView.AutoresizingMask.flexibleBottomMargin.rawValue | UIView.AutoresizingMask.flexibleHeight.rawValue | UIView.AutoresizingMask.flexibleRightMargin.rawValue | UIView.AutoresizingMask.flexibleLeftMargin.rawValue | UIView.AutoresizingMask.flexibleTopMargin.rawValue | UIView.AutoresizingMask.flexibleWidth.rawValue)
                        cell.MainImageView.contentMode = UIView.ContentMode.scaleAspectFit
                        cell.MainImageView.clipsToBounds = true
                          cell.MainImageView.image = img
                      
                    }
                    
                   }
               }
        task.resume()
    }
    
 
  
    func setDescription(cell : ContentListCell){
        
        
        cell.descriptionTextView.text = presenter?.getContent(index: cell.index).description
        
        
         cell.descriptionTextView.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15.0)

              
        cell.descriptionTextView.frame.origin.x = 16.0
        
           
        let sizeThatFitsTextView =  cell.descriptionTextView.sizeThatFits(CGSize(width: HeigtView.frame.size.width, height: CGFloat(MAXFLOAT)))
                     
        let heightOfText = sizeThatFitsTextView.height
        
       
        
        if(heightOfText < 95.0){
            
            cell.MainImageView.frame.origin.y = heightOfText + 10
            
            cell.descriptionTextView.frame.size = CGSize(width: 340.0 , height: heightOfText)
            cell.moreTextView.isHidden = true

        }else{
           
             cell.MainImageView.frame.origin.y = 115
            
            cell.descriptionTextView.frame.size = CGSize(width: 340.0 , height: 95.0)
            cell.moreTextView.isHidden = false
    
        }
        
             
        cell.descriptionTextView.isScrollEnabled = false
              
        cell.descriptionTextView.textAlignment = NSTextAlignment.left
        
        cell.descriptionTextView.backgroundColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
        
    }
    
    

    var presenter : ContentListPresenter? = nil
    @IBOutlet weak var ContentListView: UICollectionView!
    @IBOutlet weak var HeigtView: UITextView!
    @IBOutlet weak var ApplyFilterView: UIView!
    var appDelegate : AppDelegate  = ((UIApplication .shared).delegate as? AppDelegate)!
    
    
    var buttonX : CGFloat = 16.0
    
    var destinationViewController : ContentDetailViewController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        presenter = ContentListPresenter(view: self)
        presenter?.LoadData()
        
        
    }
    
    func showFilterSheet(list : [String], sort : String, defaultIndex : Int){
        
        
         DispatchQueue.main.async(){
        
            let popup: bottomSheet = UINib(nibName: bottomSheet.identifier, bundle: nil).instantiate(withOwner: self, options: nil)[0] as! bottomSheet
                 popup.backgroundColor = UIColor.white.withAlphaComponent(0.0)
                 popup.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 2)
                 popup.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
             popup.SortFilter = sort
            popup.setFilterList(list: list)
            popup.presenter =  self.presenter!
            popup.index = defaultIndex
                 
            self.view.addSubview(popup)
            
        }
        
    }
    
    
    @IBAction func onClickOrderFilterBtn(_ sender: Any) {
        presenter?.onClickOrderFilterBtn()
 
    }
    @IBAction func onClickSpaceFilterBtn(_ sender: Any) {
        presenter?.onClickSpaceFilterBtn()
 
    }
    @IBAction func onClickResidenceFilterBtn(_ sender: Any) {
        presenter?.onClickResidenceFilterBtn()
       
    }
    
    func createApplyFilterButton(FilterName : String, sort : String, FilterTag : Int){
        
        resetFilterView(FilterTag: FilterTag)
        
        
        
        let button : UIButton = UIButton(frame: CGRect(x: buttonX, y: 7.0, width: 70, height: 26))

        button.setTitle(FilterName, for: .normal)
        button.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15.0)
        
        let sizeThatFitsTextView =  button.titleLabel!.sizeThatFits(CGSize(width: button.titleLabel!.frame.size.width, height: 26))
        
        button.frame.size.width = sizeThatFitsTextView.width + 35.0
        
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.semanticContentAttribute = .forceRightToLeft
       

        button.showsTouchWhenHighlighted = true

        button.setTitleColor(UIColor.white, for: .normal)

        button.tag = FilterTag
        
        button.backgroundColor = UIColor(red:0.21, green:0.77, blue:0.94, alpha:1.0)
        
        button.setImage( UIImage(named: "x"), for: .normal)

        button.addTarget(self, action: #selector(deleteButtonAction), for: .touchUpInside)

        self.ApplyFilterView.addSubview(button)
      

        buttonX += button.frame.size.width + 5 // 버튼 생성시마다 위치를 다르게 하기 위해 y값을 증가시킨다.



    }
    
    @objc func deleteButtonAction(sender: UIButton!) {
        
        sender.removeFromSuperview()
        buttonX = 16
        var filterNameList : [String] = [String]()
        var filterTagList : [Int] = [Int]()
        
        for button in self.ApplyFilterView.subviews{
            
            let btn : UIButton = button as! UIButton
            
            if sender.titleLabel?.text != btn.titleLabel!.text!{
                 filterNameList.append(btn.titleLabel!.text!)
                filterTagList.append(btn.tag)
            }
            
            button.removeFromSuperview()
            
        }
        
        if filterNameList.count != 0{
            for buttonIndex in 0...filterNameList.count-1{
                       let button : UIButton = UIButton(frame: CGRect(x: buttonX, y: 7.0, width: 70, height: 26))

                        button.setTitle(filterNameList[buttonIndex], for: .normal)
                        button.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15.0)
                       
                        let sizeThatFitsTextView =  button.titleLabel!.sizeThatFits(CGSize(width: button.titleLabel!.frame.size.width, height: 26))
                              
                        button.frame.size.width = sizeThatFitsTextView.width + 35.0
                              
                        button.layer.cornerRadius = 10
                        button.clipsToBounds = true
                        button.semanticContentAttribute = .forceRightToLeft
                        button.showsTouchWhenHighlighted = true

                        button.setTitleColor(UIColor.white, for: .normal)

                        button.tag = filterTagList[buttonIndex]
                              
                        button.backgroundColor = UIColor(red:0.21, green:0.77, blue:0.94, alpha:1.0)
                              
                        button.setImage( UIImage(named: "x"), for: .normal)

                        button.addTarget(self, action: #selector(deleteButtonAction), for: .touchUpInside)

                        self.ApplyFilterView.addSubview(button)



                        buttonX += button.frame.size.width + 5 //
                   }
        }
        
        
       
        

    }

    func resetFilterView(FilterTag : Int){
        for button in self.ApplyFilterView.subviews{
                   
                   let btn : UIButton = button as! UIButton
                   
                   if btn.tag == FilterTag {
                       button.removeFromSuperview()
                   }
                   
               }
        
        buttonX = 16
        var filterNameList : [String] = [String]()
        var filterTagList : [Int] = [Int]()
        
        for button in self.ApplyFilterView.subviews{
            
            let btn : UIButton = button as! UIButton
            
                 filterNameList.append(btn.titleLabel!.text!)
                filterTagList.append(btn.tag)
            
            
            button.removeFromSuperview()
            
        }
        
        if filterNameList.count != 0{
            for buttonIndex in 0...filterNameList.count-1{
                       let button : UIButton = UIButton(frame: CGRect(x: buttonX, y: 7.0, width: 70, height: 26))

                        button.setTitle(filterNameList[buttonIndex], for: .normal)
                        button.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15.0)
                       
                        let sizeThatFitsTextView =  button.titleLabel!.sizeThatFits(CGSize(width: button.titleLabel!.frame.size.width, height: 26))
                              
                        button.frame.size.width = sizeThatFitsTextView.width + 35.0
                              
                        button.layer.cornerRadius = 10
                        button.clipsToBounds = true
                        button.semanticContentAttribute = .forceRightToLeft
                        button.showsTouchWhenHighlighted = true

                        button.setTitleColor(UIColor.white, for: .normal)

                        button.tag = filterTagList[buttonIndex]
                              
                        button.backgroundColor = UIColor(red:0.21, green:0.77, blue:0.94, alpha:1.0)
                              
                        button.setImage( UIImage(named: "x"), for: .normal)

                        button.addTarget(self, action: #selector(deleteButtonAction), for: .touchUpInside)

                        self.ApplyFilterView.addSubview(button)

                        buttonX += button.frame.size.width + 5 //
                   }
        }
        
    }


    
    
    
       func setData(){
        DispatchQueue.main.async(){
         
            self.ContentListView.dataSource = self
            self.ContentListView.delegate = self
        }
       }
       
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail"{
            
            let transition: CATransition = CATransition()
                       transition.duration = 0.5
                       transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                       transition.type = CATransitionType.push
                       transition.subtype = CATransitionSubtype.fromRight
                       self.view.window!.layer.add(transition, forKey: nil)
            
            destinationViewController = segue.destination as! ContentDetailViewController
            destinationViewController!.cotentText = (presenter?.getSelectedContent().description)!
            destinationViewController!.contentImgPath =  (presenter?.getSelectedContent().image_url)!
            destinationViewController!.modalPresentationStyle = .fullScreen
           
        }
        
        
    }


}

