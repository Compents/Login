//
//  ViewController.swift
//  YYLoginViewController
//
//  Created by Yalin on 15/6/3.
//  Copyright (c) 2015年 yalin. All rights reserved.
//

import UIKit

enum Functions {
    
    case Login
    
    // 获取功能名
    func functionName() -> String {
        switch self {
        case .Login:
            return "Login"
        }
    }
    
    // 获取功能对应ViewController
    func functionViewController() -> UIViewController {
        switch self {
        case .Login:
            return LoginViewController(nibName: "LoginViewController", bundle: nil)
        }
    }
    
    // 获取所有功能列表
    static func allFunctions () -> [Functions] {
        return [Functions.Login]
    }
}

class ViewController: UITableViewController, UITableViewDataSource , UITableViewDelegate {
    
    let functions : [Functions] = Functions.allFunctions();

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - UITableViewDataSource
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return functions.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellId = "mainCellId"
        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellId) as? UITableViewCell
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellId)
        }
        
        cell?.textLabel?.text = functions[indexPath.row].functionName()
        
        return cell!
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let function = functions[indexPath.row]
        self.navigationController?.pushViewController(function.functionViewController(), animated: true)
    }
}

