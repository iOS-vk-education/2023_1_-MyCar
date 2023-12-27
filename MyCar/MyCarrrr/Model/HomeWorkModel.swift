//
//  HomeWorkModel.swift
//  MyCarrrr
//
//  Created by Сергей Васильев on 06.12.2023.
//

import Foundation

final class HomeWorkModel {
    
    
    private var works : [WorkModel] = []
    
    
    func loadWorks() {
        // user defaults get
    }
    
    func remove(at index: Int) {
        works.remove(at: index)
    }
    
    func work(index: Int) -> WorkModel {
        works[index]
    }
    
    func addWork(_ work: WorkModel) {
        works.append(work)
    }
    
    func allWorks() -> [WorkModel] {
        works
    }
}
