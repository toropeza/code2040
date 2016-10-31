//
//  ViewController.swift
//  Code2040
//
//  Created by Thomas Oropeza on 10/31/16.
//  Copyright © 2016 Thomas Oropeza. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        request()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func request(){
        var request = URLRequest(url: URL(string: "http://challenge.code2040.org/api/register")!)
        request.httpMethod = "POST"
        let postString = "{'token':'b3293e2972f6d41c54ddb2e7a5414a78','github':'https://github.com/toropeza/code2040'}"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
        }
        task.resume()
        
    }


}

