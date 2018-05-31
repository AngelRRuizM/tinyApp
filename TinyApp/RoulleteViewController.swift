//
//  RouletteViewController.swift
//  TinyApp
//
//  Created by Alumno on 31/05/18.
//  Copyright © 2018 Alumno. All rights reserved.
//

import UIKit

class RoulleteViewController: UIViewController {
 
    var selected: String? {
        didSet{
            self.configureView()
        }
    }
    
    func configureView(){
        if let sel = self.selected {
            self.title = sel
        }
    }
    
    var habitsList = NSMutableArray()
    var recomendedList = NSMutableArray()
    var menuDictionary = NSMutableDictionary()
    var menuDictionary2 = NSMutableDictionary()
    
    func loadPlist(){
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let documentsDirectory = paths[0] as! NSString
        let path = documentsDirectory.appendingPathComponent("Habits.plist")
        let path2 = documentsDirectory.appendingPathComponent("Recomended.plist")
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
        
        if !fileManager.fileExists(atPath: path2){
            if let bundlePath2 = Bundle.main.path(forResource: "Recomended", ofType:"plist"){
                do{
                    try fileManager.copyItem(at: URL(fileURLWithPath: bundlePath2), to: URL(fileURLWithPath: path2))
                }
                catch{
                    print("Error: Couldnt find load plist")
                }
            }
        }
        
        menuDictionary = NSMutableDictionary(contentsOfFile: path)!
        menuDictionary2 = NSMutableDictionary(contentsOfFile: path2)!
        if let type = self.selected{
            habitsList = NSMutableArray(array: menuDictionary.object(forKey: type) as! [Any])
            recomendedList = NSMutableArray(array: menuDictionary.object(forKey: type) as! [Any])
            self.navigationItem.title = type
        }
    }
    
    func savePlist(){
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let documentsDirectory = paths[0] as! NSString
        let path = documentsDirectory.appendingPathComponent("Habits.plist")
        let path2 = documentsDirectory.appendingPathComponent("Recomended.plist")
        if let type = self.selected {
            menuDictionary.setObject(habitsList, forKey: type as NSCopying)
            menuDictionary.write(toFile: path, atomically: false)
            menuDictionary.setObject(recomendedList, forKey: type as NSCopying)
            menuDictionary.write(toFile: path2, atomically: false)
            self.loadPlist()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadPlist()
        
        
    }
    
}
