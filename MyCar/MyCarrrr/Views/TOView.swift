//
//  TOView.swift
//  MyCarrrr
//
//  Created by Сергей Васильев on 02.12.2023.
//

import Foundation
import UIKit

class TOView: UIView {
    
    
    
    weak var delegate: ViewToViewController?
    
    weak var toDelegate: TOViewControllerDelegate?
    
    private var car: CarViewModel
    private var carTag: Int
    
    
    private let carLabel = UILabel()
    private let workListLabel = UILabel()
        
    private let labelFrame = UIView()
    private let mainContentFrame = UIView()
    
    private let addNextTOButton = UIButton(type: .system)
    private let addNextTOFrame = UIView()
    
    var toTable = UITableView()

    
    
    init(car: CarViewModel, carTag: Int) {
        self.car = car
        self.carTag = carTag
        super.init(frame: .zero)
//        self.backgroundColor = .gray
        self.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)

        setupHeaderLabel(car.manufacturer)
        setupWorkListLabel()
        setupFrameForLabel()
//        setupFrameForButton()
        setupButton()

        setupCarTable()

        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.endEditing(true)
        }
    
    func updateTable() {
        toTable.reloadData()
    }
    
    private func setupHeaderLabel( _ label: String) {
        self.addSubview(carLabel)
        carLabel.text = label
        carLabel.textColor = .white
        carLabel.font = UIFont.boldSystemFont(ofSize: 22)
        carLabel.textAlignment = .center
        
        carLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            carLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            carLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            carLabel.widthAnchor.constraint(equalToConstant: 390),
            carLabel.heightAnchor.constraint(equalToConstant: 33)
        ])
    }
    
    private func setupWorkListLabel () {
        self.addSubview(workListLabel)
        workListLabel.text = "Список работ"
        workListLabel.textColor = .white
        workListLabel.font = .systemFont(ofSize: 18)
        workListLabel.textAlignment = .center
        
        workListLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            workListLabel.topAnchor.constraint(equalTo: carLabel.bottomAnchor, constant: -4),
            workListLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            workListLabel.widthAnchor.constraint(equalToConstant: 390),
            workListLabel.heightAnchor.constraint(equalToConstant: 33)
        ])
    }
    
    private func setupFrameForLabel() {
        
//        labelFrame = UIView(frame: CGRect(x: 17, y: 11, width: 361, height: 80))
        labelFrame.layer.cornerRadius = 15
        labelFrame.backgroundColor = .black
        self.addSubview(labelFrame)
        labelFrame.addSubview(carLabel)
        labelFrame.addSubview(workListLabel)
        
        labelFrame.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
//            labelFrame.topAnchor.constraint(equalTo: self.topAnchor, constant: 11),
            labelFrame.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0),

            labelFrame.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 17),
            labelFrame.widthAnchor.constraint(equalToConstant: 361),
            labelFrame.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func setupButton() {
        addNextTOButton.layer.cornerRadius = 15
        addNextTOButton.backgroundColor = .black
        self.addSubview(addNextTOButton)
        
        addNextTOButton.setTitle("Запланировать новое ТО", for: .normal)
        addNextTOButton.tintColor = .white
        addNextTOButton.addTarget(self, action: #selector(didTapNextTOButton), for: .touchUpInside)
        
        
        addNextTOButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            addNextTOButton.topAnchor.constraint(equalTo: labelFrame.bottomAnchor, constant: 10),

            addNextTOButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 17),
            addNextTOButton.widthAnchor.constraint(equalToConstant: 361),
            addNextTOButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    @objc
    private func didTapNextTOButton() {
        toDelegate?.updateTODate()
    }
    
    
    private func setupCarTable(){
        
        self.addSubview(toTable)
        toTable.dataSource = self
        toTable.delegate = self
        toTable.backgroundColor = .clear
        toTable.separatorStyle = .none
        toTable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toTable.topAnchor.constraint(equalTo: addNextTOButton.bottomAnchor, constant: 11),
            toTable.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            toTable.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            toTable.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            toTable.widthAnchor.constraint(equalToConstant: 361)
        ])
        
        toTable.rowHeight = UITableView.automaticDimension
        toTable.estimatedRowHeight = 44
        
        toTable.register(TOCellTableViewCell.self, forCellReuseIdentifier: TOCellTableViewCell.identifier)
    }
    
    private func removeItem(at index: Int) {
        toDelegate?.removeWork(index: index)
    }

    
}

extension TOView: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return toDelegate?.works(carIndex: carTag).count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell( withIdentifier: TOCellTableViewCell.identifier, for: indexPath) as? TOCellTableViewCell else {
            return UITableViewCell()
        }
        cell.tag = indexPath.row
        let work = toDelegate?.work(carIndex: carTag, workIndex: indexPath.row)
        cell.update(with: work)
        
        
        cell.cellDelegate = toDelegate as? TOCellViewDelegate
        
        return cell

    }
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            removeItem(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//            toTable.reloadData()
//            
//        }
//    }
}

extension TOView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, completionHandler) in
            self?.removeItem(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            self?.toTable.reloadData()
            completionHandler(true)

        }

        // Customize the delete button color
        deleteAction.backgroundColor = UIColor.red
        let deleteIcon = UIImage(systemName: "trash")?.withRenderingMode(.alwaysTemplate)
        deleteAction.image = deleteIcon


        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}


