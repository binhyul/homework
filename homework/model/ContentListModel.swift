//
//  ContentListModel.swift
//  homework
//
//  Created by wlswnwns on 2019/10/09.
//  Copyright © 2019 wlswnwns. All rights reserved.
//

import Foundation

class ContentListModel{
    
    var BoardList : [board]? = nil
    
    var listner : onDataLoadListner?
    
    var OrderFilter : [String]?
    
    var SpaceFilter : [String]?
    
    var ResidenceFilter : [String]?
    
    var SelectedOrderIndex = 0
    var SelectedSpaceIndex = 0
    var SelectedResidenceIndex = 0
    
    var SelectedIndex = 0
    
    
    func InitOrderFilterItems(){
        OrderFilter = [String]()
        OrderFilter?.append("최신순")
        OrderFilter?.append("베스트")
        OrderFilter?.append("인기순")
    }
    
    func InitSpaceFilterItems(){
        SpaceFilter = [String]()
        SpaceFilter?.append("거실")
        SpaceFilter?.append("침실")
        SpaceFilter?.append("주방")
        SpaceFilter?.append("욕실")
     }
    
    func InitResidenceFilterItems(){
        ResidenceFilter = [String]()
        ResidenceFilter?.append("아파트")
        ResidenceFilter?.append("빌라&연립")
        ResidenceFilter?.append("단독주택")
        ResidenceFilter?.append("사무공간")
        
    }
       
    
    
    
    func LoadData(){
        
        let url : URL! = URL(string: "https://s3.ap-northeast-2.amazonaws.com/bucketplace-coding-test/cards/page_1.json")
        
        let task = URLSession.shared.dataTask(with: url){ (data,response,error) in
            if error == nil{
               let json = try! JSONSerialization.jsonObject(with: data!, options: []) as! [[String : Any]]
                
                
                self.BoardList = [board]()
                
                for item in json{
                    self.BoardList?.append(board(item: item))
                }
                
                self.listner!.onLoad(data: self.BoardList!)
            }
        }
        task.resume()
    }
    
    
    
}
