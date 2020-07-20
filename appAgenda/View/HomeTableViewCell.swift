//
//  HomeTableViewCell.swift
//  appAgenda
//
//  Created by Kaique Santos Souza on 7/6/20.
//  Copyright © 2020 Kaique Santos Souza. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    // MARK: - Atributos
    var contatoSelecionado: Contato?
    // MARK: - Outlets
    @IBOutlet weak var viewImagePerfil: UIView!
    @IBOutlet weak var imagePerfil: UIImageView!
    @IBOutlet weak var labelNomeCompleto: UILabel!
    @IBOutlet weak var collectionViewContatos: UICollectionView!
    
    
    // MARK: - life of cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Metodos
    func setupCelula(_ contato: Contato) {
        guard let nome = contato.nome else { return }
        guard let sobreNome = contato.sobreNome else { return }
        
        labelNomeCompleto.text = "\(nome) \(sobreNome)"
        
        guard let imagem = UIImage(data: contato.imagemPerfil!) else { return }
        imagePerfil.image = imagem
        
        fotmatViewImagePerfil()
        setupCollectionView()
    }
    
    static func identifier() -> String {
        return "CelulaContatos"
    }
    
    func fotmatViewImagePerfil() {
        viewImagePerfil.layer.cornerRadius = viewImagePerfil.frame.width / 2
        viewImagePerfil.layer.borderWidth = 1
        viewImagePerfil.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func setupCollectionView() {
        collectionViewContatos.delegate =  self
        collectionViewContatos.dataSource =  self
        collectionViewContatos.register(UINib(nibName:
            String(describing: ContatoCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: "CelulaCollectionViewContatos")
        collectionViewContatos.reloadData()
    }
}

extension HomeTableViewCell: UICollectionViewDelegate {
}

extension HomeTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let contato = contatoSelecionado else { return 0}
        return contato.imagens.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let celula = collectionViewContatos.dequeueReusableCell(
            withReuseIdentifier: ContatoCollectionViewCell.identifier(), for: indexPath)
            as? ContatoCollectionViewCell, let imagens = contatoSelecionado?.imagens[indexPath.row] {
            celula.backgroundColor = UIColor.black
            celula.setupCelula(imagens)
            return celula
        }
       return ContatoCollectionViewCell()
    }
}
