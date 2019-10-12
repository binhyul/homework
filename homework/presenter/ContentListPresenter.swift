//
//  ContentListPresenter.swift
//  homework
//
//  Created by wlswnwns on 2019/10/09.
//  Copyright © 2019 wlswnwns. All rights reserved.
//

import Foundation

class ContentListPresenter: ContentListPresenterProtocol,onDataLoadListner  {
   
    
   
  
    

    var view : ContentListViewProtocol
    var model : ContentListModel
  
    
    init(view : ContentListViewProtocol){
        self.view = view
        self.model = ContentListModel()
        self.model.listner = self
        
        
    }
    func onLoad(data : [board]) {
        view.setData()
    }
       
    
    func LoadData() {
        model.LoadData()
        model.InitOrderFilterItems()
        model.InitSpaceFilterItems()
        model.InitResidenceFilterItems()
    }
    
    func getContentListSize()->Int{
        return model.BoardList!.count
    }
    
    
    
    func getContent(index : Int)-> board{
        return model.BoardList![index]
    }
    
    func getSelectedContent()-> board{
        return model.BoardList![model.SelectedIndex]
     }
    
    func sortOrder(index: Int) {
        view.createApplyFilterButton(FilterName: model.OrderFilter![index], sort: "order", FilterTag : 0)
        model.SelectedOrderIndex = index
    }
       
    func sortSpace(index: Int) {
        view.createApplyFilterButton(FilterName: model.SpaceFilter![index], sort: "space", FilterTag : 1)
        model.SelectedSpaceIndex = index
    }
       
    func sortResidence(index: Int) {
        view.createApplyFilterButton(FilterName: model.ResidenceFilter![index], sort: "residence", FilterTag : 2)
        model.SelectedResidenceIndex = index
    }
    func onClickOrderFilterBtn() {
        view.showFilterSheet(list: model.OrderFilter!, sort: "order", defaultIndex : model.SelectedOrderIndex)
    }
       
    func onClickSpaceFilterBtn() {
        view.showFilterSheet(list: model.SpaceFilter!, sort: "space", defaultIndex : model.SelectedSpaceIndex)
    }
       
    func onClickResidenceFilterBtn() {
        view.showFilterSheet(list: model.ResidenceFilter!, sort: "residence", defaultIndex : model.SelectedResidenceIndex)
    }
       
    func resetFilter(sort : String){
        if sort == "order"{
            view.resetFilterView(FilterTag: 0)
        }else if  sort == "space"{
           view.resetFilterView(FilterTag: 1)
        }else if sort == "residence"{
           view.resetFilterView(FilterTag: 2)
        }
    }
    
    func onItemClick(index : Int){
        model.SelectedIndex = index
    }
    
}
