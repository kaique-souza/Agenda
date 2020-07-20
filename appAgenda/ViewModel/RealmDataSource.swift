//
//  RealmViewModel.swift
//  appAgenda
//
//  Created by Kaique Santos Souza on 7/8/20.
//  Copyright © 2020 Kaique Santos Souza. All rights reserved.
//

import UIKit
import RealmSwift

class RealmDataSource: NSObject {
    let realm = try! Realm()

    // MARK: - Metodos
    func insertContato(_ contato: Contato) {
        realm.beginWrite()
        realm.add(contato)
        try! realm.commitWrite()
    }
//    func consulta(){
//        let contatos = realm.objects(Contato.self)
//        for contato in contatos{
//            print(contato.nome)
//            print(contato.imagemPerfil)
//        }
//    }
}
