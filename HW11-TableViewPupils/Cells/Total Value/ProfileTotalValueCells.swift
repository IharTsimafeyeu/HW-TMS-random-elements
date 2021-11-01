//
//  ProfileTotalValueCells.swift
//  HW11-TableViewPupils
//
//  Created by lion on 25.10.21.
//
struct ModelTotalScore {
    let numberOfPupilsString: String
    let averageScoreString: String
    let numberOfClassesString: String
}




import UIKit

class ProfileTotalValueCells: UITableViewCell {
    @IBOutlet weak var totalValueCellView: UIView!
    
    @IBOutlet weak var numberOfPupilsLabel: UILabel!
    @IBOutlet weak var averageScoreLabel: UILabel!
    @IBOutlet weak var numberOfClassesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        totalValueCellView.layer.cornerRadius = 30
    }

    static let identifier = "ProfileTotalValueCells"
    
    func makeTotalValueCellsBy(model: ModelTotalScore) {
        numberOfPupilsLabel.text = model.numberOfPupilsString
        averageScoreLabel.text = model.averageScoreString
        numberOfClassesLabel.text = model.numberOfClassesString
    
        
        
    }
    
    
    
    
    
}
