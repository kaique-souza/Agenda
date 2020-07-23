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
    var listaContatos: [Contato] = []
    
    let dataSource = RealmDataSource.shared

    init() {
    }

    func setupRealm() {
        listaContatos = dataSource.listContact()
    }

    func deleteContato (_ contato: Contato, erro: @escaping(Error?) -> Void) {
        dataSource.realmDelete(contato, erro: {(error) in
            if error == nil {
                erro(nil)
            } else {
                erro(error)
            }
        })
    }
}
