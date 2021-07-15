import UIKit
import Foundation
import RxSwift
import RxCocoa

class OnboardingViewController: UIViewController {
    typealias ViewModelType = OnboardingViewModel
    var viewModel: OnboardingViewModel! = OnboardingViewModel(repository: UserDefaultsRepository())
    var songsViewModel = SongsViewModel()
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageController: CustomPageControl!
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var nextButton: CustomButton!
    
    private var disposeBag = DisposeBag()
    private var currentPage = BehaviorSubject<Int>(value: 0)
    private var onboardingScreens: [UICollectionViewCell] = []
    
    private var onboardingScreensInfo = [
        (xib: "MainChildInfoView", cell: "cell_info"),
        (xib: "ScheduleInfoView", cell: "cell_schedule"),
        (xib: "SongsInfoView", cell: "cell_songs"),
    ]
    
    private var mainChildInfoView = MainChildInfoView()
    private var scheduleInfoView = ScheduleInfoView()
    private var songsInfoView = SongsInfoView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onboardingScreensInfo.forEach { screenInfo in
            self.collectionView.register(UINib(nibName: screenInfo.xib, bundle: nil), forCellWithReuseIdentifier: screenInfo.cell)
        }
        collectionView.register(SongsInfoView.self, forCellWithReuseIdentifier: "cell_songs")
        
        mainChildInfoView = collectionView.dequeueReusableCell(withReuseIdentifier: onboardingScreensInfo[0].cell, for: IndexPath(item: 0, section: 0)) as! MainChildInfoView
        onboardingScreens.append(mainChildInfoView)
        
        scheduleInfoView = collectionView.dequeueReusableCell(withReuseIdentifier: onboardingScreensInfo[1].cell, for: IndexPath(item: 1, section: 0)) as! ScheduleInfoView
        scheduleInfoView.instantiate()
        onboardingScreens.append(scheduleInfoView)
        
        songsInfoView = collectionView.dequeueReusableCell(withReuseIdentifier: onboardingScreensInfo[2].cell, for: IndexPath(item: 2, section: 0)) as! SongsInfoView
        songsInfoView.configure(with: songsViewModel.transform(input: SongsViewModel.Input()).songs)
        onboardingScreens.append(songsInfoView)
        
        collectionView.reloadData()
        
        bindMainChildInfo()
        bindScheduleInfoView()
        
        nextButton.rx.tap.bind { [unowned self] in
            self.onNextButtonTapped()
        }
        .disposed(by: disposeBag)
        
        currentPage.subscribe(onNext: { [unowned self] value in
            pageController.currentPage = value
            setInformationLabelText(currentPage: value)
        })
        .disposed(by: disposeBag)
    }

    private func onNextButtonTapped() {
        let currPageValue = try! currentPage.value()
        
        if (currPageValue == onboardingScreens.count - 1) {
            viewModel.save()
            let storyboard = UIStoryboard(name: "App", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as! UITabBarController
            vc.modalPresentationStyle = .overCurrentContext
            present(vc, animated: true, completion: nil)
            return
        }
        
        currentPage.onNext(currPageValue + 1)
        let indexPath = IndexPath(item: currPageValue + 1, section: 0)
        collectionView.isPagingEnabled = false
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        collectionView.isPagingEnabled = true
        
        if (currPageValue == onboardingScreens.count - 2) {
            nextButton.setTitle("Начать", for: .normal)
        }
    }
    
    private func setInformationLabelText(currentPage: Int) {
        switch currentPage {
        case 0:
            informationLabel.text = "Расскажите нам о своих детях, чтобы мы могли предложить рекомендуемый режим сна для них"
        case 1:
            informationLabel.text = "Для ребенка возрастом от 1 года, мы рекомендуем такой распорядок дня, но вы можете отредактировать его:"
        case 2:
            informationLabel.text = "Мы поможем вам укладывать ребенка спать с помощью подборки успокаивающих звуков, советов и подсказок"
        default:
            informationLabel.text = "Zzzzz..."
        }
    }
    
    private func bindMainChildInfo() {
        mainChildInfoView.birthdayTextField.rx.text.orEmpty.bind(to: viewModel.birthday)
            .disposed(by: disposeBag)
        mainChildInfoView.nameTextField.rx.text.orEmpty.bind(to: viewModel.name)
            .disposed(by: disposeBag)
        mainChildInfoView.genderSegmentControl.rx.selectedSegmentIndex.bind(to: viewModel.gender)
            .disposed(by: disposeBag)
        let nameIsEmpty = mainChildInfoView.nameTextField.rx.text.orEmpty.map { !$0.isEmpty }
        let birthdayIsEmpty = mainChildInfoView.birthdayTextField.rx.text.orEmpty.map { !$0.isEmpty }
        
        Observable.combineLatest(nameIsEmpty, birthdayIsEmpty) {
            return $0 && $1
        }
        .bind(to: nextButton.rx.isEnabled)
        .disposed(by: disposeBag)
    }
    
    private func bindScheduleInfoView() {
        scheduleInfoView.breakfast.rx.text.orEmpty.bind(to: viewModel.breakfast)
            .disposed(by: disposeBag)
        scheduleInfoView.brunch.rx.text.orEmpty.bind(to: viewModel.brunch)
            .disposed(by: disposeBag)
        scheduleInfoView.dinner.rx.text.orEmpty.bind(to: viewModel.dinner)
            .disposed(by: disposeBag)
        scheduleInfoView.eveningMeal.rx.text.orEmpty.bind(to: viewModel.eveningMeal)
            .disposed(by: disposeBag)
        scheduleInfoView.firstDaySleep.rx.text.orEmpty.bind(to: viewModel.firstDaySleep)
            .disposed(by: disposeBag)
        scheduleInfoView.nightSleep.rx.text.orEmpty.bind(to: viewModel.nightSleep)
            .disposed(by: disposeBag)
        scheduleInfoView.nightMeal.rx.text.orEmpty.bind(to: viewModel.nightMeal)
            .disposed(by: disposeBag)
        scheduleInfoView.secondBrunch.rx.text.orEmpty.bind(to: viewModel.secondBrunch)
            .disposed(by: disposeBag)
        scheduleInfoView.secondDaySleep.rx.text.orEmpty.bind(to: viewModel.secondDaySleep)
            .disposed(by: disposeBag)
    }
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        onboardingScreens.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        onboardingScreens[indexPath.item]
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage.onNext(Int(scrollView.contentOffset.x / width))
    }
}
