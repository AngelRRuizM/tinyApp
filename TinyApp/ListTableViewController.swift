//
//  ListTableViewController.swift
//  TinyApp
//
//  Created by Alumno on 28/05/18.
//  Copyright © 2018 Alumno. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {
    
    var habitsList = NSMutableArray()
    var  menuDictionary = NSMutableDictionary()
    
    @IBOutlet weak var roullete: UIBarButtonItem!
    
    var selected: String? {
        didSet{
            self.configureView()
        }
    }
    
    func loadPlist(){
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let documentsDirectory = paths[0] as! NSString
        let path = documentsDirectory.appendingPathComponent("Habits.plist")
        let fileManager = FileManager.default
        
        if !fileManager.fileExists(atPath: path){
            if let bundlePath = Bundle.main.path(forResource: "Habits", ofType:"plist"){
                do{
                    try fileManager.copyItem(at: URL(fileURLWithPath: bundlePath), to: URL(fileURLWithPath: path))
                }
                catch{
                    print("Error: Couldnt find load plist")
                }
            }
        }
        
        menuDictionary = NSMutableDictionary(contentsOfFile: path)!
        if let type = self.selected{
            habitsList = NSMutableArray(array: menuDictionary.object(forKey: type) as! [Any])
            self.navigationItem.title = type
        }
    }
    
    func savePlist(){
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let documentsDirectory = paths[0] as! NSString
        let path = documentsDirectory.appendingPathComponent("Habits.plist")
        
        if let type = self.selected {
            menuDictionary.setObject(habitsList, forKey: type as NSCopying)
            menuDictionary.write(toFile: path, atomically: false)
            self.loadPlist()
        }
    }
    
    func configureView(){
        if let sel = self.selected {
            self.title = sel
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadPlist()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 75
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            habitsList.removeObject(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            self.savePlist()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habitsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "HabitCell", for: indexPath) as! HabitTableViewCell
        let object = habitsList[indexPath.row] as! String
        let spaceIndex = object.index(of: " ") ?? object.endIndex
        let title = object[..<spaceIndex]
        let subtitle = object[object.index(after: spaceIndex)..<object.endIndex]
        
        cell.titleTxt.text = String(title)
        cell.subtitleTxt.text = String(subtitle)
        
        if selected == "Mental Health" {
            cell.icon.image = UIImage(named: "brain")
        } else if selected == "Physical Health" {
            cell.icon.image = UIImage(named: "muscle")
        } else if selected == "Productivity & Work"{
            cell.icon.image = UIImage(named: "case")
        } else if selected == "Love, Family & Friends"{
            cell.icon.image = UIImage(named: "heart")
        } else if selected == "Community & Environment"{
            cell.icon.image = UIImage(named: "leaf")
        } else if selected == "Personal Finances" {
            cell.icon.image = UIImage(named: "money")
        }
        
        return cell
        
    }
    
    @IBAction func addHabit(_ sender: Any) {
        print("lol")
        let alert = UIAlertController(title: "New Habit", message: "Describe your new habit", preferredStyle: .alert)
        alert.addTextField{ textField-> Void in
            textField.placeholder = "My new habit will be..."
            
        }
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: {(UIAlertAction) in
            if let habit = alert.textFields![0].text {
                self.habitsList.insert(habit as Any, at: 0)
                self.tableView.beginUpdates()
                self.tableView.insertRows(at: [IndexPath.init(row: 0, section: 0)], with: .automatic)
                self.tableView.endUpdates()
                self.savePlist()
            }
        }))
        self.present(alert, animated: true)
    }
    
    @IBAction func share(_ sender: Any) {
        
        var imageToShare = UIImage()
        
        if selected == "Mental Health" {
            imageToShare = UIImage(named: "brain")!
        } else if selected == "Physical Health" {
            imageToShare = UIImage(named: "muscle")!
        } else if selected == "Productivity & Work"{
            imageToShare = UIImage(named: "case")!
        } else if selected == "Love, Family & Friends"{
            imageToShare = UIImage(named: "heart")!
        } else if selected == "Community & Environment"{
            imageToShare = UIImage(named: "leaf")!
        } else if selected == "Personal Finances" {
            imageToShare = UIImage(named: "money")!
        }
        
        var message = ""
        if self.selected != nil {
            message = "I'm climbing my way to the top of my \(selected!)! One tiny habit at a atime"
        }
        else{
            message = "I'm climbing my way to the top! One tiny habit at a atime"
        }
        
        
        let avc = UIActivityViewController(
                    activityItems: [message, imageToShare], applicationActivities: nil
        )
        avc.popoverPresentationController?.sourceView = self.view
    
        present(avc, animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toRoullete" {
            (segue.destination as! RoulleteViewController).selected = selected
        }
    }
}
