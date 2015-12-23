//
//  CheckReachability.swift
//  Shokugy
//
//  Created by 堀江健太朗 on 2015/12/21.
//  Copyright © 2015年 Shokugy. All rights reserved.
//

import Foundation
import SystemConfiguration

func CheckReachability(host_name:String)->Bool{
    
    let reachability = SCNetworkReachabilityCreateWithName(nil, host_name)!
    var flags = SCNetworkReachabilityFlags.ConnectionAutomatic
    if !SCNetworkReachabilityGetFlags(reachability, &flags) {
        return false
    }
    let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
    let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
    return (isReachable && !needsConnection)
}