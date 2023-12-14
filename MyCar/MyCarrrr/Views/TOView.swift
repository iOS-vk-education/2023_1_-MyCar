//
//  TOView.swift
//  MyCarrrr
//
//  Created by Сергей Васильев on 02.12.2023.
//

import Foundation
import UIKit

class TOView: UIView, UITableViewDelegate {
    
    
    
    weak var delegate: ViewToViewController?
    
    weak var toDelegate: TOViewControllerDelegate?
    
    
    private let carLabel = UILabel()
    private let workListLabel = UILabel()
    
    private let labelFrame = UIView()
    private let mainContentFrame = UIView()
    
    
    private let toTable = UITableView()

    
    
    init() {
        super.init(frame: .zero)
//        self.backgroundColor = .gray
        self.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)

        setupHeaderLabel("BMW 7 Series")
        setupWorkListLabel()
        setupFrameForLabel()
        setupCarTable()

        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    
    private func setupCarTable(){
        
        
        self.addSubview(toTable)
        toTable.dataSource = self
        toTable.backgroundColor = .clear
        toTable.separatorStyle = .none
        toTable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toTable.topAnchor.constraint(equalTo: labelFrame.bottomAnchor, constant: 11),
            toTable.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            toTable.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            toTable.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            toTable.widthAnchor.constraint(equalToConstant: 361)
        ])
        
        toTable.rowHeight = UITableView.automaticDimension
        toTable.estimatedRowHeight = 44
        
        toTable.register(TOCellTableViewCell.self, forCellReuseIdentifier: TOCellTableViewCell.identifier)
    }

    
}

extension TOView: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDelegate?.works(carIndex: 0).count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell( withIdentifier: TOCellTableViewCell.identifier, for: indexPath) as? TOCellTableViewCell else {
            return UITableViewCell()
        }
        
        let work = toDelegate?.work(carIndex: 0, workIndex: indexPath.row)
        cell.update(with: work)
        
        
//        cell.delegate = delegate as? any CellViewDelegate
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}


