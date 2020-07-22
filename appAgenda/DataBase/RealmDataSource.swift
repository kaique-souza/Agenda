//
//  RealmDataSource.swift
//  appAgenda
//
//  Created by Kaique de Souza Santos on 7/17/20.
//  Copyright © 2020 Kaique Santos Souza. All rights reserved.
import Foundation
import UIKit
import RealmSwift

class RealmDataSource {
    static let shared = RealmDataSource()
    
    init() {
        
    }
    
    func realm() -> Realm? {
        do {
            let realm = try Realm()
            return realm
        } catch let erro {
            print(erro.localizedDescription)
        }
        return nil
    }
    
    func realmInsert(_ contato: Contato, erro: @escaping(Error?) -> Void) {
        guard let realm = self.realm() else { return }
        do {
            realm.beginWrite()
            realm.add(contato)
            try realm.commitWrite()
            erro(nil)
        } catch let error {
            erro(error)
            print(error.localizedDescription)
        }
    }
    
    func updateContato(nome: String?, sobrenome: String?,
                       imagemPerfil: Data?, imagens: Imagens? = nil,
                       contatoToUpdate: Contato, erro: @escaping(Error?) -> Void) {
        guard let realm = self.realm() else { return }
        do {
            try realm.write {
                contatoToUpdate.nome = nome
                contatoToUpdate.imagemPerfil = imagemPerfil
                if let imagens = imagens {
                    contatoToUpdate.imagens.append(imagens)
                }
            }
            erro(nil)
        } catch let error {
            erro(error)
            print(error.localizedDescription)
        }
    }
    
    func realmDelete(_ contato: Contato) {
        guard let realm = self.realm() else { return }
        do {
            try realm.write {
                realm.delete(contato)
            }
        } catch let erro {
            print(erro.localizedDescription)
        }
       
    }
    
    func listContact() -> [Contato] {
        guard let realm = self.realm() else { return [] }
        let results = realm.objects(Contato.self)
        let listaContatos = Array(results)
        return listaContatos
    }
}
