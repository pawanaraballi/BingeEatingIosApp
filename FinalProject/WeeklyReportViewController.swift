//
//  WeeklyReportViewController.swift
//  FinalProject
//
//  Created by Kranthi Chinnakotla on 11/3/16.
//  Copyright © 2016 edu.uncc.cs6010. All rights reserved.
//

import UIKit
import SDCAlertView

var weightTextField: UITextField?
var currentWeight: String?

class WeeklyReportViewController: UIViewController {

    @IBOutlet weak var weightUpdates: UITextField!
    @IBAction func actionBarButton(_ sender: UIBarButtonItem) {
//        let vc = ViewController()
//        
//        self.revealViewController().setRear(vc, animated: true)
        
        }
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    
    
    @IBAction func addWeight(_ sender: UIBarButtonItem) {
        
        let weightCotroller = AlertController(title: "Update Weight", message: "Edit or Enter your weight", preferredStyle: .alert)
        weightCotroller.addTextField { (textField) in
            
            currentWeight = textField.text!
            self.weightUpdates = textField
            
        }
        weightCotroller.add(AlertAction(title: "OK", style: .preferred))
        self.present(weightCotroller, animated: true, completion: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if(currentWeight != nil){
            weightUpdates.text = currentWeight
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        menuButton.target = revealViewController()
        menuButton.action = #selector(SWRevealViewController.revealToggle(animated:))
        self.view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        // Do any additional setup after loading the view.
        
        
       
        
        let coach = AlertController(title: "Weekly Log", message: "Click on the add sign on the top, to add your weekly weight", preferredStyle: .alert)
        //coach.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        coach.add(AlertAction(title: "OK", style: .normal))
        coach.view.addSubview(imageV!)
        self.present(coach, animated: true, completion: nil)
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
