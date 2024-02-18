//
//  NextTODateViewController.swift
//  MyCarrrr
//
//  Created by Сергей Васильев on 24.12.2023.
//

import Foundation
import UIKit


class NextTODateViewController: UIViewController {
    
    private let carTag: Int
    private var model: HomeCarsModel
    private var contentView: TODateView!
    private let label: String
    
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.delegate = self
    }
    
    init(carTag: Int, model: HomeCarsModel, label: String) {
        self.carTag = carTag
        self.model = model
        self.label = label
        super.init(nibName: nil, bundle: nil)
        contentView = TODateView(car: model.car(index: carTag), label: label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   

}

extension NextTODateViewController: DateViewDelegate {
    
    func didTapDateButton(_ date: String) {
        model.updateNextTODate(carTag, date)
        dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: .dataUpdated, object: nil)
        
        let content = UNMutableNotificationContent()
        content.title = "Подходит время ТО!"
        content.body = "Вы запланировали ТО для вашего \(model.car(index: carTag).manufacturer) на завтра."
        content.sound = .default
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        var dateComponents = DateComponents()
        
        if let date = dateFormatter.date(from: date) {
            let calendar = Calendar.current
            let previousDay = Calendar.current.date(byAdding: .day, value: -1, to: date)!
            let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: previousDay)

        } else {
            print("Ошибка преобразования строки в дату")
        }
        dateComponents.minute = 0
        dateComponents.hour = 10
        dateComponents.second = 5
        
        //MARK: для презентации
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//        let request = UNNotificationRequest(identifier: "notification", content: content, trigger: trigger)

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: "TONotification", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Ошибка отправки уведомления: (error.localizedDescription)")
            } else {
                print("Уведомление успешно отправлено")
            }
        }
    }
    
}





