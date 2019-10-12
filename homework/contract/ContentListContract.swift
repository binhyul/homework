//
//  ContentListContract.swift
//  homework
//
//  Created by wlswnwns on 2019/10/09.
//  Copyright © 2019 wlswnwns. All rights reserved.
//

import Foundation


protocol ContentListViewProtocol: class{
     func setData()
    func showFilterSheet(list : [String], sort : String, defaultIndex : Int)
    func createApplyFilterButton(FilterName : String, sort : String, FilterTag : Int)
    func resetFilterView(FilterTag : Int)
    
}

protocol ContentListPresenterProtocol: class {
    func LoadData()
    func getContentListSize()->Int
    func getContent(index : Int)-> board
    func onClickOrderFilterBtn()
    func onClickSpaceFilterBtn()
    func onClickResidenceFilterBtn()
    
    func sortOrder(index : Int)
    func sortSpace(index : Int)
    func sortResidence(index : Int)
    
    func resetFilter(sort : String)
    func onItemClick(index : Int)
    func getSelectedContent()-> board
}

protocol onDataLoadListner {
    func onLoad(data : [board])
}
