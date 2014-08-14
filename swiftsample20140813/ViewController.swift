//
//  ViewController.swift
//  swiftsample20140813
//
//  Created by Takashi Ikeda on 2014/08/13.
//  Copyright (c) 2014年 TI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var memoId : String?
    
    @IBOutlet weak var testLabel1: UILabel!
    
    // 任意テキスト
    @IBOutlet weak var userDataTextValueTest: UITextField!
    // 任意テキストのキー
    @IBOutlet weak var userDataTextKeyTest: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        userDataTextKeyTest.text = self.memoId
//        userDataTextValueTest.text = "testValue"
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
    
    // 画面⇄データオブジェクトを簡単に実現する仕組みがありそうだけど
    private func getViewData() -> CoffeeMemoData {
        var memoData = CoffeeMemoData()
        
        memoData.id = self.userDataTextKeyTest!.text
        memoData.name = self.userDataTextValueTest!.text
        
        return memoData
    }
    
    private func setViewData(memoData : CoffeeMemoData){
        self.userDataTextKeyTest.text = memoData.id
        self.userDataTextValueTest.text = memoData.name
    }
    
    // ジェネリクスなんかで汎用的にできないかな どんなクラスでも同じ処理だよね
    private func saveMemoData(memoData : CoffeeMemoData){
        
        // NSUserDefaultsクラスのインスタンスを取得
        let defaults = NSUserDefaults.standardUserDefaults()
        
        var memoDataBinary = NSKeyedArchiver.archivedDataWithRootObject(memoData)
        
        // 保存するオブジェクトをキーと共に設定
        defaults.setObject(memoDataBinary, forKey: self.memoId)
        // ファイルに書き出す
        let success = defaults.synchronize()

        if success {
            println("保存に成功")
        }
    }
    
    private func loadMemoData(id : String) -> CoffeeMemoData{
        
        let defaults = NSUserDefaults.standardUserDefaults()
        var memoDataBinary = defaults.objectForKey(id) as NSData
        
        var memoData = NSKeyedUnarchiver.unarchiveObjectWithData(memoDataBinary) as CoffeeMemoData
        
        return memoData ?? CoffeeMemoData(id : id, name : "")
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
//        var kv = NSUserDefaults.standardUserDefaults()
//        userDataTextValueTest.text = kv.stringForKey(userDataTextKeyTest.text)
        
        self.setViewData(self.loadMemoData(self.userDataTextKeyTest.text))
    }
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
//        var kv = NSUserDefaults.standardUserDefaults()
//        var value = userDataTextValueTest.text
//        var key = userDataTextKeyTest.text
//        kv.setObject(value, forKey: key)
//        var ret = kv.synchronize()
        
        self.saveMemoData(self.getViewData())
    }
    
    @IBAction func testButton1Tapped(sender : AnyObject) {
        
        var nowString = getNowString()
        testLabel1.text = "clicked_\(nowString)"
    }
    
    func clearData(){
        /*
        NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
        [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
*/
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        println("editor prepareForSegue")
    }
}

