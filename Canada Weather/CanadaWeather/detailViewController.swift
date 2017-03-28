//
//  detailViewController.swift
//  XMLParsingDemo
//
//  Created by Jeya Balaji on 01/11/16.
//  Copyright © 2016. All rights reserved.
//
import UIKit

class detailViewController: UIViewController, NSXMLParserDelegate
{
    
    var urlstr:String?
    var actstr = cityListView?()
    var parser = NSXMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var title1 = NSMutableString()
    var date = NSMutableString()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.beginParsing()
        randImages()
        
    }
    
    func randImages()  {
        let rand = Int(arc4random_uniform(4) + 1)
        if (rand == 1){
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bgimage")!)
        }
        else if(rand == 2){
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bgimage")!)
        }
        else if(rand == 3){
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bgimage")!)
        }
        else if(rand == 4){
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bgimage")!)
        }
        else{
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bgimage")!)
            }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var desc: UITextView!
    @IBOutlet weak var curentcond: UILabel!

 
//"http://weather.gc.ca/rss/city/ns-19_e.xml"
    
    func beginParsing()
    {
        posts = []
        parser = NSXMLParser(contentsOfURL:(NSURL(string:urlstr!))!)!
        parser.delegate = self
        parser.parse()
        setLabelContent()
        //tbData!.reloadData()
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
  
            
        }
        
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String)
    {
        if element.isEqualToString("title") {
            title1.appendString(string)
            
           
        } else if element.isEqualToString("summary") {
            date.appendString(string)
        }
        
    }
    
    

    var blogName = String()
    
    override func viewWillAppear(animated: Bool) {
        var urlstr = blogName
    }
    
    func setLabelContent() {
        var test = posts.objectAtIndex(1).valueForKey("title") as! NSString as String
        self.curentcond.text = test
        curentcond.sizeToFit()
        
        var summary = posts.objectAtIndex(2).valueForKey("summary") as! NSString as String
        self.desc.text = summary
        desc.backgroundColor = UIColor.clearColor()
    }
    
    
    let SegueIdentifier = "newSegue"
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if  segue.identifier == SegueIdentifier
            {
                if let destinationVC = segue.destinationViewController as? ViewController {
                    destinationVC.recstr = urlstr
                }
        }
    }

    
    
}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


