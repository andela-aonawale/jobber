//
//  JobRequest.swift
//  Jobber
//
//  Created by Andela Developer on 7/10/15.
//  Copyright (c) 2015 Andela. All rights reserved.
//

import Foundation
import Alamofire
import Accounts

struct JobRequest {
    
    var searchString: String? {
        get {
            return "ios"
        }
    }
    
    var country: String? {
        get {
            return "us"
        }
    }
    
    var url: String? {
        get { return "http://api.indeed.com/ads/apisearch?publisher=1250343143571133&q=\(searchString!)&l=stanford&sort=&radius=&st=&jt=&start=&limit=100&fromage=&filter=&latlong=1&co=\(country!)&chnl=&userip=1.2.3.4&format=json&v=2"
        }
    }
    
    func fetchJobs(query: String) {
        request(.GET, query, encoding: .JSON)
        .responseJSON { (request, response, data, error) in
            
        }
    }

    
}