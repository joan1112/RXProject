//
//  ViewController.swift
//  RXProjectDemo
//
//  Created by qiong on 2019/8/20.
//  Copyright © 2019 qiong. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class ViewController: UIViewController {
    var curentRow = 0
    
    var changeIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        getRepo("swift").subscribe(onSuccess: { (josn) in
//            print(josn)
//        }) { (error) in
//            print(error)
//
//        }.dispose()
       
        runTest1()
//        requestData("123")
    }
    
    
    func cachesLocal() -> Completable{
        return Completable.create(subscribe: { (com) -> Disposable in
            
            
            
            
           com(.completed)
            return Disposables.create()
        })
    }
    
    //跑马灯案列1
    func runTest1(){
        //top
        //center
        //bottom
        let show = UIView.init(frame:  CGRect(x: 10, y: 150, width: 100, height: 30))
        view.addSubview(show)
        show.clipsToBounds = true
        
        let arr = ["00001","00002","00003","00004","00005"]
        
        let lab = UILabel.init(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        show.addSubview(lab)
        
        let lab1 = UILabel.init(frame: CGRect(x: 0, y: 30, width: 100, height: 30))
        show.addSubview(lab1)
        
        
        lab.text = arr[0]
        
        lab1.text = arr[1]
        
        let timer:Timer = Timer.init(timeInterval: 1, repeats: true) { (time) in
            
            
            self.curentRow += 1
            
            UIView.animate(withDuration: 0.8, delay: 0, options: .curveEaseOut, animations: {
                if self.changeIndex == 0{
                    lab1.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
                    lab.frame = CGRect(x: 0, y: -30, width: 100, height: 30)
                    //lab changes to bottom
                    self.changeIndex = 0
                }else{
                    lab1.frame = CGRect(x: 0, y: -30, width: 100, height: 30)
                    lab.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
                    //lab1 changes to bottom
                    self.changeIndex = 1
                }
                
            }, completion: { (anima) in
                if self.changeIndex == 0 {
                    lab.frame = CGRect(x: 0, y: 30, width: 100, height: 30)
                    if self.curentRow+1 == arr.count{
                        lab.text = arr[0]
                        
                        self.curentRow = -1
                    }else{
                        lab.text = arr[self.curentRow+1]
                    }
                    //lab changes to center
                    self.changeIndex = 1
                    
                    
                }else{
                    lab1.frame = CGRect(x: 0, y: 30, width: 100, height: 30)
                    if self.curentRow+1 == arr.count{
                        lab1.text = arr[0]
                        self.curentRow = -1
                        
                        
                    }else{
                        
                        lab1.text = arr[self.curentRow+1]
                        
                    }
                    //lab1 changes to center
                    
                    self.changeIndex = 0
                    
                }
                
            })
        }
        
        RunLoop.current.add(timer, forMode: .common)
    }
    //跑马灯案列2
    func requestData(_ data:String){
       let anV =  AniamtionView.init(frame: CGRect.init(x: 10, y: 80, width: 300, height: 80))
        self.view.addSubview(anV)
        anV.setDataArr(arr: ["12345","DFDFDF","GFVDF","DFDVXVFD"])
    
    }

    func getRepo(_ repo: String) -> Single<[String: Any]> {
        
        return Single<[String: Any]>.create { single in
            let url = URL(string: "https://api.github.com/repos/\(repo)")!
            let task = URLSession.shared.dataTask(with: url) {
                data, _, error in
                
                if let error = error {
                    single(.error(error))
                    return
                }
                
                guard let data = data,
                    let json = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves),
                    let result = json as? [String: Any] else {
                       
                        return
                }
                
                single(.success(result))
            }
            
            task.resume()
            
            return Disposables.create { task.cancel() }
        }
    }
    
    func driverTest(){
        
        var userName: UITextField = UITextField()
        var userDrive = userName.rx.text.orEmpty.asDriver()
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
}

