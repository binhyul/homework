//
//  ContentListCell.swift
//  homework
//
//  Created by wlswnwns on 2019/10/09.
//  Copyright © 2019 wlswnwns. All rights reserved.
//

import Foundation
import UIKit

class  ContentListCell : UICollectionViewCell {
    
    
    var index : Int = 0
    var presenter : ContentListPresenter?
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var MainImageView: UIImageView!
    
    @IBOutlet weak var moreTextView: UILabel!
    
    @IBAction func onItemClick(_ sender: Any) {
        presenter?.onItemClick(index: index)
       
    }
    
    
    
     override func prepareForReuse() {
           super.prepareForReuse()
           // reset custom properties to default values
           
       }
    

}
