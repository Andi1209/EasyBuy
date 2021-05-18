//
//  ItemDetailMock.swift
//  EasyBuyTests
//
//  Created by Andres Felipe Nunez on 17/05/21.
//
@testable import EasyBuy
import Foundation


struct ItemModelMock  {
    
    func initMock()->ItemModel{
        let attributes:[AttributesModel] = [AttributesModel(title: "Marca", vale: "MlSTATIC"),]
        let item = ItemModel(name: "Pijama Para Carro En Algodón Impermeable Talla L", condition: true, soldQuantity: 500, price: "$ 150,000", currency: "COP", installments: "Compralo en 12x $ 12,500", address: "Barrios Unidos - Bogotá D.C.", image: "http://http2.mlstatic.com/D_788190-MCO30578613720_052019-I.jpg", freeShipping: true, attributes: attributes)
        return item
    }
   
}
