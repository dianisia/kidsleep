import UIKit
import Foundation
import RxSwift
import RxCocoa

class OnboardingViewController: UIViewController {
    typealias ViewModelType = OnboardingViewModel
    var viewModel: OnboardingViewModel! = OnboardingViewModel(serviceProvider: DIContainer.serviceProvider)
    var songsViewModel = SongsViewModel()
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageController: CustomPageControl!
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var nextButton: CustomButton!
    
    private var disposeBag = DisposeBag()
    private var currentPage = BehaviorSubject<Int>(value: 0)
    private var onboardingScreens: [UICollectionViewCell] = []

    private var mainChildInfoView = MainChildInfoView()
    private var scheduleInfoView = ScheduleInfoView()
    private var songsInfoView = SongsInfoView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainChildInfoScreen()
        setupScheduleInfoScreen()
        setupSongsScreen()
        collectionView.reloadData()
        bindUI()
    }
    
    private func setupMainChildInfoScreen() {
        collectionView.register(UINib(nibName: "MainChildInfoView", bundle: nil), forCellWithReuseIdentifier: MainChildInfoView.cellId)
        mainChildInfoView = collectionView.dequeueReusableCell(withReuseIdentifier: MainChildInfoView.cellId, for: IndexPath(item: 0, section: 0)) as! MainChildInfoView
        onboardingScreens.append(mainChildInfoView)
        
        mainChildInfoView.birthdayTextField.rx.text.orEmpty.bind(to: viewModel.birthday)
            .disposed(by: disposeBag)
        mainChildInfoView.nameTextField.rx.text.orEmpty.bind(to: viewModel.name)
            .disposed(by: disposeBag)
        mainChildInfoView.genderSegmentControl.rx.selectedSegmentIndex.bind(to: viewModel.gender)
            .disposed(by: disposeBag)
    }
    
    private func setupScheduleInfoScreen() {
        collectionView.register(UINib(nibName: "ScheduleInfoView", bundle: nil), forCellWithReuseIdentifier: ScheduleInfoView.cellId)
        scheduleInfoView = collectionView.dequeueReusableCell(withReuseIdentifier: ScheduleInfoView.cellId, for: IndexPath(item: 1, section: 0)) as! ScheduleInfoView
        scheduleInfoView.instantiate()
        onboardingScreens.append(scheduleInfoView)
        
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
    
    private func setupSongsScreen() {
        collectionView.register(SongsInfoView.self, forCellWithReuseIdentifier: SongsInfoView.cellId)
        songsInfoView = collectionView.dequeueReusableCell(withReuseIdentifier: SongsInfoView.cellId, for: IndexPath(item: 2, section: 0)) as! SongsInfoView
        songsInfoView.configure(with: songsViewModel.transform().songs)
        onboardingScreens.append(songsInfoView)
    }
    
    private func bindUI() {
        viewModel.currentPage.bind(onNext: {[unowned self] page in
            pageController.currentPage = page
        })
        .disposed(by: disposeBag)
        
        viewModel.pageTitle.bind(to: informationLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.buttonTitle.bind(to: nextButton.rx.title())
            .disposed(by: disposeBag)
        
        viewModel.isNextButtonEnabled.bind(to: nextButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        nextButton.rx.tap.bind { [unowned self] in
            self.onNextButtonTapped()
        }
        .disposed(by: disposeBag)
    }
    
    private func onNextButtonTapped() {
        if (pageController.currentPage == onboardingScreens.count - 1) {
            viewModel.finishOnboarding()
            openMain()
            return
        }
        let screenNumber = pageController.currentPage + 1
        showNextScreen(screenNumber: screenNumber)
    }
    
    private func openMain() {
        let storyboard = UIStoryboard(name: "App", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as! UITabBarController
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }
    
    private func showNextScreen(screenNumber: Int) {
        let indexPath = IndexPath(item: screenNumber, section: 0)
        collectionView.isPagingEnabled = false
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        collectionView.isPagingEnabled = true
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        let newPage = Int(scrollView.contentOffset.x / width)
        viewModel.currentPage.accept(newPage)
    }
}
