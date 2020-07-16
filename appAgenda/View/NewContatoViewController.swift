//
//  NewContatoViewController.swift
//  appAgenda
//
//  Created by Kaique Santos Souza on 7/8/20.
//  Copyright © 2020 Kaique Santos Souza. All rights reserved.
//

import UIKit

// MARK: - Enum
enum addFoto {
    case buttonAdicionar
    case collectionViewl
}

// MARK: - typealias
typealias setup = () -> Void

class NewContatoViewController: UIViewController, imagePickerFotoSelecionada {
    
    // MARK: - Atributos
    var imagePicker = ImagePerfil()
    var setupRealm: setup?
    var viewModel: NewContatoViewModel
    var origem: addFoto?

    // MARK: - Outlets
    @IBOutlet weak var collectionViewNewContato: UICollectionView!
    @IBOutlet weak var textNome: UITextField!
    @IBOutlet weak var textSobrenome: UITextField!
    @IBOutlet weak var imagePerfil: UIImageView!
    @IBOutlet weak var buttonAdicionar: UIButton!
    
    init(_ contato: Contato? = nil) {
        self.viewModel = NewContatoViewModel(contato)
        super.init(nibName: String(describing: NewContatoViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - life of cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        carregaDados()
        arredondaComponentes()
        setupCollectionview()
    }
    
    // MARK: - Metodos
    func setupCollectionview() {
        imagePicker.delegate = self 
        collectionViewNewContato.delegate = self
        collectionViewNewContato.dataSource = self
        collectionViewNewContato.register(UINib(nibName: String(describing: ContatoCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: ContatoCollectionViewCell.identifier())
        collectionViewNewContato.reloadData()
    }
    
    func imagePickerFotoSelecionada (_ foto: UIImage) {
        switch origem {
        case .buttonAdicionar:
            imagePerfil.image = foto
        case .collectionViewl:
            addImage(foto)
        default:
            print(Error.self)
            break
        }
    }
    
    func addImage(_ foto: UIImage){
        let img = Imagens()
        guard let foto = foto.pngData() else { return }
        img.imagem = foto
        let estado = viewModel.state()
        if estado == .insert {
            viewModel.contatoSelecionado?.imagens.append(img)
        } else {
            try! realm.write {
                viewModel.contatoSelecionado?.imagens.append(img)
            }
        }
        collectionViewNewContato.reloadData()
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
    
    func arredondaComponentes() {
        imagePerfil.layer.cornerRadius = imagePerfil.frame.width / 2
        imagePerfil.layer.borderColor = UIColor.lightGray.cgColor
        imagePerfil.layer.borderWidth = 1
        buttonAdicionar.layer.cornerRadius = 5
        buttonAdicionar.layer.masksToBounds = true
    }
    
    func encerraTelaNovoContato() {
        self.dismiss(animated: false, completion: nil)
    }
    
    func carregaDados() {
        guard let contato = viewModel.contatoSelecionado else { return }
        guard let imagem = UIImage(data: contato.imagemPerfil!) else { return }
        imagePerfil.image = imagem
        textNome.text = contato.nome
        textSobrenome.text = contato.sobreNome
    }
    
    // MARK: IBActions
    @IBAction func buttonSalvar(_ sender: UIButton) {
//        guard let nome = textNome.text, let sobreNome = textSobrenome.text, let imagemPerfil = imagePerfil.image?.pngData() else { return }
        
        guard let contato = viewModel.contatoSelecionado else { return }
        let estado = viewModel.state()
        
        if estado == .insert {
            contato.nome = textNome.text
            contato.sobreNome = textSobrenome.text
            contato.imagemPerfil = imagePerfil.image?.pngData()
            RealmDataSource().insertContato(contato)
        } else {
            try! realm.write {
                contato.nome = textNome.text
                contato.sobreNome = textSobrenome.text
                contato.imagemPerfil = imagePerfil.image?.pngData()
            }
        }
        self.setupRealm?()
        encerraTelaNovoContato()
    }
    
    @IBAction func buttonCancelar(_ sender: UIButton) {
        encerraTelaNovoContato()
    }
    
    
    @IBAction func adicionar(_ sender: Any) {
        let menu = ImagePerfil().menuDeOpcoes { (opcao) in
            self.origem = .buttonAdicionar
            self.mostrarMultimidia(opcao)
        }
        present(menu, animated: true, completion: nil)
    }
}

// MARK: - Extensions
extension NewContatoViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let index = viewModel.contatoSelecionado?.imagens.count ?? 0
        
        if (index == indexPath.row) {
            let menu = ImagePerfil().menuDeOpcoes { (opcao) in
                self.origem = .collectionViewl
                self.mostrarMultimidia(opcao)
            }
            present(menu, animated: true, completion: nil)
        }
    }
}

extension NewContatoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let contato = viewModel.contatoSelecionado else { return 0}
        return contato.imagens.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let celula = collectionViewNewContato.dequeueReusableCell(withReuseIdentifier: ContatoCollectionViewCell.identifier(), for: indexPath) as? ContatoCollectionViewCell {
            let index = viewModel.contatoSelecionado?.imagens.count ?? 0
            
            if index == indexPath.row {
                celula.personalizeCell()
                //UIImage(systemName: "folder.badge.plus")
            } else if let contato = viewModel.contatoSelecionado {
                let imagem = UIImage(data: contato.imagens[indexPath.row].imagem)
                celula.imageviewCelula.image = imagem
            }
            return celula
        } else {
            return UICollectionViewCell()
        }
    }
}
