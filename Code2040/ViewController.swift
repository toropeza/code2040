//
//  ViewController.swift
//  Code2040
//
//  Created by Thomas Oropeza on 10/31/16 for the Code 2040 Application
//  Copyright © 2016 Thomas Oropeza. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Labels signifying problem completion in UI
    @IBOutlet weak var problem1Label: UILabel!
    @IBOutlet weak var problem2Label: UILabel!
    @IBOutlet weak var problem3Label: UILabel!
    @IBOutlet weak var problem4Label: UILabel!
    @IBOutlet weak var problem5Label: UILabel!
    
    
    let postURL = "http://challenge.code2040.org/api"
    let token = "b3293e2972f6d41c54ddb2e7a5414a78"
    let github = "https://github.com/toropeza/code2040"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        /*
         Hi there!
         
         This is my submission for the Code 2040 Application!
         
         My name is Thomas Oropeza and as you can probably tell by all this Swift around you i'm passionate about Mobile Development!
         
         Contact me if you have any questions about the code below or would just like to chat :)
         Email: thomasoropeza@gmail.com
         iOS Blog!: http://TalkMobileDev.com
         linkedIn: https://www.linkedin.com/in/oropezathomas
         
         Some technical details :D
         ---------------
         -Look at the app UI for more info and to watch the excercises complete!
         -ViewDidLoad() is the method called at startup and the methods below solve each given problem for the Code 2040 Application
         -For each HTTP Post, I call the sendPost() method which takes a closure as a parameter. That block of code will be called with the response of the first HTTP Post as a parameter
         -Each HTTP Post is an Asynchronous task to prevent the main thread from being paused
         -You may import this project into Xcode to test the results
         */
        
        //running the solutions
        step1()
        step2()
        step3()
        step4()
        step5()
    }
    
    func step1(){
        let dictionary = ["token": token, "github": github]
        let url = postURL + "/register"
        sendPost(url: url, dictionary: dictionary, completion: {
            (response: String) in
            print("Step 1 response = \(response)")
            
            if response == "Step 1 complete"{
                //label updated in UI to show completion
                self.problem1Label.backgroundColor = UIColor.green
            }
        })
    }
    
    func step2(){
        let url = postURL + "/reverse"
        let dictionary = ["token": token]
        sendPost(url: url, dictionary: dictionary, completion: {
            (response: String) in
            
            //reverse the String
            let reversedString = self.reverseString(string: response)
            
            //send the result back to the API
            let validateURL = url + "/validate"
            let dictionary = ["token": self.token, "string": reversedString]
            self.sendPost(url: validateURL, dictionary: dictionary, completion: {
                (response: String) in
                print("Step 2 Response = \(response)")
                
                if response == "Step 2 complete"{
                    //label updated in UI to show completion
                    self.problem2Label.backgroundColor = UIColor.green
                }
            })
        })
    }
    
    /**
     Reverses the given string
     @param string: The String to reverse
     @return: The reversed string
     */
    func reverseString(string: String) -> String {
        return String(string.characters.reversed())
    }
    
    func step3(){
        let url = postURL + "/haystack"
        let dictionary = ["token": token]
        sendPost(url: url, dictionary: dictionary, completion: {
            (response: String) in
            
            //convert the JSON string to a Dictionary
            let data = response.data(using: .utf8)!
            let json = try? JSONSerialization.jsonObject(with: data) as! [String: Any]
            
            //retrieve the needle and haystack from the dictionary
            let needle = json?["needle"] as! String
            let haystack = json?["haystack"] as! [String]
            
            //find the index
            let index = self.indexOf(needle: needle, haystack: haystack)
            
            //send the result back to the API
            let validateURL = url + "/validate"
            let dictionary = ["token": self.token, "needle": index] as [String : Any]
            self.sendPost(url: validateURL, dictionary: dictionary, completion: {
                (response: String) in
                print("Step 3 Response = \(response)")
                
                if response == "Step 3 complete"{
                    //label updated in UI to show completion
                    self.problem3Label.backgroundColor = UIColor.green
                }
            })
        })
    }
    
    /**
     Returns the index of the given string in the array
     @param needle: The string to search for
     @param haystack: The array of Strings
     @return the index of the string in the Array
     */
    func indexOf(needle: String, haystack: [String]) -> Int{
        var index = -1
        var count = 0
        for item in haystack {
            if item == needle {
                index = count
            }
            count = count + 1
        }
        return index
    }
    
    func step4(){
        let url = postURL + "/prefix"
        let dictionary = ["token": token]
        sendPost(url: url, dictionary: dictionary, completion: {
            (response: String) in
            
            //convert the returned JSON string to a dictionary
            let data = response.data(using: .utf8)!
            let json = try? JSONSerialization.jsonObject(with: data) as! [String: Any]
            
            //retrieve prefix and array
            let prefix = json?["prefix"] as! String
            let array = json?["array"] as! [String]
            
            //find string without given prefix
            let noPrefixStrings = self.stringsWithoutPrefix(prefix: prefix, array: array)
            
            //send the result back to the API
            let validateURL = url + "/validate"
            let dictionary = ["token": self.token, "array": noPrefixStrings] as [String : Any]
            self.sendPost(url: validateURL, dictionary: dictionary, completion: {
                (response: String) in
                print("Step 4 Response = \(response)")
                
                if response == "Step 4 complete"{
                    //label updated in UI to show completion
                    self.problem4Label.backgroundColor = UIColor.green
                }
            })
        })
    }
    
    /**
     Returns an array of strings that do not have the given prefix
     @param prefix: The string prefix
     @param array: The array of Strings
     @return The array of strings without the given prefix
     */
    func stringsWithoutPrefix(prefix: String, array: [String]) -> [String]{
        var stringsWithoutPrefix = [String]()
        
        for string in array{
            if !string.hasPrefix(prefix){
                stringsWithoutPrefix.append(string)
            }
        }
        return stringsWithoutPrefix
    }
    
    func step5(){
        let url = postURL + "/dating"
        let dictionary = ["token": token]
        sendPost(url: url, dictionary: dictionary, completion: {
            (response: String) in
            
            //convert the returned JSON into a Dictionary
            let data = response.data(using: .utf8)!
            let json = try? JSONSerialization.jsonObject(with: data) as! [String: Any]
            
            //retrieve the date stamp and interval
            let dateString = json?["datestamp"] as! String
            let interval = json?["interval"] as! Int
            
            //add the interval to the given date
            let addedDateString = self.addIntervalToDateString(dateString: dateString, interval: interval)
            
            //send the result back to the API
            let validateURL = url + "/validate"
            let dictionary = ["token": self.token, "datestamp": addedDateString] as [String : Any]
            self.sendPost(url: validateURL, dictionary: dictionary, completion: {
                (response: String) in
                print("Step 5 Response = \(response)")
                
                if response == "Step 5 complete"{
                    //label updated in UI to show completion
                    self.problem5Label.backgroundColor = UIColor.green
                }
            })
        })
    }
    
    /**
     Adds the given interval (seconds) to the given date string
     @param dateString: The date string in ISO8601 Format
     @param interval: The interval to add in seconds
     @return The ISO8601 Format string with the added interval
     */
    func addIntervalToDateString(dateString: String, interval: Int)-> String{
        var addedDateString = ""
        let isoFormatter  = ISO8601DateFormatter()
        if let date = isoFormatter.date(from: dateString)?.addingTimeInterval(TimeInterval(interval)){
            addedDateString = isoFormatter.string(from: date)
        }
        return addedDateString
    }
    
    /**
     Asynchronously performs an HTTP post
     @param url: The URL to send the HTTP Post to
     @param dictionary: The dictionary of key value pairs to be represented as JSON in the POST body
     @param completion: The block of code to run on the HTTP Post response
     */
    func sendPost(url: String, dictionary: [String:Any], completion: @escaping (_: String) -> Void){
        
        //form the Request with the URL, Content-Type, and Body
        var request = URLRequest(url: URL(string: url)!)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = try! JSONSerialization.data(withJSONObject: dictionary)
        
        //form an Asynchronous task
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // check for fundamental networking error
            guard let data = data, error == nil else {
                print("error=\(error)")
                return
            }
            
            // check for http errors
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            //call the closure with the API Response
            let responseString = String(data: data, encoding: .utf8)!
            completion(responseString)
        }
        //start the task
        task.resume()
    }
}

