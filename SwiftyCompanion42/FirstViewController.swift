//
//  FirstViewController.swift
//  SwiftyCompanion42
//
//  Created by Rida BIKITARAN on 10/6/16.
//  Copyright © 2016 Rida BIKITARAN. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var loginField: UITextField!
    @IBAction func searchButton(sender: UIButton) {
        
    }
    
    struct apiData {
        static var token = ""
        static let UID  = "f63ee21058be648daedcfb3a784407c9df028f1a714be8a4d2ff6399f443d259"
        static let SECRET = "3bf014d19ce214fba61a59d37f5c51be9b62db5657d4d7bac5721ef7a7cddcb8"
        static let posturl = NSURL(string: "https://api.intra.42.fr/oauth/token")
        static let tokenurl = "https://api.intra.42.fr/oauth/token/info"
        static let usersurl = "https://api.intra.42.fr/v2/users"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        loginField.text = ""
    }
    
    func isvalid() -> Bool {
        let seturlrequest = apiData.tokenurl+"?access_token="+apiData.token
        let urlrequest = NSURL(string: seturlrequest)
        let request = NSMutableURLRequest(URL: urlrequest!)
        request.HTTPMethod = "GET"
        var iserror = ""
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request){
            (data, response, error) in
            print(response)
            if let err = error {
                print(error)
                iserror = "1"
            }
            else if let d = data {
                do {
                    if let dic : NSDictionary = try NSJSONSerialization.JSONObjectWithData(d, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary {
                        print(dic)
                    }
                }
                catch (let err){
                    print(err)
                }
            }
        }
        task.resume()
        if iserror == "1"
        {
            return false
        }
        else {
            return true
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if (apiData.token == "" || !isvalid()) {
            let request = NSMutableURLRequest(URL: apiData.posturl!)
            request.HTTPMethod = "POST"
            request.HTTPBody = ("grant_type=client_credentials&client_id="+apiData.UID+"&client_secret="+apiData.SECRET).dataUsingEncoding(NSUTF8StringEncoding)
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request){
                (data, response, error) in
                if let err = error {
                    print(error)
                }
                else if let d = data {
                    do {
                        if let dic : NSDictionary = try NSJSONSerialization.JSONObjectWithData(d, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary {
                            apiData.token = dic["access_token"] as! String
                            print(apiData.token)
                        }
                    }
                    catch (let err){
                        print(err)
                    }
                }
            }
            task.resume()
            return false
        }
        else {
            return true
        }
    }
}