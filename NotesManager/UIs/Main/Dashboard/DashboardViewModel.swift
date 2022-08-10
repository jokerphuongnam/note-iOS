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
    
    func reloadNotes()
    func loadMoreNotes()
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
    var isLoading: Bool = false
    
    init() {
        
    }
    
    func reloadNotes() {
        DispatchQueue(label: String(describing: Self.self), qos: .utility)
            .asyncAfter(deadline: .now() + 2) {[weak self] in
                guard let self = self else {
                    return
                }
                self.currentIndex = 0
                self.notesObserver.accept(
                    .success(
                        data: (
                            data: self.fakeData,
                            hasNext: true,
                            hasPrev: false
                        )
                    )
                )
                self.isLoading = false
            }
    }
    
    func loadMoreNotes() {
        DispatchQueue(label: String(describing: Self.self), qos: .utility)
            .asyncAfter(deadline: .now() + 2) { [weak self] in
                guard let self = self else {
                    return
                }
                if let notes = self.notes {
                    let newData = notes.data + self.fakeData
                    self.notesObserver.accept(
                        .success(data: (
                            data: newData,
                            hasNext: true,
                            hasPrev: true
                        ))
                    )
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else {
                            return
                        }
                        self.isLoading = false
                    }
                }
            }
    }
    
    var currentIndex = 0
}

private extension DashboardViewModelImpl {
    var fakeData: Notes {
        var data: Notes = []
        let date = Date()
        
        let timeMilliseconds = date.millisecondsSince1970
        for i in 0..<20 {
            data.append(
                .init(
                    id: "\(currentIndex + i)",
                    title: "Title \(currentIndex + i)",
                    description: "sdfbhfkgfdngdfnggndhghghngfhkgfhndghngfhgfjfnhjdhdfhdghnghjnghlgnhdfhnjgfhjgfhfjgnhkd       fdghfgnhdfghllghjgfhjlgfhfgnhfgnhfghfghfghfghkfghngfhnfghnhfgjkhfghfghfghkgfhfghfgnhfgjhdhfghngfhfghfgkhdfnkhfdghfghngfhfdhnfgnhfdjhdfhfdhfghngfhgfhngfhnfgnhfgnhfghfdghngfhfdhnfgnhjfgnhjrtnytrnkytrny34n56j56nk546b4jv 985t 35tu5t u34tu8rtv9u8reu t98er u98ter8u9 89t38 9t3u98tu er98t u9er8t u9t u98teru9 8etru9gtrugutrgvu terugetrug etrgutrgu98trugeuge954p9e4ogertgerogetrgoetrg8yo 3t 88ew8ywre8ywery8wey ge8ygey8ge wry8ge8 yger y8ger8gertygtre7grtygretygeryg regetrgerygy7ger 9ghergherfgher983498 asdhiashidasinfhifah f 8af uoad ufasdhu fas hudfa hsdfa shfhuasdfhasfhsdhfuasdhufa sudfhu asfh uasifasudfa shfi asdfhas hfasuh fah sdfahsdfuasdfhuasdu fas hdfa sdf hasdfh asfhasdhifasiufahsfhuasfhuasfhuasdfh asdhifasi fsah dfhasdfhasfhaweretierth546456h4h65H6356I56h 34u sdfbhfkgfdngdfnggndhghghngfhkgfhndghngfhgfjfnhjdhdfhdghnghjnghlgnhdfhnjgfhjgfhfjgnhkd       fdghfgnhdfghllghjgfhjlgfhfgnhfgnhfghfghfghfghkfghngfhnfghnhfgjkhfghfghfghkgfhfghfgnhfgjhdhfghngfhfghfgkhdfnkhfdghfghngfhfdhnfgnhfdjhdfhfdhfghngfhgfhngfhnfgnhfgnhfghfdghngfhfdhnfgnhjfgnhjrtnytrnkytrny34n56j56nk546b4jv 985t 35tu5t u34tu8rtv9u8reu t98er u98ter8u9 89t38 9t3u98tu er98t u9er8t u9t u98teru9 8etru9gtrugutrgvu terugetrug etrgutrgu98trugeuge954p9e4ogertgerogetrgoetrg8yo 3t 88ew8ywre8ywery8wey ge8ygey8ge wry8ge8 yger y8ger8gertygtre7grtygretygeryg regetrgerygy7ger 9ghergherfgher983498 asdhiashidasinfhifah f 8af uoad ufasdhu fas hudfa hsdfa shfhuasdfhasfhsdhfuasdhufa sudfhu asfh uasifasudfa shfi asdfhas hfasuh fah sdfahsdfuasdfhuasdu fas hdfa sdf hasdfh asfhasdhifasiufahsfhuasfhuasfhuasdfh asdhifasi fsah dfhasdfhasfhaweretierth546456h4h65H6356I56h 34u Description \(i)",
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
        currentIndex += 20
        return data
    }
}
