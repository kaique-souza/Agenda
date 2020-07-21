//
//  NewContatoViewModel.swift
//  appAgenda
//
//  Created by Kaique de Souza Santos on 7/15/20.
//  Copyright © 2020 Kaique Santos Souza. All rights reserved.
//

import UIKit

// MARK: - enum
enum EstadoTela {
    case update
    case insert
}

class NewContatoViewModel {
    // MARK: - Attributes
    var contatoSelecionado: Contato?
    var state: EstadoTela?
    let dataSource = RealmDataSource.shared
    var quantidadeImages = 0
    
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

    func addImage(_ foto: UIImage) {
        let image = Imagens()
        guard let foto = foto.pngData() else { return }
        image.imagem = foto
        guard let contato = contatoSelecionado else { return }
        if state == .insert {
            contato.imagens.append(image)
        } else {
            updateContato(nome: contatoSelecionado?.nome, sobrenome: contatoSelecionado?.sobreNome,
                          imagemPerfil: contatoSelecionado?.imagemPerfil, imagens: image)
        }
    }

    func insertContato(nome: String?, sobrenome: String?, imagemPerfil: Data?) {
        contatoSelecionado?.nome = nome
        contatoSelecionado?.sobreNome = sobrenome
        contatoSelecionado?.imagemPerfil = imagemPerfil
        //contatoSelecionado?.imagens.append(imagens)
        guard let contato = contatoSelecionado else { return }
        dataSource.realmInsert(contato)
    }

//    func updateContato(_ nome: String?, _ sobrenome: String?,
//    _ ImagemPerfil: Data?, _ imagens: Imagens? = nil) {
//         try! realm.write {
//            contatoSelecionado?.nome = nome
//            contatoSelecionado?.sobreNome = sobrenome
//            contatoSelecionado?.imagemPerfil = ImagemPerfil
//            if let imagens = imagens {
//                contatoSelecionado?.imagens.append(imagens)
//            }
//         }
//     }
    func removeImagens(indice: Int) {
        contatoSelecionado?.imagens.removeLast()
    }
    
    func updateContato(nome: String?, sobrenome: String?,
                        imagemPerfil: Data?, imagens: Imagens? = nil) {
        try! realm.write {
            self.contatoSelecionado?.nome = nome
            self.contatoSelecionado?.sobreNome = sobrenome
            self.contatoSelecionado?.imagemPerfil = imagemPerfil
            if let imagens = imagens {
                self.contatoSelecionado?.imagens.append(imagens)
            }
        }
    }
}
