import UIKit
import SwiftUI

protocol ViewToViewController: AnyObject {
    func cars() -> [CarViewModel]
    func removeCar(index: Int)
    func goToAddScreen()
    func goToOnboardingScreen()
    func goToTOScreen(tag: Int)
    func setCarLocation(index: Int)
}



class MyCarsViewController: UIViewController {
    
    private let contentView = MyCarsView()
    private let model: HomeCarsModel
    
    private let containerView = UIView()

    
    init(model: HomeCarsModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.delegate = self
    
        // Регистрация для получения уведомлений о обновлении данных
        NotificationCenter.default.addObserver(self, selector: #selector(handleDataUpdated), name: .dataUpdated, object: nil)
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                    if granted {
                        print("Уведомления разрешены")
                    } else {
                        print("Уведомления не разрешены")
                    }
                }
    }
    

    
    @objc func handleDataUpdated() {
        contentView.updateTable()
        }
    
    
}

extension MyCarsViewController: ViewToViewController {
    func setCarLocation(index: Int) {
        model.setCarLocation(index)
    }
    
    
    func cars() -> [CarViewModel] {
        model.allCars()
    }
    
    func removeCar(index: Int) {
        model.remove(at: index)
    }
    
    func goToAddScreen() {
        let vc = AddCarViewController(model: model)
//        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func goToOnboardingScreen() {
        let hostingVC = UIHostingController(rootView: OnboardingView(goToAddScreen: {
            self.goToAddScreen()
        }))
        hostingVC.modalPresentationStyle = .fullScreen
        present(hostingVC, animated: true)
    }
    
    func goToTOScreen(tag: Int) {
        //        let vc = TOViewController(model: model)
        //        present(vc, animated: true)
        let toViewController = TOViewController(model: model, tag: tag)

        // Создаем UINavigationController
        let navigationController = UINavigationController(rootViewController: toViewController)
        
        // Добавляем "Назад" кнопку
        let backButton = UIBarButtonItem(title: "Назад", style: .plain, target: self, action: #selector(goBack))
        let addButton = UIBarButtonItem(title: "Добавить", style: .plain, target: toViewController, action: #selector(toViewController.addWorkAction(_:)))

        print(tag)
        addButton.tag = tag
        
//        backButton.tintColor = .white
//        addButton.tintColor = .white
        toViewController.navigationItem.leftBarButtonItem = backButton
        toViewController.navigationItem.rightBarButtonItem = addButton
        
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.modalTransitionStyle = .flipHorizontal
        
        // Презентуем UINavigationController с анимацией
        present(navigationController, animated: true, completion: nil)
    
    }
    
    func goToInsurenceScreen(tag: Int) {
        // Создаем view для затемнения экрана
        let dimmingView = UIView(frame: view.bounds)
        dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.5) // Прозрачный черный цвет
        view.addSubview(dimmingView)
        
        let label = UILabel()
        label.text = "Сохранение...\nПожалуйста, подождите"
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        dimmingView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: dimmingView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: dimmingView.centerYAnchor, constant: -50),
        ])
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .white
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        DispatchQueue.global().async {
            self.setCarLocation(index: tag)
            
            DispatchQueue.main.async {
                activityIndicator.stopAnimating()
                dimmingView.removeFromSuperview()
                
                let alertController = UIAlertController(title: "Успешно!", message: "Место парковки авто было сохранено.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                    self.dismiss(animated: true)
                }
                alertController.addAction(okAction)
                self.present(alertController, animated: true)
            }
        }
    }
    
    @objc func goBack() {
        dismiss(animated: true, completion: nil)
    }
    
    func goToMileageScreen(tag: Int) {
        let mileageViewController = MileageViewController(model: model, tag: tag)
    
        mileageViewController.modalPresentationStyle = .pageSheet
        mileageViewController.sheetPresentationController?.detents = [.medium()]
        present(mileageViewController, animated: true)
    }
    
    func goToEditScreen(_ tag: Int) {
        let editViewController = EditCarViewController(model: model, tag: tag)
        present(editViewController, animated: true)
    }
    
}

extension Notification.Name {
    static let dataUpdated = Notification.Name("dataUpdated")
}

extension MyCarsViewController: CellViewDelegate {
    
    func didTapEditCarButtonOnCell(_ tag: Int) {
        goToEditScreen(tag)
    }
    
    func didTapMileageButtonOnCell(_ tag: Int) {
        goToMileageScreen(tag: tag)
    }
    
    func didTapInsuranceButtonOnCell(_ tag: Int) {
        goToInsurenceScreen(tag: tag)
    }
    
    func didTapButtonOnCell(_ tag: Int) {
        goToTOScreen(tag: tag)
    }

    
}


