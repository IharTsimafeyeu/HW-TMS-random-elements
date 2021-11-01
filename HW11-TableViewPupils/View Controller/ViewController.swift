//
//  ViewController.swift
//  HW11-TableViewPupils
//
//  Created on 25.10.21.
//

import UIKit

final class ViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    private var dataSourcePupils: [ModelPupilsData] = [
        ModelPupilsData(pupilNameString: "Rob", pupilClassString: "A"),
        ModelPupilsData(pupilNameString: "John", pupilClassString: "A"),
        ModelPupilsData(pupilNameString: "Fransis", pupilClassString: "B"),
        ModelPupilsData(pupilNameString: "Robin", pupilClassString: "D"),
        ModelPupilsData(pupilNameString: "Baddy", pupilClassString: "C"),
        ModelPupilsData(pupilNameString: "Clar", pupilClassString: "A"),
        ModelPupilsData(pupilNameString: "Ozzy", pupilClassString: "B"),
        ModelPupilsData(pupilNameString: "Kolya", pupilClassString: "A"),
        ModelPupilsData(pupilNameString: "Billy", pupilClassString: "C"),
        ModelPupilsData(pupilNameString: "Bob", pupilClassString: "A"),
        ModelPupilsData(pupilNameString: "Misha", pupilClassString: "A"),
        ModelPupilsData(pupilNameString: "Joy", pupilClassString: "B"),
        ModelPupilsData(pupilNameString: "Frank", pupilClassString: "D"),
        ModelPupilsData(pupilNameString: "Vasua", pupilClassString: "E"),
        ModelPupilsData(pupilNameString: "Ostin", pupilClassString: "A")
    ]
    
    private var classesArray: [String] {
        let pupilClassesArray = dataSourcePupils.compactMap({ $0.pupilClassString })
        let set = Set(pupilClassesArray)
        return set.sorted()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .black
        view.backgroundColor = .black
        
        tableView.register(UINib(nibName: "ProfilePupilsCells", bundle: nil), forCellReuseIdentifier: ProfilePupilsCells.identifier)
        tableView.register(UINib(nibName: "ProfileTotalValueCells", bundle: nil), forCellReuseIdentifier: ProfileTotalValueCells.identifier)
    }
    
    private func filterStudentsFor(classString: String) -> [ModelPupilsData] {
        let filtered = dataSourcePupils.filter({$0.pupilClassString == classString})
        return filtered
    }
    // Не успел сделать полностью задание из-за работы на выхах и поэтому кидаю только сейчас то, что сделал сегодня, потому что сделать это все на выходных просто не было времени. Долго возился с переходом из одного вьюконтроллера в другой.
    // Что не получилось: если выставить боковую стрелочку на FirstViewController, которая указывает на поочередность отображения контроллеров на экране, у меня вылазит крэш непозволяющий перейти по моему логину и паролю на контроллер с табличкой студентов.
    // Не уверен, что делать форс анрэпп в моей функции addStudent корректно. Но, раз мы точно знаем там о наличии стринговых элементов массива, то, наверн, это будет хорошим тоном кода в принципе. Спрошу еще этот момент на занятии.
    @IBAction func addStudent(_ sender: UIButton) {
        let names = ["Dmitriy", "Lesha", "Ihar", "Nikolay", "Chris"]
        let classes = ["A", "B", "C", "D", "E"]
        let randomName = names.randomElement()
        let randomClass = classes.randomElement()
        dataSourcePupils.append(ModelPupilsData(pupilNameString: randomName!, pupilClassString: randomClass!))
        tableView.reloadData()
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return classesArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let classString = classesArray[section]
        let pupils = filterStudentsFor(classString: classString)
        return pupils.count
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = .black
        let label = UILabel(frame: CGRect(x: 0, y: 15,
                                          width: tableView.frame.width,
                                          height: 20))
        
        label.text = classesArray[section]
        label.textAlignment = .center
        label.textColor = .white
        header.addSubview(label)
        
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = .black
        
        let classString = classesArray[section]
        let pupils = filterStudentsFor(classString: classString)
        let pupilsCount = "Class Pupils Count: \(pupils.count)"
        
        
        let scoring = pupils.compactMap({ $0.pupilScoreInt }).reduce(0, +)
        let pupilsScoring = "Average Pupils Scoring: \(scoring / pupils.count)"
        
        let label = UILabel(frame: CGRect(x: 0, y: 25,
                                          width: tableView.frame.width,
                                          height: 20))
        label.text = pupilsCount
        label.textAlignment = .center
        label.textColor = .white
        
        let secondLabel = UILabel(frame: CGRect(x: 0, y: 45,
                                          width: tableView.frame.width,
                                          height: 20))
        secondLabel.text = pupilsScoring
        secondLabel.textAlignment = .center
        secondLabel.textColor = .white
        
        header.addSubview(label)
        header.addSubview(secondLabel)
    
        let separator = UIView(frame: CGRect(x: 0,
                                             y: 99,
                                             width: tableView.frame.width, height: 1))
        separator.backgroundColor = .gray
        header.addSubview(separator)
        
        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfilePupilsCells.identifier, for: indexPath) as! ProfilePupilsCells
        
        let classString = classesArray[indexPath.section]
        let pupils = filterStudentsFor(classString: classString)
        cell.makeProfileCellBy(model: pupils[indexPath.row])
        
        return cell
    }
}
