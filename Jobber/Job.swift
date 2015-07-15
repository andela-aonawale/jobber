//
//  Job.swift
//  Jobber
//
//  Created by Andela Developer on 7/6/15.
//  Copyright (c) 2015 Andela. All rights reserved.
//

import Foundation

struct Job {
    var title: String?
    var company: String?
    var description: String?
    var location: String?
    var datePosted: String?
    
    func cleanJobDescription(string: String?) -> String {
        let word = string?.stringByReplacingOccurrencesOfString("<"+"b"+">", withString: "")
        let clean = word?.stringByReplacingOccurrencesOfString("<"+"/"+"b"+">", withString: "")
        return clean!
    }
    
    init(job: NSDictionary) {
        self.title = job["jobtitle"] as? String
        self.company = job["company"] as? String
        self.description = cleanJobDescription((job["snippet"] as? String))
        self.location = job["formattedLocationFull"] as? String
        self.datePosted = job["formattedRelativeTime"] as? String
    }
}