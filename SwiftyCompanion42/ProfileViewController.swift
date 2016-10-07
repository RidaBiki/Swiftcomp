//
//  ProfileViewController.swift
//  SwiftyCompanion42
//
//  Created by Rida BIKITARAN on 10/6/16.
//  Copyright © 2016 Rida BIKITARAN. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    // MARK: Properties
    
    @IBAction func returnButton(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBOutlet weak var ppImageView: UIImageView!
    
    // MARK: functions
    override func viewDidLoad() {
        super.viewDidLoad()
        ppImageView.layer.borderWidth = 1
        ppImageView.layer.masksToBounds = false
        ppImageView.layer.borderColor = UIColor.blackColor().CGColor
        ppImageView.layer.cornerRadius = ppImageView.frame.width/2
        ppImageView.clipsToBounds = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
