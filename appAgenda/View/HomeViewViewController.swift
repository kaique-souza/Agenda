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
    // MARK: - Atributs
    var listaContatos: [Contato] = []
    var viewmodel = HomeViewModel()
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - life of cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRealm()
        setupTableView()
    }

    // MARK: - Metodos
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: String(describing: HomeTableViewCell.self),
                                  bundle: nil), forCellReuseIdentifier: HomeTableViewCell.identifier())
        tableView.reloadData()
    }
    
    func setupRealm() {
        listaContatos  = viewmodel.setupRealm()
        tableView.reloadData()
    }
    
    func instatiateCell(_ contato: Contato? = nil) {
        let controller = NewContatoViewController(contato)
        controller.setupRealm = self.setupRealm
        present(controller, animated: true, completion: nil)
    }
    
    // MARK: - IBActions
    @IBAction func buttonNovo(_ sender: Any) {
        instatiateCell()
    }
}

// MARK: - Extensions
extension HomeViewViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaContatos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let celula = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier(),
                                                         for: indexPath)
            as? HomeTableViewCell else {return HomeTableViewCell()}
        let contato = listaContatos[indexPath.row]
        celula.contatoSelecionado = contato
        celula.setupCelula(contato)
        return celula
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        instatiateCell(listaContatos[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            
            let contato = self.viewmodel.setupRealm()
            self.viewmodel.deleteContato(contato[indexPath.row])
            self.listaContatos.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension HomeViewViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Lista de Contatos"
    }
}
