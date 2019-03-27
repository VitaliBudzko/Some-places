//
//  PlacesViewController.swift
//  Memorable Places
//
//  Created by Sasha Dubikovskaya on 03.02.2019.
//  Copyright © 2019 Memorable Places. All rights reserved.
//

import UIKit

var Places = [Dictionary<String, String>()]
var ActivePlace = -1

class PlacesViewController: UITableViewController {
    
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if let tempPlaces = UserDefaults.standard.object(forKey: "places") as? [Dictionary<String, String>] {
            
            Places = tempPlaces
            
        }
        
        if Places.count == 1 && Places[0].count == 0 {
            
            Places.remove(at: 0)
            
            Places.append(["name" : "Taj Mahal", "lat" : "27.175277", "lon" : "78.042128"])
            
            UserDefaults.standard.set(Places, forKey: "places")
            
        }
        
        ActivePlace = -1
        
        table.reloadData()
        
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            Places.remove(at: indexPath.row)
            
            UserDefaults.standard.set(Places, forKey: "places")
            
            table.reloadData()
            
        }
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return Places.count
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
        
        if Places[indexPath.row]["name"] != nil {
            
            cell.textLabel?.text = Places[indexPath.row]["name"]
            
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        ActivePlace = indexPath.row
        
        performSegue(withIdentifier: "toMap", sender: nil)
        
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
