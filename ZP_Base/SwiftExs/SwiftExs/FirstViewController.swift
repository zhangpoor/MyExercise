//
//  FirstViewController.swift
//  SwiftExs
//
//  Created by zhangpoor on 16/7/4.
//  Copyright © 2016年 zhangpoor. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        //dosomething001();
        dosomething002();
    }

    func dosomething001()
    {
        /*
            let 常量
            var 变量
            ?   可以为nil
         */
        
        let _ybw = 1_000_000.000_1;
        print("一百万:\(_ybw)");
        
        //let _a:String = nil;
        let _a:String? = nil;
        print("_a:\(_a)");
        
        let _abc:Double = 4;
        let _aaa:String = "abc" + String(_abc);
        print("abc:\(_abc)");
        print("_aaa:\(_aaa)");
        

        
        //let _aList:Array = ["a1","a2","a3","a4"];
        var _aList:Array = ["a1","a2","a3","a4"];
        _aList[0] = "aa1";
        let _index = 0;
        print("item\(_index):\(_aList[_index])");
        
        
        
        var _aDic:Dictionary = [String:String]();
        _aDic["k0"] = "abc";
        _aDic["k1"] = "bbc";
        _aDic["k2"] = "cbc";
        
        print("dic:\(_aDic)\nk1:\(_aDic["k1"])\ncbc:\(_aDic["cbc"])");
        
        
        
        for (kind,list) in _aDic
        {
            print("k:\(kind),v:\(list)");

        }
        
        
        let _bList:Array = [1,2,3,6,8];
        
        let _r = _bList.map({
            (n:Int) -> Int in
            
            
            let r = n * 3;
            
            return r;
            
        
        });
        
        
        print("_r:\(_r)");
        
        
        let _r02 = _bList.sort()
        {
            print("#0:\($0),#1:\($1)");
            return $0 > $1;
            
        };
        print("_r02:\(_r02)");
        
        let _yz = ("abc",123,true,_bList);
        print("_yz:\(_yz)");
        print("_yz[1]:\(_yz.1)");
        
        let (a,b,c,d) = _yz;
        
        print("a:\(a)");
        print("b:\(b)");
        print("c:\(c)");
        print("d:\(d)");
        
        let (aa,bb,_,dd) = _yz;
        
        print("a:\(aa)");
        print("b:\(bb)");
        print("c:\(c)");
        print("d:\(dd)");
        
        let _yz002 = (abc:"abc",abb:123);
        
        print("_yz002[abc]:\(_yz002.abc)");
        print("_yz002[abb]:\(_yz002.abb)");
        
    }
    
    func dosomething002()
    {
        /*
        let _abc: String? = "abc";
        let _abb: String! = _abc;   _abc可能为nil，所以这边要加!
        */
        let _abc: String! = "abc";
        let _abb: String = _abc;
        
        let _acb: String! = "";//用nil会报错
        
    
        
        if (_acb.isEmpty)
        {
            print("isEmpty");
        }
        else
        {
            print("no isEmpty");
        }
    }

    /*
    func abc(n:Int->Int) -> Array<Int> {
        
        var ary:Array = [Int]();
        //ary.append(n());
        return ary;
    }
     */
    
    
}

