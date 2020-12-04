//
//  SearchResultCell.swift
//  Neisu_iOS
//
//  Created by Dev.Young on 2020/12/04.
//

import UIKit

class SearchResultCell: UITableViewCell {
    
    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet weak var schoolAdressLabel: UILabel!
    
    var school: School! {
        didSet {
            setupView()
        }
    }
    
    func setupData(school:School){
        self.school = school
    }
    
    private func setupView(){
        schoolNameLabel.text = school.schoolName
        schoolAdressLabel.text = school.schoolAdress
    }
}
