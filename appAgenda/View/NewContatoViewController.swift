//
//  NewContatoViewController.swift
//  appAgenda
//
//  Created by Kaique Santos Souza on 7/8/20.
//  Copyright © 2020 Kaique Santos Souza. All rights reserved.
//

import UIKit

// MARK: - typealias
typealias setup = () -> Void

class NewContatoViewController: UIViewController, imagePickerFotoSelecionada {
    
    // MARK: - Atributos
    var imagePicker = ImagePerfilViewModel()
    var setupRealm: setup?
    var contatoSelecionado: Contato?

    // MARK: - Outlets
    @IBOutlet weak var collectionViewNewContato: UICollectionView!
    @IBOutlet weak var textNome: UITextField!
    @IBOutlet weak var textSobrenome: UITextField!
    @IBOutlet weak var imagePerfil: UIImageView!
    @IBOutlet weak var buttonAdicionar: UIButton!
    
    // MARK: - life of cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        arredondaComponentes()
        carregaDados()
        setupCollectionview()
        
    }
    
    // MARK: - Metodos
    func setupCollectionview() {
        imagePicker.delegate = self 
        collectionViewNewContato.delegate = self
        collectionViewNewContato.dataSource = self
        collectionViewNewContato.register(UINib(nibName: String(describing: ContatoCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: "CelulaCollectionViewContatos")
        collectionViewNewContato.reloadData()
    }
    
    func imagePickerFotoSelecionada (_ foto: UIImage){
        imagePerfil.image = foto
    }
    
    func mostrarMultimidia(_ opcao:MenuOpcoes) {
        let multimidia = UIImagePickerController()
        multimidia.delegate = imagePicker
        
        if opcao == .camera && UIImagePickerController.isSourceTypeAvailable(.camera) {
            multimidia.sourceType = .camera
        }
        else {
            multimidia.sourceType = .photoLibrary
        }
        self.present(multimidia, animated: true, completion: nil)
    }
    
    func arredondaComponentes(){
        imagePerfil.layer.cornerRadius = imagePerfil.frame.width / 2
        imagePerfil.layer.borderColor = UIColor.lightGray.cgColor
        imagePerfil.layer.borderWidth = 1
        
        buttonAdicionar.layer.cornerRadius = 5
        buttonAdicionar.layer.masksToBounds = true
        
    }
    
    func encerraTelaNovoContato(){
        self.dismiss(animated: false, completion: nil)
    }
    
    func carregaDados(){
        guard let contato = contatoSelecionado else { return }
        guard let imagem = UIImage(data: contato.imagemPerfil!) else { return }
        imagePerfil.image = imagem
        
        textNome.text = contato.nome
        textSobrenome.text = contato.sobreNome
    }
    
    // MARK: IBActions
    
    @IBAction func buttonSalvar(_ sender: UIButton) {
        guard let nome = textNome.text else { return }
        guard let sobreNome = textSobrenome.text else { return }
        guard let imagemPerfil = imagePerfil.image?.pngData() else { return }
        let contato = Contato(nome: nome, sobrenome: sobreNome, imagemPerfil: imagemPerfil)
        RealmViewModel().insertContato(contato)
        self.setupRealm?()
        encerraTelaNovoContato()
    }
    
    @IBAction func buttonCancelar(_ sender: UIButton) {
        encerraTelaNovoContato()
    }
    
    
    @IBAction func adicionar(_ sender: Any) {
        let menu = ImagePerfilViewModel().menuDeOpcoes { (opcao) in
            self.mostrarMultimidia(opcao)
        }
        present(menu, animated: true, completion: nil)
    }
    
}

// MARK: - Extensions
extension NewContatoViewController: UICollectionViewDelegate{
    
}

extension NewContatoViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celula = collectionViewNewContato.dequeueReusableCell(withReuseIdentifier: "CelulaCollectionViewContatos", for: indexPath) as! ContatoCollectionViewCell
        return celula
    }
}

extension NewContatoCollectionViewCell: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}
