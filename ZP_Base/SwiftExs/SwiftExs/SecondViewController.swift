//
//  SecondViewController.swift
//  SwiftExs
//
//  Created by zhangpoor on 16/7/4.
//  Copyright © 2016年 zhangpoor. All rights reserved.
//

import UIKit
import SnapKit


class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.gray
        
        let v001 = UIView()
        v001.backgroundColor = UIColor.red
        //v001.frame = CGRect.init(x: 10, y: 100, width: 100, height: 100);
        self.view.addSubview(v001)
        
        
        v001.snp.makeConstraints { (make) in
            make.left.top.equalTo(self.view).offset(50);
            make.right.bottom.equalTo(self.view).offset(-70);
            
        }
        
        
        let v002 = UIView()
        v002.backgroundColor = UIColor.yellow
        v001.addSubview(v002)
        
        v002.snp.makeConstraints { (make) in
            //make.topMargin.leftMargin.bottomMargin.rightMargin.equalTo(v001).offset(30)
            make.left.top.equalTo(v001).offset(50);
            make.width.height.equalTo(300);
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

