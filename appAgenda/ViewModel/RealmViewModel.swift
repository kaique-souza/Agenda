//
//  RealmViewModel.swift
//  appAgenda
//
//  Created by Kaique Santos Souza on 7/8/20.
//  Copyright © 2020 Kaique Santos Souza. All rights reserved.
//

import UIKit
import RealmSwift

class RealmViewModel: NSObject {
    let realm = try! Realm()
    
    // MARK: - Metodos
    func insertContato(_ contato: Contato){
        realm.beginWrite()
        realm.add(contato)
        try! realm.commitWrite()
    }
    
    func updateContato(_ contato: Contato){
        realm.beginWrite()
        realm.add(contato, update: .modified)
        try! realm.commitWrite()
    }
    
    func consulta(){
        let carinha = realm.objects(Contato.self)
        for cara in carinha{
            print(cara.nome)
            print(cara.imagemPerfil)
        }
    }
}
