//
//  CoffeeMemoData.swift
//  swiftsample20140813
//
//  Created by Takashi Ikeda on 2014/08/14.
//  Copyright (c) 2014年 TI. All rights reserved.
//

import UIKit

class CoffeeMemoData: NSObject, NSCoding {
    
    var id : String!
    var name : String!
    
    override init(){
        super.init()
    }
    
    init (id : String, name : String){
        self.id = id
        self.name = name
    }
    
    func encodeWithCoder(aCoder: NSCoder!) {
        // Int型のエンコード
//        aCoder.encodeInteger(self.id, forKey: "ID")
        
        // IDはIntのほうがよいけど、NSUserDefaultsのキーがStringなのでひとまずString
        // String型のエンコード
        aCoder.encodeObject(self.id, forKey: "ID")
        aCoder.encodeObject(self.name, forKey: "NAME")
    }
    
    // initializerの定義にはfuncは不要
    required init(coder aDecoder: NSCoder!) {
        
        super.init()
        
        // Int型のデコード
//        self.id = aDecoder.decodeIntegerForKey("ID")
        // String型のデコード
        self.id = aDecoder.decodeObjectForKey("ID") as String
        self.name = aDecoder.decodeObjectForKey("NAME") as String
    }
}
