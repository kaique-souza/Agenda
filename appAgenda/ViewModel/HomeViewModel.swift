//
//  HomeViewModel.swift
//  appAgenda
//
//  Created by Kaique de Souza Santos on 7/15/20.
//  Copyright © 2020 Kaique Santos Souza. All rights reserved.
//

import UIKit
import RealmSwift

class HomeViewModel {
    
    init() {
        
    }
    
    func setupRealm() -> [Contato]{
        let realm = try! Realm()
        let results = realm.objects(Contato.self)
        let listaContatos = Array(results)
        return listaContatos
    }
    
    
}
