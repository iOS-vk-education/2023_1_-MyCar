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
    
    func goToMileageScreen() {
        let vc = TOViewController(model: model)
        vc.modalPresentationStyle = .pageSheet
        vc.sheetPresentationController?.detents = [.medium()]
        present(vc, animated: true)
    }
    
}

extension Notification.Name {
    static let dataUpdated = Notification.Name("dataUpdated")
}

extension MyCarsViewController: CellViewDelegate {
    func didTapButtonOnCell() {
       goToTOScreen()
    }
    
}


