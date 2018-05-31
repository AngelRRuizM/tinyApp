//
//  ViewController.swift
//  TinyApp
//
//  Created by Alumno on 28/05/18.
//  Copyright © 2018 Alumno. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var selection = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showMental(_ sender: Any) {
        selection = "Mental Health"
        performSegue(withIdentifier: "showList", sender: self)
    }
    
    @IBAction func showPhysical(_ sender: Any) {
        selection = "Physical Health"
        performSegue(withIdentifier: "showList", sender: self)
    }
    
    @IBAction func showWork(_ sender: Any) {
        selection = "Productivity & Work"
        performSegue(withIdentifier: "showList", sender: self)
        
    }
    
    @IBAction func showEnvironment(_ sender: Any) {
        selection = "Community & Environment"
        performSegue(withIdentifier: "showList", sender: self)
        
    }
    
    @IBAction func showRelationships(_ sender: Any) {
        selection = "Love, Family & Friends"
        performSegue(withIdentifier: "showList", sender: self)
        
    }
    
    @IBAction func showFinances(_ sender: Any) {
        selection = "Personal Finances"
        performSegue(withIdentifier: "showList", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showList"{
            (segue.destination as! ListTableViewController).selected = selection
        }
    }
    
}

