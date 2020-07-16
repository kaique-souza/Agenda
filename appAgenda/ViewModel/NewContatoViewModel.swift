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
    
    // MARK: - Constructor
    init(_ contato: Contato? = nil) {
        checkContact(contato)
    }
    
    // MARK: - methods
    func checkContact(_ contato: Contato?) {
        if contato == nil {
            contatoSelecionado = Contato(nome: "", sobrenome: "", imagemPerfil: Data())
        } else {
            contatoSelecionado = contato
        }
     }
    
    func state () -> estadoTela{
        if contatoSelecionado == nil {
            return .insert
        } else {
            return .update
        }
    }
}
