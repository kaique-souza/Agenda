//
//  NewContatoViewModel.swift
//  appAgenda
//
//  Created by Kaique de Souza Santos on 7/15/20.
//  Copyright © 2020 Kaique Santos Souza. All rights reserved.
//

import UIKit

// MARK: - enum
enum estadoTela {
    case update
    case insert
}

class NewContatoViewModel {
    // MARK: - Attributes
    var contatoSelecionado: Contato?
    var state: estadoTela?
    let DataSource = RealmDataSource.SourceRealm
    
    // MARK: - Constructor
    init(_ contato: Contato? = nil) {
        self.checkContact(contato)
    }
    
    // MARK: - methods
    func checkContact(_ contato: Contato?) {
        if contato == nil {
            contatoSelecionado = Contato(nome: "", sobrenome: "", imagemPerfil: Data())
            state = .insert
        } else {
            contatoSelecionado = contato
            state = .update
        }
     }
    
    func addImage(_ foto: UIImage){
        let img = Imagens()
        guard let foto = foto.pngData() else { return }
        img.imagem = foto
        
        guard let contato = contatoSelecionado else { return }
        if state == .insert {
            contato.imagens.append(img)
        } else {
            updateContato(contatoSelecionado?.nome, contatoSelecionado?.sobreNome, contatoSelecionado?.imagemPerfil, img)
        }
    }
    func insertContato(_ nome: String?, _ sobrenome: String?, _ ImagemPerfil: Data?){
        contatoSelecionado?.nome = nome
        contatoSelecionado?.sobreNome = sobrenome
        contatoSelecionado?.imagemPerfil = ImagemPerfil
        //contatoSelecionado?.imagens.append(imagens)
        guard let contato = contatoSelecionado else { return }
        DataSource.realmInsert(contato)
    }

//    func updateContato(_ nome: String?, _ sobrenome: String?, _ ImagemPerfil: Data?, _ imagens: Imagens? = nil) {
//         try! realm.write {
//            contatoSelecionado?.nome = nome
//            contatoSelecionado?.sobreNome = sobrenome
//            contatoSelecionado?.imagemPerfil = ImagemPerfil
//            if let imagens = imagens {
//                contatoSelecionado?.imagens.append(imagens)
//            }
//         }
//     }
    
    func updateContato(_ nome: String?, _ sobrenome: String?, _ ImagemPerfil: Data?, _ imagens: Imagens? = nil) {
        contatoSelecionado?.nome = nome
        contatoSelecionado?.sobreNome = sobrenome
        contatoSelecionado?.imagemPerfil = ImagemPerfil
        if let imagens = imagens {
            contatoSelecionado?.imagens.append(imagens)
        }
        guard let contato = contatoSelecionado else { return }
        
    
    }
}
