//
//  ViewController.swift
//  swiftsample20140813
//
//  Created by Takashi Ikeda on 2014/08/13.
//  Copyright (c) 2014年 TI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var testLabel1: UILabel!
    
    // 任意テキスト
    @IBOutlet weak var userDataTextValueTest: UITextField!
    // 任意テキストのキー
    @IBOutlet weak var userDataTextKeyTest: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        userDataTextKeyTest.text = "testkey"
        userDataTextValueTest.text = "testValue"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func getNowString() -> String{
        
        let now = NSDate()
        var nowString = createDateFormatter().stringFromDate(now)
        
        println(nowString)
        
        return nowString
    }
    
    private func SaveTest(){
    }
    
    private func createDateFormatter() -> NSDateFormatter{
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP") // ロケールの設定
//        
//        dateFormatter.timeStyle = .NoStyle // 時刻のスタイルの設定
//        dateFormatter.dateStyle = .NoStyle // 日付のスタイルの設定
////        println(dateFormatter.stringFromDate(now)) // -> 出力されない
//        
//        dateFormatter.timeStyle = .ShortStyle
//        dateFormatter.dateStyle = .ShortStyle
//        println(dateFormatter.stringFromDate(now)) // -> 2014/06/24 11:14
        
        dateFormatter.timeStyle = .MediumStyle
        dateFormatter.dateStyle = .MediumStyle
//        println(dateFormatter.stringFromDate(now)) // -> 2014/06/24 11:14:17
        
//        dateFormatter.timeStyle = .LongStyle
//        dateFormatter.dateStyle = .LongStyle
////        println(dateFormatter.stringFromDate(now)) // -> 2014年6月24日 11:14:17 JST
//        
//        dateFormatter.timeStyle = .FullStyle
//        dateFormatter.dateStyle = .FullStyle
////        println(dateFormatter.stringFromDate(now)) // -> 2014年6月24日火曜日 11時14分17秒 日本標準時
//        
//        dateFormatter.timeStyle = .NoStyle // 時刻だけ表示させない
//        dateFormatter.dateStyle = .FullStyle
//        println(dateFormatter.stringFromDate(now)) // -> 2014年6月24日火曜日
        
        return dateFormatter
    }

    @IBAction func loadButtonTapped(sender: AnyObject) {
        var kv = NSUserDefaults.standardUserDefaults()
        userDataTextValueTest.text = kv.stringForKey(userDataTextKeyTest.text)
    }
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        var kv = NSUserDefaults.standardUserDefaults()
        var value = userDataTextValueTest.text
        var key = userDataTextKeyTest.text
        kv.setObject(value, forKey: key)
        var ret = kv.synchronize()
    }
    
    @IBAction func testButton1Tapped(sender : AnyObject) {
        
        var nowString = getNowString()
        testLabel1.text = "clicked_\(nowString)"
    }
}

