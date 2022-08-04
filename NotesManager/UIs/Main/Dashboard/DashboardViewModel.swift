//
//  DashboardViewModel.swift
//  NotesManager
//
//  Created by pnam on 04/08/2022.
//

@_implementationOnly import RxSwift
@_implementationOnly import RxCocoa
@_implementationOnly import RxRelay

protocol DashboardViewModel {
    var notesObserver: BehaviorRelay<Resource<PagingArray<Note>>> { get }
    var notes: PagingArray<Note>? { get }
    func reloadNotes()
}

final class DashboardViewModelImpl: DashboardViewModel {
    private let disposeBag = DisposeBag()
    var notesObserver: BehaviorRelay<Resource<PagingArray<Note>>> = BehaviorRelay(value: .`init`)
    var notes: PagingArray<Note>? {
        if case .success(data: let data) = notesObserver.value {
            return data
        }
        return nil
    }
    
    init() {
        
    }
    
    func reloadNotes() {
        notesObserver.accept(
            .success(
                data: (
                    data: [
                        .init(id: "1", title: "test", description: "test", color: "#ffffff", createAt: 12, updateAt: 12),
                        .init(id: "1", title: "test", description: "test", color: "#ffffff", createAt: 12, updateAt: 12),
                        .init(id: "1", title: "test", description: "test", color: "#ffffff", createAt: 12, updateAt: 12),
                        .init(id: "1", title: "test", description: "test", color: "#ffffff", createAt: 12, updateAt: 12),
                        .init(id: "1", title: "test", description: "test", color: "#ffffff", createAt: 12, updateAt: 12),
                        .init(id: "1", title: "test", description: "test", color: "#ffffff", createAt: 12, updateAt: 12),
                        .init(id: "1", title: "test", description: "test", color: "#ffffff", createAt: 12, updateAt: 12),
                        .init(id: "1", title: "test", description: "test", color: "#ffffff", createAt: 12, updateAt: 12),
                        .init(id: "1", title: "test", description: "test", color: "#ffffff", createAt: 12, updateAt: 12),
                        .init(id: "1", title: "test", description: "test", color: "#ffffff", createAt: 12, updateAt: 12),
                        .init(id: "1", title: "test", description: "test", color: "#ffffff", createAt: 12, updateAt: 12),
                        .init(id: "1", title: "test", description: "test", color: "#ffffff", createAt: 12, updateAt: 12),
                        .init(id: "1", title: "test", description: "test", color: "#ffffff", createAt: 12, updateAt: 12),
                        .init(id: "1", title: "test", description: "test", color: "#ffffff", createAt: 12, updateAt: 12),
                        .init(id: "1", title: "test", description: "test", color: "#ffffff", createAt: 12, updateAt: 12),
                        .init(id: "1", title: "test", description: "test", color: "#ffffff", createAt: 12, updateAt: 12),
                        .init(id: "1", title: "test", description: "test", color: "#ffffff", createAt: 12, updateAt: 12),
                        .init(id: "1", title: "test", description: "test", color: "#ffffff", createAt: 12, updateAt: 12),
                        .init(id: "1", title: "test", description: "test", color: "#ffffff", createAt: 12, updateAt: 12),
                        .init(id: "1", title: "test", description: "test", color: "#ffffff", createAt: 12, updateAt: 12),
                        .init(id: "1", title: "test", description: "test", color: "#ffffff", createAt: 12, updateAt: 12),
                        .init(id: "1", title: "test", description: "test", color: "#ffffff", createAt: 12, updateAt: 12),
                        .init(id: "1", title: "test", description: "test", color: "#ffffff", createAt: 12, updateAt: 12),
                        .init(id: "1", title: "test", description: "test", color: "#ffffff", createAt: 12, updateAt: 12),
                        .init(id: "1", title: "test", description: "test", color: "#ffffff", createAt: 12, updateAt: 12),
                        .init(id: "1", title: "test", description: "test", color: "#ffffff", createAt: 12, updateAt: 12),
                        .init(id: "1", title: "test", description: "test", color: "#ffffff", createAt: 12, updateAt: 12),
                        .init(id: "1", title: "test", description: "test", color: "#ffffff", createAt: 12, updateAt: 12),
                        .init(id: "1", title: "test", description: "test", color: "#ffffff", createAt: 12, updateAt: 12),
                        .init(id: "1", title: "test", description: "test", color: "#ffffff", createAt: 12, updateAt: 12),
                        .init(id: "1", title: "test", description: "test", color: "#ffffff", createAt: 12, updateAt: 12),
                        .init(id: "1", title: "test", description: "test", color: "#ffffff", createAt: 12, updateAt: 12),
                        .init(id: "1", title: "test", description: "test", color: "#ffffff", createAt: 12, updateAt: 12)
                    ],
                    hasNext: false,
                    hasPrev: false
                )
            )
        )
    }
}
