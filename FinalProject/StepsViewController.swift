//
//  StepsViewController.swift
//  FinalProject
//
//  Created by Araballi, Pawan on 12/13/16.
//  Copyright © 2016 edu.uncc.cs6010. All rights reserved.
//

import UIKit
import Alamofire
var reviewQuestions = [StepsQuestions]()
var currentstep = 1

class StepsViewController: UIViewController {
    
    var StepsQuestion = [StepsQuestions]()
    var index : Int = 0
    
    
    @IBOutlet weak var questionsText: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        slideButton.target = revealViewController()
        slideButton.action = #selector(SWRevealViewController.revealToggle(animated:))
        gReviewButton.isHidden = true
        loadQuestions()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var slideButton: UIBarButtonItem!
    @IBOutlet weak var yButton: DesignableButtonClass!
    @IBOutlet weak var nButton: DesignableButtonClass!
    @IBOutlet weak var gReviewButton: DesignableButtonClass!
    @IBAction func yesButton(_ sender: UIButton) {
        index += 1
        displayQuestion()
    }
    @IBAction func noButton(_ sender: UIButton) {
        index += 1
        displayQuestion()
    }
    @IBAction func goToReview(_ sender: UIButton) {
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
        
    func loadQuestions(){
            Alamofire.request("http:54.197.12.149/user/Steps?token=\(token)").responseJSON { (response) in
                let a = response.result.value as? Dictionary<String,AnyObject>
                let qustns = a?["data"] as? NSArray
                self.StepsQuestion.removeAll()
                if(qustns != nil){
                    for q in qustns!{
                        let adata = q as? Dictionary<String,AnyObject>
                        let step = adata?["step"] as! String
                        let sstep = step.components(separatedBy: ".")
                        if sstep[0] == "\(currentstep)" {
                            let question = adata?["question"] as! String
                            self.StepsQuestion.append(StepsQuestions(step:step, question:question))
                            reviewQuestions.append(StepsQuestions(step:"YES", question:question))
                        }
                    }
                    
                }else if(qustns == nil){
                    let alertController = UIAlertController(title: "Connection Issue", message: "Check the connection with server", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Connection Issue", style: .default, handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                }
                DispatchQueue.main.async{
                    print(self.StepsQuestion.count)
                }
                self.displayQuestion()
            
        }
            
        
    
    }
    
    func displayQuestion(){
        if index == StepsQuestion.count {
            questionsText.isHidden = true
            yButton.isHidden = true
            nButton.isHidden = true
            gReviewButton.isHidden = false
        }else{
            questionsText.text = StepsQuestion[index].question
        }
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
