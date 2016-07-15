//
//  CheckAdim.swift
//  Dictionary
//
//  Created by Quang Ly Hoang on 7/13/16.
//  Copyright © 2016 FenrirQ. All rights reserved.
//

import UIKit

class CheckAdim: UIViewController {

    @IBOutlet weak var pass: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func check(sender: AnyObject) {
        //tao mat khau
        if pass.text == "spiderman4996" {
            
            //neu dung mat khau
            let myAlert = UIAlertController(title: "Chúc mừng !", message: "Bạn là Admin !", preferredStyle: .Alert)
            let actionOK = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {(paramAction: UIAlertAction!)in self.performSegueWithIdentifier("goToEdit", sender: self)})
            myAlert.addAction(actionOK)
            self.presentViewController(myAlert, animated : true, completion : nil)
            self.performSegueWithIdentifier("goToEdit", sender: self)
            
        //neu sai mat khau
        } else {
            let myAlert = UIAlertController(title: "Sorry !", message: "Mật khẩu chưa đúng !", preferredStyle: .Alert)
            let actionOK = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            myAlert.addAction(actionOK)
            self.presentViewController(myAlert, animated : true, completion : nil)
            
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
