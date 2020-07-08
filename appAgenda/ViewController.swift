//
//  ViewController.swift
//  appAgenda
//
//  Created by Kaique Santos Souza on 7/6/20.
//  Copyright © 2020 Kaique Santos Souza. All rights reserved.
//

import RealmSwift
import UIKit

let realm = try! Realm()

class ViewController: UIViewController {

    @IBOutlet weak var labelteste: UILabel!
    @IBOutlet weak var labelIdade: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let contatoUm = Contato()
//        contatoUm.name = "Maria"
//        contatoUm.idade = 20
//
//        realm.beginWrite()
//        realm.add(contatoUm)
//        try! realm.commitWrite()
        
//        let contato = realm.objects(Contato.self)
//
//        for pessoa in contato {
//            labelteste.text = pessoa.name
//            labelIdade.text = "\(pessoa.idade)"
//
//            realm.beginWrite()
//            realm.delete(realm.objects(Contato.self))
//            try! realm.commitWrite()
                   
//        }
    }


}

