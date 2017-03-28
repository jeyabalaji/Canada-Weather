//
//  ViewController.swift
//  XMLParsingDemo
//
//
//

import UIKit

class ViewController: UIViewController, NSXMLParserDelegate
{
    @IBOutlet var tbData : UITableView?
    var recstr:String!
    var parser = NSXMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var title1 = NSMutableString()
    var date = NSMutableString()
    var list = ["A"]
    var list2 = ["y"]
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.beginParsing()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func beginParsing()
    {
        posts = []
        parser = NSXMLParser(contentsOfURL:(NSURL(string:recstr))!)!
        parser.delegate = self
        parser.parse()
        
        tbData!.reloadData()
    }
    
    //XMLParser Methods
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
        element = elementName
        if (elementName as NSString).isEqualToString("entry")
        {
            elements = NSMutableDictionary()
            elements = [:]
            title1 = NSMutableString()
            title1 = ""
            date = NSMutableString()
            date = ""
        }
        
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if (elementName as NSString).isEqualToString("entry") {
            if !title1.isEqual(nil) {
                elements.setObject(title1, forKey: "title")
                
            }
            if !date.isEqual(nil) {
                elements.setObject(date, forKey: "summary")
            }
            
            posts.addObject(elements)
            print(posts[0])
            
                    }
        
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String)
    {
        if element.isEqualToString("title") {
            title1.appendString(string)
            
            //print("title1")
        } else if element.isEqualToString("summary") {
            date.appendString(string)
           //            print(date)
//            print("date")
        }
        
    }
    
    //Tableview Methods
    
    

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return posts.count
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell")!
        
        if(cell.isEqual(NSNull)) {
            cell = NSBundle.mainBundle().loadNibNamed("Cell", owner: self, options: nil)[0] as! UITableViewCell;
            
        }
       var test = posts.objectAtIndex(1).valueForKey("title") as! NSString as String
       print(test)
       var test2 = posts.objectAtIndex(1).valueForKey("summary") as! NSString as String
       //print(test2)
        
        var k =  posts.objectAtIndex(indexPath.row).valueForKey("title") as! NSString as String
        var o = posts.objectAtIndex(indexPath.row).valueForKey("summary") as! NSString as String
        for i in 0...1{
            list.insert(k, atIndex: i)
            //print(list)
            list2.insert(o, atIndex: i)
            //print(list2)
        }
        
        cell.textLabel?.text = posts.objectAtIndex(indexPath.row).valueForKey("title") as! NSString as String
        cell.detailTextLabel?.text = posts.objectAtIndex(indexPath.row).valueForKey("summary") as! NSString as String
        
        
        return cell as UITableViewCell
    }
    
     func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if(indexPath.row % 2 == 0){
            cell.backgroundColor = UIColor(patternImage: UIImage(named: "color1")!)
        }
        else{
            cell.backgroundColor = UIColor(patternImage: UIImage(named: "color2")!)
        }
    }

    
    
}
