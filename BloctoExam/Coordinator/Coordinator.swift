//
//  Coordinator.swift
//  BloctoExam
//
//  Created by Rock Chen on 2023/8/11.
//

import Foundation

protocol Coordinator {
    var children: [Coordinator] { get set }
        
    func start()
}
