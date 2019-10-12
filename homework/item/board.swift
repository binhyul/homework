//
//  board.swift
//  homework
//
//  Created by wlswnwns on 2019/10/09.
//  Copyright © 2019 wlswnwns. All rights reserved.
//

import Foundation
class board{
    
    var id : Int
    var image_url : String
    var nickname : String
    var profile_image_url : String
    var description : String
    
    init(item : [String : Any]) {
        id = item["id"] as! Int
       image_url = item["image_url"] as! String
        nickname = item["nickname"] as! String
        profile_image_url = item["profile_image_url"] as! String
        description = item["description"] as! String
    }
    
 
    
    
    
    
    
}
