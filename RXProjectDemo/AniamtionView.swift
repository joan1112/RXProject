//
//  AniamtionView.swift
//  RXProjectDemo
//
//  Created by qiong on 2019/8/20.
//  Copyright © 2019 qiong. All rights reserved.
//

import UIKit

class AniamtionView: UIView {

    var dataTab:UITableView!
    var dataArr:Array<Any> = Array.init()
    
    var curentRow:Int = 0
    var timer:Timer!
    override init(frame: CGRect) {
        super.init(frame: frame)
        initTab()
    }
  fileprivate func initTab(){
        dataTab = UITableView.init(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height), style: .grouped)
        dataTab.rowHeight = self.frame.size.height
        dataTab.estimatedSectionFooterHeight = 0
        dataTab.estimatedSectionHeaderHeight = 0
        self.addSubview(dataTab)
        dataTab.delegate = self
        dataTab.dataSource = self
        dataTab.isScrollEnabled = false
        dataTab.separatorStyle = .none

    }
    

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        timer.invalidate()
    }
}
extension AniamtionView:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if (cell == nil) {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        }
        cell?.selectionStyle = .none
        cell?.textLabel?.text = self.dataArr[indexPath.row] as? String
        
        return cell!
        
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    
}
extension AniamtionView{
    public func setDataArr(arr:Array<String>){
        var curent :Array = arr
        curent.insert(contentsOf: arr, at: 0)
        curent.insert(arr[0], at: arr.count*2)
        self.dataArr = curent
        self.dataTab.reloadData()
        self.dataTab.scrollToRow(at: NSIndexPath.init(row: 0, section: 0) as IndexPath, at: .middle, animated: false)
        beginTimer()
    }
    func beginTimer(){
       timer = Timer.init(timeInterval: 1, repeats: true) { (time) in
            self.curentRow += 1
            if self.curentRow == self.dataArr.count {
                self.curentRow = 0
                self.dataTab.scrollToRow(at: NSIndexPath.init(row: self.curentRow, section: 0) as IndexPath, at: .middle, animated: false)
                 self.curentRow = 1
                 self.dataTab.scrollToRow(at: NSIndexPath.init(row: self.curentRow, section: 0) as IndexPath, at: .middle, animated: true)
            }else{
                self.dataTab.scrollToRow(at: NSIndexPath.init(row: self.curentRow, section: 0) as IndexPath, at: .middle, animated: true)
            }
            
        }
        
           RunLoop.current.add(timer, forMode: .common)
    }
  
}
