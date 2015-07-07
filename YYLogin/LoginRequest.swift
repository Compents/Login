//
//  YYLoginRequest.swift
//  YYLoginViewController
//
//  Created by Yalin on 15/6/3.
//  Copyright (c) 2015年 yalin. All rights reserved.
//

import UIKit

class LoginRequest: NSObject {
    class func login(username: String, password: String, complete : ((NSDictionary? , NSError?) -> Void)?) {
        
        let pushToken = "fefjewioafjaeofja"
        
        let loginUrlStr = Request.requestURL("login.ac")
        Request.startWithRequest(loginUrlStr, method: "POST", params: ["phone" : username, "password" : password, "pushToken" : pushToken]) { (data : NSData!, response : NSURLResponse!, error : NSError!) -> Void in
            
            if let err = error {
                if let handler = complete {
                    handler(nil, err)
                }
            }
            else {
                let result = Request.dataFilter(data)
                if let err = result.error {
                    
                    if let handler = complete {
                        handler(nil, err)
                    }
                    #if DEBUG
                        println("\n----------\n\(__FUNCTION__) \nerror:\(err.localizedDescription)\n==========")
                    #endif
                }
                else {
                    let jsonObj: NSDictionary? = result.jsonObj as? NSDictionary
                    if let handler = complete {
                        handler(jsonObj, nil)
                    }
                    
                    #if DEBUG
                        println("\n----------\n\(__FUNCTION__) \nresult \(jsonObj)\n==========")
                    #endif
                }
            }
        }
    }
}
