//
//  TransactionsPresenterPresenter.swift
//  BankUXS
//
//  Created by Carlos Colmenares on 1/10/18.
//  Copyright (c) 2018 Carlos Colmenares. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol TransactionsPresenterPresentationLogic
{
  func presentSomething(response: TransactionsPresenter.Something.Response)
}

class TransactionsPresenterPresenter: TransactionsPresenterPresentationLogic
{
  weak var viewController: TransactionsPresenterDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: TransactionsPresenter.Something.Response)
  {
    let viewModel = TransactionsPresenter.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}
