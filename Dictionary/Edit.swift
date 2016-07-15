//
//  Edit.swift
//  Dictionary
//
//  Created by Quang Ly Hoang on 7/13/16.
//  Copyright © 2016 FenrirQ. All rights reserved.
//

import UIKit
import CoreData

class Edit: UIViewController {
    
    //dung cho them tu
    @IBOutlet weak var themE: UITextField!
    @IBOutlet weak var themV: UITextField!
    @IBOutlet weak var themAm: UITextField!
    
    //dung cho xoa tu
    @IBOutlet weak var xoaE: UITextField!
    
    //dung cho doi tu
    @IBOutlet weak var doiE: UITextField!
    @IBOutlet weak var doiV: UITextField!
    @IBOutlet weak var doiAm: UITextField!
    
    //dung cho core data
    var words = [NSManagedObject]()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func themAction(sender: AnyObject) {
        
        let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context: NSManagedObjectContext = appDel.managedObjectContext
        let entity = NSEntityDescription.entityForName("Words", inManagedObjectContext: context)
        let newWord = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: context)
        
        let themEnglish = themE.text
        let themVietnam = themV.text
        let phatam = themAm.text
        
        //bien co
        var flag = true
        
        //kiem tra xem con o trong khong
        if themEnglish!.isEmpty || themVietnam!.isEmpty || phatam!.isEmpty {
            
            let myAlert = UIAlertController(title: "Sorry !", message: "Bạn điền chưa đủ !", preferredStyle: .Alert)
            let actionOK = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            myAlert.addAction(actionOK)
            self.presentViewController(myAlert, animated : true, completion : nil)
            
        } else {
            
            let appDel = (UIApplication.sharedApplication().delegate as! AppDelegate)
            let context: NSManagedObjectContext = appDel.managedObjectContext
            
            let request = NSFetchRequest(entityName: "Words")
            do {
                
                //goi data trong core data de kiem tra
                let results = try context.executeFetchRequest(request)
                
                if results.count > 0 {
                    
                    for i in 0...(results.count - 1){
                        
                        let res = results[i] as! NSManagedObject
                        if themEnglish == res.valueForKey("english") as? String {
                            
                            //phat co neu tu bi trung
                            flag = false
                            
                            let myAlert = UIAlertController(title: "Thông báo", message: "Từ đã có sẵn !", preferredStyle: .Alert)
                            let actionOK = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
                            myAlert.addAction(actionOK)
                            self.presentViewController(myAlert, animated : true, completion : nil)
                            break
                            
                        }
                        
                    }
                }
                
            } catch let error as NSError {
                print("Fetch failed: \(error.localizedDescription)")
            }
            
            //neu khong co tu bi trung
            if flag == true {
                
                newWord.setValue(themE.text, forKey: "english")
                newWord.setValue(themV.text, forKey: "vietnamese")
                newWord.setValue(themAm.text, forKey: "pronounce")
                
                do {
                    
                    try context.save()
                    
                } catch {
                    
                    fatalError("Failure to save context: \(error)")
                    
                }
                
                
                let myAlert = UIAlertController(title: "", message: "Đã thêm từ mới !", preferredStyle: .Alert)
                let actionOK = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
                myAlert.addAction(actionOK)
                self.presentViewController(myAlert, animated : true, completion : nil)
                
            }
            
        }
    }
    
    
    @IBAction func xoaAction(sender: AnyObject) {
        
        //bien co
        var flag : Bool = false
        
        let xoaEnglish = xoaE.text
        
        //kiem tra xem con o trong khong
        if xoaEnglish!.isEmpty {
            
            let myAlert = UIAlertController(title: "Sorry !", message: "Bạn chưa nhập đầy đủ !", preferredStyle: .Alert)
            let actionOK = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            myAlert.addAction(actionOK)
            self.presentViewController(myAlert, animated: true, completion: nil)
            
        }
        else {
            
            let appDel = (UIApplication.sharedApplication().delegate as! AppDelegate)
            let context: NSManagedObjectContext = appDel.managedObjectContext
            
            let request = NSFetchRequest(entityName: "Words")
            do {
                
                //goi data trong core data de kiem tra
                let results = try context.executeFetchRequest(request)
                
                if results.count > 0 {
                    
                    for i in 0...(results.count - 1){
                        
                        let res = results[i] as! NSManagedObject
                        if xoaEnglish == res.valueForKey("english") as? String {
                            
                            //phat co neu co tu de xoa
                            flag = true
                            context.deleteObject(res)
                            do {
                                
                                try context.save()
                                
                            } catch {
                                
                                fatalError("Failure to save context: \(error)")
                                
                            }
                            let myAlert = UIAlertController(title: "", message: "Đã xoá từ !", preferredStyle: .Alert)
                            let actionOK = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
                            myAlert.addAction(actionOK)
                            self.presentViewController(myAlert, animated: true, completion: nil)
                            break
                        }
                        
                    }
                    //neu khong co tu de xoa
                    if flag == false {
                        
                        let myAlert = UIAlertController(title: "Sorry !", message: "Không có từ cần xoá !", preferredStyle: .Alert)
                        let actionOK = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
                        myAlert.addAction(actionOK)
                        self.presentViewController(myAlert, animated: true, completion: nil)
                        
                    }
                //neu khong co tu nao trong tu dien
                }else{
                    
                    let myAlert = UIAlertController(title: "Sorry !", message: "Chưa có từ nào trong từ điển !", preferredStyle: .Alert)
                    let actionOK = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
                    myAlert.addAction(actionOK)
                    self.presentViewController(myAlert, animated: true, completion: nil)
                    
                }
                
            } catch let error as NSError {
                print("Fetch failed: \(error.localizedDescription)")
            }

        }
        
    }
    
    
    @IBAction func doiAction(sender: AnyObject) {
        
        //tao bien co
        var flag = false
        
        let doiEnglish = doiE.text
        let doiViet = doiV.text
        let doiam = doiAm.text
        
        //neu co o trong
        if doiEnglish!.isEmpty || doiViet!.isEmpty || doiam!.isEmpty {
            
            let myAlert = UIAlertController(title: "Sorry !", message: "Bạn chưa điền đầy đủ !", preferredStyle: .Alert)
            let actionOK = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            myAlert.addAction(actionOK)
            self.presentViewController(myAlert, animated: true, completion: nil)
            
        } else {
            
            let appDel = (UIApplication.sharedApplication().delegate as! AppDelegate)
            let context: NSManagedObjectContext = appDel.managedObjectContext
            
            let request = NSFetchRequest(entityName: "Words")
            do {
                
                //lay data trong core data de kiem tra
                let results = try context.executeFetchRequest(request)
                //print(results.count)
                if results.count > 0 {
                    
                    for i in 0...(results.count - 1){
                        
                        let res = results[i] as! NSManagedObject
                        if doiEnglish == res.valueForKey("english") as? String {
                            
                            //tim thay tu thi phat co
                            flag = true
                            res.setValue(doiViet, forKey: "vietnamese")
                            res.setValue(doiam, forKey: "pronounce")
                            do {
                                
                                try context.save()
                                
                            } catch {
                                
                                fatalError("Failure to save context: \(error)")
                                
                            }
                            let myAlert = UIAlertController(title: "", message: "Đã thay đổi từ !", preferredStyle: .Alert)
                            let actionOK = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
                            myAlert.addAction(actionOK)
                            self.presentViewController(myAlert, animated: true, completion: nil)
                            break
                        }
                        
                    }
                    
                    //neu khong co tu can tim
                    if flag == false {
                        
                        let myAlert = UIAlertController(title: "Sorry !", message: "Không có từ cần thay đổi !", preferredStyle: .Alert)
                        let actionOK = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
                        myAlert.addAction(actionOK)
                        self.presentViewController(myAlert, animated: true, completion: nil)
                        
                    }
                
                //neu khong co tu nao trong data
                }else {
                    let myAlert = UIAlertController(title: "Sorry !", message: "Chưa có từ nào trong từ điển !", preferredStyle: .Alert)
                    let actionOK = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
                    myAlert.addAction(actionOK)
                    self.presentViewController(myAlert, animated: true, completion: nil)
                }
            } catch let error as NSError {
                print("Fetch failed: \(error.localizedDescription)")
            }

        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
