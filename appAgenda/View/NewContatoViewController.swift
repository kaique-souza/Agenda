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

enum estadoTela {
    case update
    case insert
}

// MARK: - typealias
typealias setup = () -> Void

class NewContatoViewController: UIViewController, imagePickerFotoSelecionada {
    
    // MARK: - Atributos
    var imagePicker = ImagePerfilViewModel()
    var setupRealm: setup?
    var contatoSelecionado: Contato?
    var origem: addFoto?
    var estadoTela: estadoTela?

    // MARK: - Outlets
    @IBOutlet weak var collectionViewNewContato: UICollectionView!
    @IBOutlet weak var textNome: UITextField!
    @IBOutlet weak var textSobrenome: UITextField!
    @IBOutlet weak var imagePerfil: UIImageView!
    @IBOutlet weak var buttonAdicionar: UIButton!
    
    // MARK: - life of cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        state()
        arredondaComponentes()
        carregaDados()
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
    
    func state(){
        if contatoSelecionado == nil {
            contatoSelecionado = Contato(nome: "", sobrenome: "", imagemPerfil: Data())
            estadoTela = .insert
        } else {
            estadoTela = .update
        }
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
        
        switch estadoTela {
        case .update:
            try! realm.write {
                contatoSelecionado?.imagens.append(img)
            }
        case .insert:
            contatoSelecionado?.imagens.append(img)
        default:
            print(Error.self)
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
        guard let contato = contatoSelecionado else { return }
        guard let imagem = UIImage(data: contato.imagemPerfil!) else { return }
        imagePerfil.image = imagem
        textNome.text = contato.nome
        textSobrenome.text = contato.sobreNome
    }
    
    // MARK: IBActions
    @IBAction func buttonSalvar(_ sender: UIButton) {
        guard let nome = textNome.text, let sobreNome = textSobrenome.text, let imagemPerfil = imagePerfil.image?.pngData() else { return }
        guard let contato = contatoSelecionado else { return }
        switch estadoTela {
        case .insert:
            contato.nome = nome
            contato.sobreNome = sobreNome
            contato.imagemPerfil = imagemPerfil
            RealmViewModel().insertContato(contato)
        case .update:
            try! realm.write {
                contato.nome = nome
                contato.sobreNome = sobreNome
                contato.imagemPerfil = imagemPerfil
            }
        default:
            print(Error.self)
        }
        self.setupRealm?()
        encerraTelaNovoContato()
    }
    
    @IBAction func buttonCancelar(_ sender: UIButton) {
        encerraTelaNovoContato()
    }
    
    
    @IBAction func adicionar(_ sender: Any) {
        let menu = ImagePerfilViewModel().menuDeOpcoes { (opcao) in
            self.origem = .buttonAdicionar
            self.mostrarMultimidia(opcao)
        }
        present(menu, animated: true, completion: nil)
    }
}

// MARK: - Extensions
extension NewContatoViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let index = contatoSelecionado?.imagens.count ?? 0
        
        if (index == indexPath.row) {
            let menu = ImagePerfilViewModel().menuDeOpcoes { (opcao) in
                self.origem = .collectionViewl
                self.mostrarMultimidia(opcao)
            }
            present(menu, animated: true, completion: nil)
        }
    }
}

extension NewContatoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let contato = contatoSelecionado else { return 1}
        return contato.imagens.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let celula = collectionViewNewContato.dequeueReusableCell(withReuseIdentifier: "CelulaCollectionViewContatos", for: indexPath) as? ContatoCollectionViewCell {
            let index = contatoSelecionado?.imagens.count ?? 0
            
            if  index == indexPath.row {
                if #available(iOS 13.0, *) {
                    celula.imageviewCelula.image = UIImage(systemName: "folder.badge.plus")
                }
            } else if let contato = contatoSelecionado {
                let imagem = UIImage(data: contato.imagens[indexPath.row].imagem)
                celula.imageviewCelula.image = imagem
            }
            return celula
        } else {
            return UICollectionViewCell()
        }
    }
}
