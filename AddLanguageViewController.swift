//
//  AddLanguageViewController.swift
//  helpme
//
//  Created by Yahya Mokaied on 21/06/2020.
//  Copyright © 2020 Yahya Mokaied. All rights reserved.
//

import UIKit

class AddLanguageViewController: UIViewController , UITableViewDataSource,UITableViewDelegate {
    
    var userLanguage = ""
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return langArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "langCell", for: indexPath)
        cell.textLabel?.text = langArr[indexPath.row]
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "moveToTask"){
            let secondVC : AddTaskController =  segue.destination as! AddTaskController
            
            secondVC.languageSeg = self.userLanguage

            
        }
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
                 var selectedLanguage = ""
                 
              let selected = tableView.cellForRow(at: indexPath)!
                         let labelTxt = selected.textLabel?.text
                         selectedLanguage = labelTxt ?? ""
                         userLanguage = selectedLanguage
                         print(userLanguage)
        performSegue(withIdentifier: "moveToTask", sender: self)

    }
    

    @IBOutlet var languagesTV: UITableView!
    @IBAction func AddLangAction(_ sender: Any) {
        
        TestMess()
    }
    
    let langArr : [String] = ["Java" , "Swift", "Objective-C", "C#", "C++", "React", "Flutter", "JavaScript", "Python", "Perl", "SQL"]
    @IBOutlet var AddBtnOutlet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        languagesTV.dataSource = self
        languagesTV.delegate = self

        // Do any additional setup after loading the view.
    }
    
    func TestMess()  {
        print("Hej")
    }
    

    func ProgSelected()  {
        print("prog")
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
