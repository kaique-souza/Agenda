//
//  RealmDataSource.swift
//  appAgenda
//
//  Created by Kaique de Souza Santos on 7/17/20.
//  Copyright © 2020 Kaique Santos Souza. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class RealmDataSource {
    
    static let SourceRealm = RealmDataSource()
    
    init() {
        
    }
    
    func realmInsert(_ contato: Contato){
           realm.beginWrite()
           realm.add(contato)
           try! realm.commitWrite()
    }

    func realmUpdate(_ contato: Contato) {
        realm.beginWrite()
        realm.add(contato)
        try! realm.commitWrite()
    }
    
    func realmDelete(_ contato: Contato) {
        try! realm.write {
            realm.delete(contato)
        }
    }
    
    func listContact() -> [Contato]{
        let realm = try! Realm()
        let results = realm.objects(Contato.self)
        let listaContatos = Array(results)
        return listaContatos
    }
}
