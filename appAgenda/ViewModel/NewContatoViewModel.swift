//
//  NewContatoViewModel.swift
//  appAgenda
//
//  Created by Kaique de Souza Santos on 7/15/20.
//  Copyright © 2020 Kaique Santos Souza. All rights reserved.
//

import UIKit
import RealmSwift

class NewContatoViewModel {
    
    // MARK: - enum
    enum EstadoTela {
        case update
        case insert
    }
    
    // MARK: - Attributes
    var contatoSelecionado: Contato?
    var state: EstadoTela?
    let dataSource = RealmDataSource.shared
    
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
        guard let foto = foto.jpegData(compressionQuality: 0.7) else { return }
        image.imagem = foto
        guard let contato = contatoSelecionado else { return }
        
        switch state {
        case .insert:
            contato.imagens.append(image)
        case .update:
            updateContato(nome: contatoSelecionado?.nome, sobrenome: contatoSelecionado?.sobreNome,
                          imagemPerfil: contatoSelecionado?.imagemPerfil,
                          imagens: image) { (erro) in
                            if erro != nil {
                                print(erro!.localizedDescription)
                            }
            }
        default:
            break
        }
    }

    func insertContato(nome: String?, sobrenome: String?, imagemPerfil: Data?,
                       erro: @escaping(Error?) -> Void) {
        contatoSelecionado?.nome = nome
        contatoSelecionado?.sobreNome = sobrenome
        contatoSelecionado?.imagemPerfil = imagemPerfil
        guard let contato = contatoSelecionado else { return }
        dataSource.realmInsert(contato) { (error) in
            if error == nil {
                erro(nil)
            } else {
                erro(error)
                NSLog(error!.localizedDescription)
            }
        }
    }
    
    func updateContato(nome: String?, sobrenome: String?,
                       imagemPerfil: Data?, imagens: Imagens? = nil,
                       erro: @escaping(Error?) -> Void) {
        guard let contato = contatoSelecionado else { return }
        
        self.dataSource.updateContato(nome: nome, sobrenome: sobrenome,
                                    imagemPerfil: imagemPerfil, imagens: imagens,
                                          contatoToUpdate: contato, erro: {(error) in
                                            if error != nil {
                                                erro(error?.localizedDescription as? Error)
                                            } else {
                                                erro(nil)
                                            }
        })
    }
}
//extension UIImage {
//    enum JPEGQuality: CGFloat {
//        case lowest  = 0
//        case lows     = 0.25
//        case medium  = 0.5
//        case high    = 0.75
//        case highest = 1
//    }
//
//    func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
//        return jpegData(compressionQuality: jpegQuality.rawValue)
//    }
//}
