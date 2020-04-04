//
//  PersonPlayListProtocols.swift
//  MusicApp
//
//  Created Sang on 4/4/20.
//  Copyright © 2020 SangNX. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation

//MARK: Wireframe -
protocol PersonPlayListWireframeProtocol: class {

}
//MARK: Presenter -
protocol PersonPlayListPresenterProtocol: class {

}

//MARK: Interactor -
protocol PersonPlayListInteractorProtocol: class {

  var presenter: PersonPlayListPresenterProtocol?  { get set }
}

//MARK: View -
protocol PersonPlayListViewProtocol: class {

  var presenter: PersonPlayListPresenterProtocol?  { get set }
}