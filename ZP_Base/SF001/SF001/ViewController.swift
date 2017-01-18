//
//  ViewController.swift
//  SF001
//
//  Created by zhangpoor on 16/10/20.
//  Copyright © 2016年 zhangpoor. All rights reserved.
//

import UIKit

import F001

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("bbbb");
        
        let c:ClassA =  ClassA();
        
        let s:String = c.f001(keyPath: "abc");
        
        
        print("\(s)");
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

