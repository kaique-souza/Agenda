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
    typealias VoidCallback = () -> Void
    
    // MARK: - Atributos
    var listaContatos: [Contato] = []
    let dataSource = RealmDataSource.shared
    var reloadTableView: VoidCallback?
    
    // MARK: - Constructor
    init() {
    }
    
    // MARK: - Metedos
    func getListContact() {
        listaContatos = dataSource.listContact()
        reloadTableView?()
        //let contatos = dataSource.listContact()
        //teste(lista: contatos)
    }
    
//    func teste(lista: [Contato]) {
//        let contatos = lista.filter({$0.nome == "teste"})
//        listaContatos = contatos
//        reloadTableView?()
//    }

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
