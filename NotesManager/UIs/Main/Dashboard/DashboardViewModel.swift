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
    var isLoading: Bool { get set }
    
    func reloadNotes(searchWords: String?)
    func loadMoreNotes()
}

final class DashboardViewModelImpl: DashboardViewModel {
    private var useCase: DashboardUseCase!
    private let disposeBag = DisposeBag()
    
    var notesObserver: BehaviorRelay<Resource<PagingArray<Note>>> = BehaviorRelay(value: .`init`)
    var notes: PagingArray<Note>? {
        if case .success(data: let data) = notesObserver.value {
            return data
        }
        return nil
    }
    var isLoading: Bool = false
    
    init(useCase: DashboardUseCase) {
        self.useCase = useCase
    }
    
    deinit {
        useCase = nil
    }
    
    var paging: Int = 0
    func reloadNotes(searchWords: String? = nil) {
        paging = 0
        notesObserver.accept(.loading)
        useCase.getNotes(page: 0, searchWords: searchWords)
            .subscribe { [weak self] paingNotes in
                guard let self = self else { return }
                self.paging += 1
                self.notesObserver.accept(.success(data: paingNotes))
            } onFailure: { error in
                
            } onDisposed: {
                
            }
            .disposed(by: disposeBag)
    }
    
    func loadMoreNotes() {
        let oldNotes = notes
        notesObserver.accept(.loading)
        useCase.getNotes(page: paging, searchWords: nil)
            .subscribe { [weak self] paingNotes in
                guard let self = self else { return }
                self.paging += 1
                if let notes = oldNotes {
                    let newNote = notes.data + paingNotes.data
                    self.notesObserver.accept(
                        .success(
                            data: (
                                data: newNote,
                                hasNext: paingNotes.hasNext,
                                hasPrev: paingNotes.hasPrev
                            )
                        )
                    )
                } else {
                    self.notesObserver.accept(.success(data: paingNotes))
                }
            } onFailure: { [weak self] error in
                guard let self = self else { return }
                if let oldNotes = oldNotes {
                    self.notesObserver.accept(.success(data: oldNotes))
                }
            } onDisposed: {
                
            }
            .disposed(by: disposeBag)
    }
}
