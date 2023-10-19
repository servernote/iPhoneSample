//
//  AdMobView.swift
//  AdMob
//  Created by ServerNote.NET on 2023/10/19.
//

import SwiftUI
import GoogleMobileAds

struct AdMobBannerView : UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        let view = GADBannerView(adSize: GADAdSizeBanner)
        let viewController = UIViewController()
        view.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        view.rootViewController = viewController
        view.load(GADRequest())
        viewController.view.addSubview(view)
        viewController.view.frame = CGRect(origin: .zero, size: GADAdSizeBanner.size)
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}

class AdMobScreenView: NSObject, ObservableObject, GADFullScreenContentDelegate {
    
    @Published var adLoaded:Bool = false
    var adObject:GADInterstitialAd?
    
    override init() {
        super.init()
    }
    
    func loadAdObject() {
        GADInterstitialAd.load(withAdUnitID: "ca-app-pub-3940256099942544/4411468910", request: GADRequest()) { (ad, error) in
            if let _ = error {
                print("AdMobScreenView.loadAdObject error=\(error!)")
                self.adLoaded = false
                return
            }
            print("AdMobScreenView.loadAdObject success")
            self.adLoaded = true
            self.adObject = ad
            self.adObject?.fullScreenContentDelegate = self
        }
    }
    
    func showAdObject() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let root = windowScene?.windows.first!.rootViewController
        if let ad = self.adObject {
            ad.present(fromRootViewController: root!)
            self.adLoaded = false
        } else {
            print("AdMobScreenView.showAdObject error")
            self.adLoaded = false
            self.loadAdObject()
        }
    }
    
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("AdMobScreenView.didFailToPresentFullScreenContentWithError")
        self.loadAdObject()
    }
    
    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("AdMobScreenView.adWillPresentFullScreenContent")
    }
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("AdMobScreenView.adDidDismissFullScreenContent")
    }
}

struct AdMobView: View {
    
    @ObservedObject var adScreen = AdMobScreenView()
    
    var body: some View {
        VStack() {
            AdMobBannerView().frame(width: 320, height: 50)
            Text("Tap to open full screen AD")
                .font(.largeTitle)
                .onAppear() {
                    adScreen.loadAdObject()
                }
                .onTapGesture {
                    adScreen.showAdObject()
                }
        }
    }
}

struct AdMobView_Previews: PreviewProvider {
    static var previews: some View {
        AdMobView()
    }
}
