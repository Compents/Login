//
//  YYRequest.swift
//  YYLoginViewController
//
//  Created by Yalin on 15/6/4.
//  Copyright (c) 2015年 yalin. All rights reserved.
//

import Foundation

class Request {
    
    class func startWithRequest(url : String, method : String?, params : [String : String]?, completionHandler: (NSData! , NSURLResponse!, NSError!) -> Void) {
        
        // create request
        var request : NSMutableURLRequest = NSMutableURLRequest(URL: NSURL(string: url)!)
        
        if let m = method {
            request.HTTPMethod = m
        }
        
        // set body data
        if let bodyStrAndBoundary = generateFormDataBodyStr(params) {
            request.HTTPBody = bodyStrAndBoundary.bodyStr.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
            request.setValue("\(bodyStrAndBoundary.bodyStr.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))", forHTTPHeaderField: "Content-Length")
            request.setValue("multipart/form-data; boundary=Boundary+\(bodyStrAndBoundary.boundary)", forHTTPHeaderField: "Content-Type")
        }
        
        var task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: completionHandler)
        
        task.resume()
    }
}

// data wrapper
extension Request {
    
    class func generateFormDataBodyStr(params : [String : String]?) -> (bodyStr : String, boundary : String)? {
        
        let boundary = String(format: "%08X%08X", arc4random(),arc4random())
        // add form data
        var bodyStr = "--Boundary+\(boundary)--\r\n"
        if let p = params {
            for (key , value) in p {
                bodyStr += "--Boundary+\(boundary)\r\nContent-Disposition: form-data; name=\"\(key)\"\r\n\r\n\(value)\r\n"
            }
        }
        else {
            return nil
        }
        bodyStr += "\r\n--Boundary+\(boundary)--\r\n"
        
        return (bodyStr, boundary)
    }
}