//
//  ViewController.swift
//  BaseApp
//
//  Created by nguyen ha on 4/21/17.
//  Copyright © 2017 D.ace. All rights reserved.
//

import UIKit
import BoltsSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        testapi.sharedInstance.testURL().continueWith(continuation: { (task: BoltsSwift.Task<Any>) -> Any? in
            
            if task.faulted {
                return nil
            }
            let apiResponse = task.result as! ApiResponse
            let locationList = apiResponse.modelData as! test
            print(locationList.Result)
            return nil
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

