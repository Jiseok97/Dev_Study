import UIKit
import RxSwift
import RxCocoa
import PlaygroundSupport

// MARK: - Ignore
/// 끝날 때 구독 내용 호출됨, 그 전 요소 추가되도 무시
//let strikes = PublishSubject<String>()
//
//let disposeBag = DisposeBag()
//
//strikes
//    .ignoreElements()
//    .subscribe { _ in
//        print("Subscription is called")
//    }.disposed(by: disposeBag)
//
//strikes.onNext("A")
//strikes.onNext("B")
//strikes.onNext("C")
//
//strikes.onCompleted()


// MARK: - elementAt(Index)
// 해당 인덱스일 때 구독 기능 활성화

//let strikes = PublishSubject<String>()
//
//let disposeBag = DisposeBag()
//
//strikes.elementAt(2)
//    .subscribe(onNext: { _ in
//        print("Current index is 2")
//    })
//
//strikes.onNext("X1")
//strikes.onNext("X2")
//strikes.onNext("X3")
//strikes.onNext("X4")


// MARK: - Base

//// Int
//let observable = Observable.just(1)
//
//// Int
//let observable2 = Observable.of(1,2,3)
//
//// Array
//let observable3 = Observable.of([1,2,3])
//
//// Int
//let observable4 = Observable.from([1,2,3,4,5])
//
///// 언래핑 필요 O
//observable4.subscribe { event in
//    if let element = event.element {
//        print("DEBUG: need unwrapping, element is \(element)")
//    }
//}
//observable3.subscribe { event in
//    if let element = event.element {
//        print("DEBUG: element is \(element)")
//    }
//}
//
//
///// 언래핑 필요 X
//observable4.subscribe(onNext: { element in
//    print("DEBUG: need not unwarapping, element is \(element)")
//}, onCompleted: {
//    print("DEBUG: onCompleted")
//})
////
////// Dispose → 구독 해제
//let subscription = observable4.subscribe(onNext: { element in
//    print("DEBUG: element is \(element)")
//})
//// 구독 해제, 더 이상의 이벤트 발생 X
//subscription.dispose()
//
//
//// MARK: - DisposeBag
//
//// DisposeBag → disposeBag = DisposeBag() 이렇게 사용가능
//// 한번에 모든 Observer를 지워준다.
//// 각각의 비동기 작업들을 disposeBag에 담아두고 한번에 처분하는 형식
//var disposeBag = DisposeBag()
//let observable = Observable.from([1,2,3,4])
//
//observable.subscribe(onNext: { element in
//    print("DEBUG: element is \(element)")
//}, onDisposed: {
//    print("Dispose")
//}).disposed(by: disposeBag)
//
//disposeBag = nil
////print("DEBUG: disposbag = DisposeBag()")
//
//observable.subscribe(onNext: { element in
//    print("DEBUG: element is \(element)")
//})


//Observable.of("A", "B", "C")
//    .subscribe {
//        print("DEBUG: value is \($0)")
//    }.disposed(by: disposeBag)


//
//Observable<String>.create { observer in
//
//    observer.onNext("A")
//    observer.onCompleted()
//    observer.onNext("?")    // 호출 안됨, onCompleted 선언
//
//    // 일회성이기 때문에 반드시 다시 생성되지 않도록 반환하기
//    return Disposables.create()
//}.subscribe {
//    print("DEBUG: subscribe is \($0)")
//} onError: {
//    print("DEBUG: onError is \($0)")
//} onCompleted: {
//    print("DEBUG: onCompleted")
//} onDisposed: {
//    print("DEBUG: onDisposed")
//}
//
//// MARK: - PublishSubject
//
//let disposeBag = DisposeBag()
//
//let subject = PublishSubject<String>()
//
//subject.onNext("Event 1")       // 구독 전이라 Event 1은 출력되지 않는다.
//
//subject.subscribe { event in
//    print("DEBUG: event is \(event)")
//}
//
//subject.onNext("Event 2")
//subject.onNext("Event 3")
//
//subject.onCompleted()
//
//subject.dispose()
//
//subject.onNext("Event 4")       // Dispose로 인해 더 이상 구독되지 않아 출력 X
//
//
//// MARK: - BehaviorSubject
//
//let disposeBag = DisposeBag()
////
////// BehaviorSubject 반드시 초기값을 가지고 생성
////// 구독 전 이벤트 중 최신 이벤트만 전달 받는다
//let subject = BehaviorSubject(value: "Initial value")
//
//subject.onNext("Start event")       // Event 1이 가장 최신이므로 Start event는 전달 X
//subject.onNext("Event 1")
//
//subject.subscribe { event in
//    print("DEBUG: event is \(event)")
//}
//
//subject.onNext("Event 2")
//subject.onNext("Event 3")
//
//
//// MARK: - ReplaySubject
//
let disposeBag = DisposeBag()

//// 버퍼의 크기만큼만 구독 전 최신 이벤트를 전달 받을 수 있다.
let subject = ReplaySubject<String>.create(bufferSize: 2)

subject.onNext("Event 1")           // 버퍼 크기가 2이므로, Event 1은 발생 X
subject.onNext("Event 2")
subject.onNext("Event 3")

subject.subscribe { event in
    print("DEBUG: event is \(event)")
}
//
//subject.onNext("Event 4")           // 두번째 구독에서 버퍼 크키가 2이므로, Event 4는 두번째 구독에서 전달 X
//subject.onNext("Event 5")
//subject.onNext("Event 6")
//
//print("DEBUG: Subscribe 2")
//
//subject.subscribe {
//    print("DEBUG: Second subscribe event is \($0)")
//}
//
//
//// MARK: - BehaviorRelay
//
//// Variable이 사용이 되지 않음에 따라 BehaviorRelay을 사용한다.
//// BehaviorRelay는 RxRelay 모듈에서 사용 가능 → Podfile_RxCocoa
//
//let disposeBag = DisposeBag()
//
//let relay = BehaviorRelay(value: "Initial Value")
//let arrayRelay = BehaviorRelay(value: [String]())       // Array
//var arrayValue = arrayRelay.value
//
//relay.accept("Hello World")
//relay.asObservable()
//    .subscribe {
//        print("DEBUG: value is \($0)")
//    }
//relay.accept("Goodbye World")
//
//
//// 배열 값 넣기 방법 1
//// value에 append해주고 그 value를 accept 해주기
//arrayValue.append("Item 1")
//arrayRelay.accept(arrayValue)
//
//arrayRelay.asObservable()
//    .subscribe {
//        print("DEBUG: arrayRelay Item is \($0)")
//    }
//
//arrayValue.append("Item 2")
//arrayRelay.accept(arrayValue)
//
//
//// 배열 값 넣기 방법 2
//// 기존 value 값에 더해주기
//let arrayRelay2 = BehaviorRelay(value: ["Item 1"])
//arrayRelay2.accept(arrayRelay2.value + ["Item 2"])
//arrayRelay2.asObservable()
//    .subscribe {
//        print("DEBUG: arrayRelay2 item is \($0)")
//    }
