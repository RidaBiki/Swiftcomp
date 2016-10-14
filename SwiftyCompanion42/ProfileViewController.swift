//
//  ProfileViewController.swift
//  SwiftyCompanion42
//
//  Created by Rida BIKITARAN on 10/6/16.
//  Copyright © 2016 Rida BIKITARAN. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    // MARK: Properties
    
    var dataFromApi : NSDictionary?
    
    @IBOutlet weak var SkillTable: UITableView!
    @IBOutlet weak var ProjectTable: UITableView!
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
        
        //SkillTable.registerNib(UINib(nibName: "SkillTableViewCell", bundle: nil), forCellReuseIdentifier: "SkillCell")
        SkillTable.registerClass(SkillTableViewCell.self, forCellReuseIdentifier: "Cell")
        SkillTable.delegate = self
        SkillTable.dataSource = self
        self.dataFromApi = datasecond
        let urlImg = dataFromApi!["image_url"] as! String
        if let url = NSURL(string: urlImg) {
            if let data = NSData(contentsOfURL: url) {
                ppImageView.image = UIImage(data: data)
            }        
        }
        //print(dataFromApi!["projects_users"])
        ppImageView.layer.borderWidth = 1
        ppImageView.layer.masksToBounds = false
        ppImageView.layer.borderColor = UIColor.blackColor().CGColor
        ppImageView.layer.cornerRadius = ppImageView.frame.width/2
        ppImageView.clipsToBounds = true
        posteLabel.text = dataFromApi!["location"] as? String
        if (posteLabel.text == nil){
            posteLabel.text = "Non log"
        }
        let test = dataFromApi!["cursus_users"] as! NSMutableArray
        let skills = test[0]["skills"] as! NSMutableArray
        print(skills)
        let truc : Double = test[0]["level"] as! Double
        levelLabel.text = truc.description
        loginLabel.text = dataFromApi!["login"] as? String
        mailLabel.text = dataFromApi!["email"] as? String
        phoneLabel.text = dataFromApi!["phone"] as? String
        // Do any additional setup after loading the view.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! SkillTableViewCell
        let test = dataFromApi!["cursus_users"] as! NSMutableArray
        let skills = test[0]["skills"] as! NSMutableArray
        let eachSkill = skills[indexPath.row]
        print("esdcwesdacfserfeadvgfdsgsersdfgersadfegrwdfsgrewdfgr")
        for key in eachSkill as! NSMutableArray { // PROBLEME ICI CAR N ARRIVE PAS A ACCEDER AUX VALEURS DE 
            // EACHSKILL
            //
            //
            //
            //
            //
            
            if (key == "name"){
                cell.SkillLabel.text = eachSkill[key]
            }
            if (key == "level"){
                let level = eachSkill[key] as! Double
            }
        }
        cell.PercentLabel.text = level.description
        cell.ProgressBar.progress = Float(level / 100)
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let test = dataFromApi!["cursus_users"] as! NSMutableArray
        let skills = test[0]["skills"] as! NSMutableArray
        return skills.count
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
