//
//  ViewController.swift
//  Weather
//
//  Created by Pranav Bhandari on 8/7/16.
//  Copyright © 2016 Pranav Bhandari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func findWeather(sender: AnyObject) {
        self.weatherLabel.hidden = true
        if cityTextField.text != "" {
            let city = String(cityTextField.text!).stringByReplacingOccurrencesOfString(" ", withString: "-")
          //  let city = cityTextField.text
            let attemptedurl = NSURL(string: "http://www.weather-forecast.com/locations/"+city+"/forecasts/latest")
            
            if let url = attemptedurl {
                
                let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
                    
                    if let urlContent = data {
                        let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                        
                        
                        let webSiteArray = webContent?.componentsSeparatedByString("3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                        
                        if webSiteArray!.count > 1 {
                            let weatherArray = webSiteArray![1].componentsSeparatedByString("</span>")
                            print(weatherArray[0])
                            
                            if weatherArray.count > 0 {
                                let weatherSummary = weatherArray[0].stringByReplacingOccurrencesOfString("&deg;", withString:  "°")
                                
                                dispatch_async(dispatch_get_main_queue(), {
                                    self.weatherLabel.text = weatherSummary
                                    self.weatherLabel.hidden = false
                                })
                                
                            }
                        }
                        else
                        {
                            self.weatherLabel.hidden = false
                            self.weatherLabel.text = "Sorry could not find weather for that city, please enter a new city and try again"
                        }
                        
                    }
                    else
                    {
                        self.weatherLabel.hidden = false
                        self.weatherLabel.text = "Sorry could not find weather for that city, please enter a new city and try again"
                    }
                }
                task.resume()
            }
            else
            {
                self.weatherLabel.hidden = false
                self.weatherLabel.text = "Please enter a valid city and try again"
            }
            
           
        }
        else
        {
            self.weatherLabel.hidden = false
            self.weatherLabel.text = "Please enter a city and try again"
        }
    }
    @IBOutlet weak var cityTextField : UITextField!
    @IBOutlet weak var weatherLabel : UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.weatherLabel.hidden = true
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

