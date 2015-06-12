//
//  YYLoginRequest.swift
//  YYLoginViewController
//
//  Created by Yalin on 15/6/3.
//  Copyright (c) 2015年 yalin. All rights reserved.
//

import UIKit

class LoginRequest: NSObject {
    class func login(username: String, password: String) {
        
        let pushToken = "fefjewioafjaeofja"
        
        let loginUrlStr = "http:////211.157.160.108/easygtd/v1/user/login.ac"
        Request.startWithRequest(loginUrlStr, method: "POST", params: ["phone" : username, "password" : password, "pushToken" : pushToken]) { (data : NSData!, response : NSURLResponse!, error : NSError!) -> Void in
            
            var err : NSError?
            let result : NSDictionary? = NSJSONSerialization.JSONObjectWithData(data,  options: NSJSONReadingOptions(0), error: &err) as? NSDictionary
            #if DEBUG
                println("\n----------\n\(__FUNCTION__) \nresult \(result)\nerror:\(error.localizedDescription)\n==========")
            #endif
            
        }
    }
}
