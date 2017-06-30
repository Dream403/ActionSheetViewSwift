//
//  ViewController.swift
//  SLActionSheetView
//
//  Created by snowlu on 2017/6/29.
//  Copyright © 2017年 ZhunKuaiTechnology. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,SLActionSheetViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
  let bt = UIButton.init(frame:  CGRect.init(x: 10, y: 21, width: 200, height: 100))
        
        bt.backgroundColor = UIColor.red
        
        bt.addTarget(self, action: #selector(click(_ :)), for:.touchUpInside)

        self.view.addSubview(bt)
    
    }

    
    
    @objc func click(_ sender:UIButton){
        

        let actonSheetView   = SLActionSheetView.init(self, "我只是一个测试", "取消", "kkk","99")
 
         actonSheetView.show { (actionSheet, selectIndex) in
           
            
             print("----- \(actionSheet! ) + \(selectIndex!)")
        }
        
        
        
    }
    
    
    func actionSheetCompleted(_ actionSheet: SLActionSheetView, _ selectIndex: NSInteger) {
        
        
        print("\(actionSheet ) + \(selectIndex)")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

