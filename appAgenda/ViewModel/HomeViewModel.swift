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

    let dataSource = RealmDataSource.SourceRealm

    init() {
    }

    func setupRealm() -> [Contato] {
        return dataSource.listContact()
    }

    func deleteContato (_ contato: Contato) {
        dataSource.realmDelete(contato)
    }
}
