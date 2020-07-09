//
//  HomeViewViewController.swift
//  appAgenda
//
//  Created by Kaique Santos Souza on 7/6/20.
//  Copyright © 2020 Kaique Santos Souza. All rights reserved.
//

import UIKit
import RealmSwift

class HomeViewViewController: UIViewController {
    
    // MARK: - Properts
    
    // MARK: - Atributs
    //let teste = ["Maria", "joao", "jose", "Kaique", "Kaio", "Marcio"]
    var listaContatos: Array<Contato> = []
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - life of cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRealm()
        setupTableView()
    }

    // Mark: - Metodos
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register (UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "CelulaContatos")
        tableView.reloadData()
    }
    
    func setupRealm(){
        let realm = try! Realm()
        let results = realm.objects(Contato.self)
        listaContatos = Array(results)
        tableView.reloadData()
    }
  
    @IBAction func buttonNovo(_ sender: Any) {
        let controller = NewContatoViewController(nibName: "NewContatoViewController", bundle: nil)
        controller.setupRealm = self.setupRealm
        present(controller, animated: true, completion: nil)
    }
}

extension HomeViewViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaContatos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celula = tableView.dequeueReusableCell(withIdentifier: "CelulaContatos", for: indexPath) as! HomeTableViewCell
        let contato = listaContatos[indexPath.row]
//        celula.tamanhoColletionView = contato.imagens.count
        celula.formatCelula(contato)
        
        return celula
    }
}

extension HomeViewViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Lista de Contatos"
    }
}
