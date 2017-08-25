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
    
    @IBOutlet weak var ErrorLabel: UILabel!
    @IBOutlet weak var loginField: UITextField!
    @IBAction func searchButton(sender: UIButton) {
        
    }
    
    struct apiData {
        static var token = ""
        static let UID  = ""
        static let SECRET = ""
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
        var login : String
        login = loginField.text!
        if login == ""{
            self.ErrorLabel.text = "Erreur login"
            return false
        }
        //login = login.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        //
        let charSet = NSCharacterSet(charactersInString: "abcdefghijklmnopqrstuvwxyz-").invertedSet
        //login = login.componentsSeparatedByCharactersInSet(charSet).joinWithSeparator("")
        if login.rangeOfCharacterFromSet(charSet) != nil || login.lowercaseString.characters.contains("."){
            self.ErrorLabel.text = "Erreur login"
            return false
        }
        print(login)
        login = login.stringByReplacingOccurrencesOfString(" ", withString: "")
        if (apiData.token == "" || !isvalid()) {
            let semaphore = dispatch_semaphore_create(0)
            let request = NSMutableURLRequest(URL: apiData.posturl!)
            request.HTTPMethod = "POST"
            request.HTTPBody = ("grant_type=client_credentials&client_id="+apiData.UID+"&client_secret="+apiData.SECRET).dataUsingEncoding(NSUTF8StringEncoding)
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request){
                (data, response, error) -> Void in
                if error != nil {
                    print(error)
                    iserror = "1"
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
                            if let urlImg = dic["image_url"] as? String{
                                iserror = "0"
                            }
                            else{
                                iserror = "1"
                            }
                            self.resultApi = dic
                            datasecond = dic
                            
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
            self.ErrorLabel.text = "Login inconnu"
            return false}
        else{
            self.ErrorLabel.text = ""
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
