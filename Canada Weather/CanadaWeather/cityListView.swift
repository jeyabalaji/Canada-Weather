//
//  cityListView.swift
//  XMLParsingDemo
//
//  Created by Jeya Balaji on 01/11/16.
//  Copyright © 2016. All rights reserved.
//

import UIKit
import CoreData

class cityListView: UITableViewController{
    
    @IBOutlet weak var test: UILabel!
    private var menuItems:[MenuItem] = []
    var fetchResultController:NSFetchedResultsController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load menu items from database
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
            
            let fetchRequest = NSFetchRequest(entityName: "MenuItem")
            do {
                menuItems = try managedObjectContext.executeFetchRequest(fetchRequest) as! [MenuItem]
            } catch {
                print("Failed to retrieve record")
                print(error)
            }
        }
        
        // Make the cell self size
        tableView.estimatedRowHeight = 66.0
        tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.backgroundColor = UIColor(patternImage: UIImage(named: "bgimage")!)    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return menuItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! MenuTableViewCell
        
        
        // Configure the cell...
        cell.city.text = menuItems[indexPath.row].detail//cityname
//        cell.url.text = menuItems[indexPath.row].name  //url
        cell.Province.text = menuItems[indexPath.row].price //province
        var selected_city = menuItems[indexPath.row].detail
        
        
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedCity = self.menuItems[indexPath.row]
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {

        if(indexPath.row % 2 == 0){
            cell.backgroundColor = UIColor(patternImage: UIImage(named: "color1")!)
        }
        else{
            cell.backgroundColor = UIColor(patternImage: UIImage(named: "color2")!)
        }
    }
    
    
    let SegueIdentifier = "transSegue"
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if  segue.identifier == SegueIdentifier,
            
            let destination = segue.destinationViewController as? detailViewController,
            blogIndex = tableView.indexPathForSelectedRow?.row
            
        {   let cell = sender as! UITableViewCell
            destination.urlstr = menuItems[blogIndex].name

        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
}
