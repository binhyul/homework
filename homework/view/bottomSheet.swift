//
//  bottomSheet.swift
//  homework
//
//  Created by wlswnwns on 2019/10/09.
//  Copyright © 2019 wlswnwns. All rights reserved.
//

import Foundation
import UIKit
 
class bottomSheet: UIView  , UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sectionInset = (collectionViewLayout as! UICollectionViewFlowLayout).sectionInset
        let referenceHeight: CGFloat = 50.0
         
        return CGSize(width: 375.0, height: referenceHeight)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filterlistcell", for: indexPath) as! FilterListItemCell
        cell.FilterTextView.text = filterList[indexPath.row]
        
        cell.FilterTextView.frame.origin.x = 16.0
        
        let sizeThatFitsTextView =  cell.FilterTextView.sizeThatFits(CGSize(width: cell.FilterTextView.frame.size.width, height: CGFloat(MAXFLOAT)))
                           
        let heightOfText = sizeThatFitsTextView.height
        cell.FilterTextView.frame.size = CGSize(width: 375.0 , height: heightOfText)
        cell.presenter =  self.presenter!
        cell.index = indexPath.row
        cell.bottomSheet = self
        
        if index == indexPath.row{
            
            cell.FilterTextView.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15.0)
            cell.backgroundColor = UIColor(red:0.94, green:0.98, blue:1.00, alpha:1.0)
            cell.FilterTextView.textColor = UIColor(red:0.21, green:0.77, blue:0.94, alpha:1.0)
            
        }else{
            cell.FilterTextView.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15.0)
            cell.backgroundColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
            cell.FilterTextView.textColor = UIColor(red:0.26, green:0.26, blue:0.26, alpha:1.0)
        }
        
        
        
        
        return cell
        
    }
    
    var filterList : [String] = [String]()
    
    @IBOutlet weak var FilterCollectionView: UICollectionView!
    
    @IBOutlet weak var ConfirmBtn: UIButton!
    
    var presenter : ContentListPresenter? = nil
    
    var SortFilter : String = ""
    
    var index : Int = 0
    @IBOutlet weak var TitleBarView: UIView!
    @IBOutlet weak var TitleView: UILabel!
    @IBOutlet weak var ResetBtn: UIButton!
    
    @IBAction func onClickResetBtn(_ sender: Any) {
        presenter?.resetFilter(sort: SortFilter)
        index = 0
        DataReload()
    }
    
    
    func DataReload(){
        self.FilterCollectionView.reloadData()
    }
    
    
    func setFilterList(list : [String]){
        self.filterList = list
        self.FilterCollectionView.delegate = self
        self.FilterCollectionView.dataSource = self
        self.FilterCollectionView.register(UINib(nibName: "FilterListItemCell", bundle: nil), forCellWithReuseIdentifier: "filterlistcell")
        self.FilterCollectionView.frame.origin.y =  (UIScreen.main.bounds.height) - (50.0 * (CGFloat(filterList.count)+0.5)) - self.ConfirmBtn.frame.size.height
        self.FilterCollectionView.frame.size = CGSize(width: 375.0 , height: (50.0 * (CGFloat(filterList.count)+1.5)))
        
        TitleBarView.frame.origin.y =  (UIScreen.main.bounds.height) - (50.0 * (CGFloat(filterList.count)+0.5)) - self.ConfirmBtn.frame.size.height - self.TitleBarView.frame.size.height
        
        
        if SortFilter == "order"{
            TitleView.text = "정렬"
        }else if  SortFilter == "space"{
            TitleView.text = "주거형태"
        }else if SortFilter == "residence"{
            TitleView.text = "평수"
        }
        
        TitleView.center = CGPoint(x: TitleBarView.frame.size.width / 2  , y: TitleBarView.frame.size.height / 2)
        
       
        
    }
    
  
    
    // identifier
    class var identifier: String
    {
        return String(describing: self)
    }
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: self.identifier, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    // MARK : btnAction
    @IBAction func btnClick_add(_ sender: UIButton) {
        
        NSLog("===== ViewAlertFavoriteAdd btnClick_add =====");
    }
    
    @IBAction func btnClick_Close(_ sender: UIButton) {
        
        print("선택 인덱스 -->\(self.index)")
        
        if SortFilter == "order"{
            presenter?.sortOrder(index: index)
        }else if  SortFilter == "space"{
            presenter?.sortSpace(index: index)
        }else if SortFilter == "residence"{
            presenter?.sortResidence(index: index)
        }
        
        removeFromSuperview();
    }
    
    
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
 
}


