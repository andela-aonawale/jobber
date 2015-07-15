//
//  JobTableViewCell.swift
//  Jobber
//
//  Created by Andela Developer on 7/6/15.
//  Copyright (c) 2015 Andela. All rights reserved.
//

import UIKit

class JobTableViewCell: UITableViewCell {

    @IBOutlet weak var jobTitle: UILabel!
    @IBOutlet weak var jobCompany: UILabel!
    @IBOutlet weak var jobDescription: UILabel!
    @IBOutlet weak var jobLocation: UILabel!
    @IBOutlet weak var datePosted: UILabel!

    var job: Job? {
        didSet {
           updateUI()
        }
    }
    
    private func updateUI() {
        if let job = self.job {
            jobTitle?.text = job.title
            jobCompany?.text = job.company
            jobDescription?.text = job.description
            jobLocation?.text = job.location
            datePosted?.text = job.datePosted
        }
    }
}
