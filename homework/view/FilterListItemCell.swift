//
//  LanguageListCell.swift
//  bcam
//
//  Created by 조한진 on 2019. 5. 8..
//  Copyright © 2019년 Mingun Baek. All rights reserved.
//

import Foundation
import UIKit

class FilterListItemCell: UICollectionViewCell {


    @IBOutlet weak var FilterTextView: UILabel!
    
  
    @IBOutlet weak var FilterBtn: UIButton!
    
    var presenter : ContentListPresenter? = nil
    
    var index : Int = 0
    
    var bottomSheet : bottomSheet?
    
    @IBAction func onClickFilterBtn(_ sender: Any) {
        bottomSheet?.index = self.index
        bottomSheet?.DataReload()
       

        
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
}
