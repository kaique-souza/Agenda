//
//  Contato.swift
//  appAgenda
//
//  Created by Kaique Santos Souza on 7/6/20.
//  Copyright © 2020 Kaique Santos Souza. All rights reserved.
//

import UIKit
import RealmSwift

class Contato: Object {
    
    @objc dynamic var nome: String? = ""
    @objc dynamic var sobreNome: String? = ""
    @objc dynamic var imagemPerfil: Data? = nil
    //@objc dynamic var imagens = Array<Data>()
    
    convenience init(nome: String, sobrenome: String, imagemPerfil: Data) {
        self.init()
        self.nome = nome
        self.sobreNome = sobrenome
        self.imagemPerfil = imagemPerfil
    }
}
