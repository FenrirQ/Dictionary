//
//  V_E.swift
//  Dictionary
//
//  Created by Quang Ly Hoang on 7/15/16.
//  Copyright © 2016 FenrirQ. All rights reserved.
//

import UIKit
import CoreData

class V_E: UIViewController {

    @IBOutlet weak var word: UITextField!
    
    @IBOutlet weak var thongbao: UILabel!
    
    @IBOutlet weak var nghiaE: UILabel!
    @IBOutlet weak var phatam: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dich(sender: AnyObject) {
        
        let tu = word.text
        //tao bien co
        var flag = false
        
        //kiem tra xem co trong hay khong
        if tu!.isEmpty {
            
            let myAlert = UIAlertController(title: "Sorry!", message: "Box is blank !", preferredStyle: .Alert)
            let actionOK = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            myAlert.addAction(actionOK)
            self.presentViewController(myAlert, animated : true, completion : nil)
            
        } else {
            
            //lay data trong Core Data de kiem tra
            let appDel = (UIApplication.sharedApplication().delegate as! AppDelegate)
            let context: NSManagedObjectContext = appDel.managedObjectContext
            
            let request = NSFetchRequest(entityName: "Words")
            
            do {
                let results = try context.executeFetchRequest(request)
                if results.count > 0 {
                    
                    for i in 0...(results.count - 1){
                        let res = results[i] as! NSManagedObject
                        let tuAnh = res.valueForKey("vietnamese") as? String
                        if tuAnh == tu {
                            
                            nghiaE.text = "Meaning: \(res.valueForKey("english")!)"
                            phatam.text = "Pronounce: / \(res.valueForKey("pronounce")!) /"
                            //phat co
                            flag = true
                            break
                            
                        }
                    }
                    
                    if flag == false {
                        
                        thongbao.text = "Sorry, there is not word which you need !"
                        nghiaE.text = ""
                        phatam.text = ""
                        
                    }
                    
                } else {
                    print("0 Result Returned ... Potential Error")
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
