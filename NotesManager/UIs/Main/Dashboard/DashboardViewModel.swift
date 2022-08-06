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
                    data: {
                        var data: Notes = []
                        let date = Date()
                        
                        let timeMilliseconds = date.millisecondsSince1970
                        for i in 0...40 {
                            data.append(
                                .init(
                                    id: "\(i)",
                                    title: "title \(i)",
                                    description: "description \(i)",
                                    color:  UIColor(
                                        red:  CGFloat(255 - (i * 2)) / 255.0,
                                        green:  1,
                                        blue:  CGFloat(255 - (i * 3)) / 255.0,
                                        alpha: 1
                                    ),
                                    createAt: timeMilliseconds,
                                    updateAt: timeMilliseconds
                                )
                            )
                        }
                        return data
                    }(),
                    hasNext: false,
                    hasPrev: false
                )
            )
        )
    }
}
