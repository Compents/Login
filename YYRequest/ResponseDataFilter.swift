//
//  ResponseDataFilter.swift
//  YYLoginViewController
//
//  Created by Yalin on 15/6/15.
//  Copyright (c) 2015年 yalin. All rights reserved.
//

import Foundation

extension Request {
    
    class func dataFilter(data: NSData!) -> (jsonObj : AnyObject? , error : NSError?) {
        
        var err : NSError?
        let result : NSDictionary? = NSJSONSerialization.JSONObjectWithData(data,  options: NSJSONReadingOptions(0), error: &err) as? NSDictionary
        
        if let jsonObj = result {
            
            if let code = result?.valueForKey("code") as? Int {
                if code == 0 {
                    // 请求成功
                    return (result, nil)
                }
                else {
                    // 请求失败
//                    if let userInfo = [NSLocalizedDescriptionKey: result!.valueForKey("msg")] {
//                        err = NSError(domain: "Server logic error", code: code, userInfo: userInfo)
//                    }
                    
                }
            }
        }
        
        return (nil, err)
//        NSInteger code = [result[@"code"] integerValue];
    }
}