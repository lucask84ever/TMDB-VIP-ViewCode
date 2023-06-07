//
//  ViewController.swift
//  TMDB
//
//  Created by Lucas Lima on 22/05/23.
//

import UIKit

open class BaseViewController<Interactor, V: UIView>: UIViewController, ViewCodeProtocol {
    // MARK: - Properties

    public let interactor: Interactor

    public var rootView = V()

    // MARK: - Initialization

    public init(interactor: Interactor) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle

    override open func loadView() {
        view = rootView
    }

    override open func viewDidLoad() {
        super.viewDidLoad()

        buildViewLayout()
    }

    // MARK: - ViewCodable

    open func buildViewHierarchy() { }

    open func buildViewConstraints() { }

    open func additionalConfig() { }
}

// MARK: - ViewController where Interactor == Void

public extension BaseViewController where Interactor == Void {
    convenience init(_ interactor: Interactor = ()) {
        self.init(interactor: interactor)
    }
}
