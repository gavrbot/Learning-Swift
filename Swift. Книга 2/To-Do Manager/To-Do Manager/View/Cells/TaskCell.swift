//
//  TaskCell.swift
//  To-Do Manager
//
//  Created by Александр Гаврилов on 02.03.2022.
//

import UIKit

class TaskCell: UITableViewCell {

    @IBOutlet var symbol: UILabel!
    @IBOutlet var title: UILabel!
    
    // метод используется в тех случаях, когда ячейка версталась в Interface Builder(структура хранится или в storyboard, или в xib файле). Как только UIKit создаёт экземпляр класса, соответствующего ячейке, и загружает его структуру, происходит вызов этого метода, который может быть использован, например, для настройки графических элементов в ячейке
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // метод вызывается после того, как пользователь нажмёт на неё. Используется для создания анимаций внутри ячейки
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
