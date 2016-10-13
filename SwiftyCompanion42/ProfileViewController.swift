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
    
    var dataFromApi : NSDictionary?
    
    @IBOutlet weak var posteLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBAction func returnButton(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBOutlet weak var ppImageView: UIImageView!
    
    // MARK: functions
    override func viewDidLoad() {
        super.viewDidLoad()
        //let firstview = storyboard!.instantiateViewControllerWithIdentifier("start") as! FirstViewController
        //self.dataFromApi = firstview.resultApi
        //let res = dataFromApi
        self.dataFromApi = datasecond
        let urlImg = dataFromApi!["image_url"] as! String
        if let url = NSURL(string: urlImg) {
            if let data = NSData(contentsOfURL: url) {
                ppImageView.image = UIImage(data: data)
            }        
        }
        ppImageView.layer.borderWidth = 1
        ppImageView.layer.masksToBounds = false
        ppImageView.layer.borderColor = UIColor.blackColor().CGColor
        ppImageView.layer.cornerRadius = ppImageView.frame.width/2
        ppImageView.clipsToBounds = true
        posteLabel.text = dataFromApi!["location"] as? String
        let test = dataFromApi!["cursus_users"] as! NSMutableArray
        //print(test)
        print(test[0]["level"])
        //levelLabel.text = dataFromApi!["cursus_users"]!["level"] as? Int
        //var dict : NSDictionary = dataFromApi!["cursus_users"] as! NSDictionary
        //if var dict = dataFromApi!["cursus_users"] as! NSDictionary
        //{
          //  let value = dict["level"] as! String
           // levelLabel.text = value
        //}
//        print(toto)
        let truc : Double = test[0]["level"] as! Double
        levelLabel.text = truc.description
        print(levelLabel.text)
        loginLabel.text = dataFromApi!["login"] as? String
        mailLabel.text = dataFromApi!["email"] as? String
        phoneLabel.text = dataFromApi!["phone"] as? String
        
        print("debut res")
        //print(dataFromApi)
        print("fin res")
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
