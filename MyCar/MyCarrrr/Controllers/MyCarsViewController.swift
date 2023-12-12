import UIKit

protocol ViewToViewController: AnyObject {
    func cars() -> [CarViewModel]
    func removeCar(index: Int)
    func goToAddScreen()
    func goToTOScreen()
}



class MyCarsViewController: UIViewController {
    
    private let contentView = MyCarsView()
    private let model: HomeCarsModel
    


    
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
    }
    

    
    @objc func handleDataUpdated() {
        contentView.updateTable()
        }
    
    
}

extension MyCarsViewController: ViewToViewController {
    
    func cars() -> [CarViewModel] {
        model.allCars()
    }
    
    func removeCar(index: Int) {
        model.remove(at: index)
    }
    
    func goToAddScreen() {
        let vc = AddCarViewController(model: model)
        present(vc, animated: true)
        print(model.allCars())
    }
    
    func goToTOScreen() {
        //        let vc = TOViewController(model: model)
        //        present(vc, animated: true)
        
        
        let toViewController = TOViewController(model: model)
        
        // Создаем UINavigationController
        let navigationController = UINavigationController(rootViewController: toViewController)
        
        // Добавляем "Назад" кнопку
        let backButton = UIBarButtonItem(title: "Назад", style: .plain, target: self, action: #selector(goBack))
        let addButton = UIBarButtonItem(title: "Добавить", style: .plain, target: self, action: #selector(goBack))
        toViewController.navigationItem.leftBarButtonItem = backButton
        toViewController.navigationItem.rightBarButtonItem = addButton
        
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.modalTransitionStyle = .flipHorizontal
        
        // Презентуем UINavigationController с анимацией
        present(navigationController, animated: true, completion: nil)
    
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
    
    func didTapInsuranceButtonOnCell() {
        print("страховка")
    }
    
    func didTapButtonOnCell(on cell: CarCellTableViewCell) {
        goToTOScreen()
    }
    
//    func didTapButtonOnCell() {
//       goToTOScreen()
//    }
    
}


