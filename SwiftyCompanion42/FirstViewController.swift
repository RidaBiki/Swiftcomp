//
//  FirstViewController.swift
//  SwiftyCompanion42
//
//  Created by Rida BIKITARAN on 10/6/16.
//  Copyright © 2016 Rida BIKITARAN. All rights reserved.
//

import UIKit

var datasecond : NSDictionary?

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
    var resultApi : NSDictionary?
    
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
            //print(response)
            if error != nil {
                print(error)
                iserror = "1"
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
        var iserror = ""
        if (apiData.token == "" || !isvalid()) {
            let semaphore = dispatch_semaphore_create(0)
            let request = NSMutableURLRequest(URL: apiData.posturl!)
            request.HTTPMethod = "POST"
            request.HTTPBody = ("grant_type=client_credentials&client_id="+apiData.UID+"&client_secret="+apiData.SECRET).dataUsingEncoding(NSUTF8StringEncoding)
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request){
                (data, response, error) -> Void in
                if error != nil {
                    print(error)
                }
                else if let d = data {
                    do {
                        if let dic : NSDictionary = try NSJSONSerialization.JSONObjectWithData(d, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary {
                            apiData.token = dic["access_token"] as! String
                            print("token OK")
                            print(apiData.token)
                            dispatch_semaphore_signal(semaphore)
                        }
                    }
                    catch (let err){
                        print(err)
                    }
                }
            }
            [task.resume()]
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
        }
        if (apiData.token != "" && isvalid()){
            let semaphore = dispatch_semaphore_create(0)
            var login : String
            login = loginField.text!
            let seturlrequest = apiData.usersurl+"/"+login+"?access_token="+apiData.token
            let urlrequest = NSURL(string: seturlrequest)
            let request = NSMutableURLRequest(URL: urlrequest!)
            request.HTTPMethod = "GET"
            
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request){
                (data, response, error) in
                //print(response)
                if error != nil {
                    print(error)
                    iserror = "1"
                    print("il y a une erreur")
                }
                else if let d = data {
                    do {
                        if let dic : NSDictionary = try NSJSONSerialization.JSONObjectWithData(d, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary {
                            dispatch_semaphore_signal(semaphore)
                            self.resultApi = dic
                            datasecond = dic
                            print(datasecond)
                        }
                    }
                    catch (let err){
                        print(err)
                    }
                }
            }
            [task.resume()]
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)

        }
        if (iserror == "1"){
            return false}
        else{
            return true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "validSegue"){
            let secondview = storyboard!.instantiateViewControllerWithIdentifier("Profile") as! ProfileViewController
            secondview.dataFromApi = resultApi!
        }
    }
}