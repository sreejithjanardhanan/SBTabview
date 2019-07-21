/*
 * SBHomeViewController.swift
 * SBTabview
 *
 * Created by Sreejith Bhatt on 11/06/19.
 * Copyright © 2019 SB Studios. All rights reserved.
 * http://www.sreejithbhatt.com/
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 */

import UIKit

class SBHomeViewController: UIViewController {
    
    // MARK: - Properties
    
    // Outlet for the Header Tabs View
    @IBOutlet weak var homeTabView: SBTabView!
    
    // Content View Controller list for the page view controller 'homePageTabOptions'
    private var contentControllerList = [UIViewController]()
    
    // Feature currently displayed to the user
    private var displayedFeature : SBFeature?
    
    // tab Data dictionary for the home tab view
    private var tabData = [String:Any]()
    
    // Getter method for the UIPageViewController
    private lazy var homePageTabOptions : UIPageViewController = {
        
        let pageController = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "pageViewControl") as! UIPageViewController
        pageController.dataSource = self
        pageController.delegate = self
        return pageController
    }()
    
    // MARK: - Class Methods
    
    /*
     @methodName     : viewDidLoad
     @description    : view life cycle method
     */
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        buildUserFeatures()
        
        self.homeTabView.datasource = self
        self.homeTabView.reloadTabs()
        
        addTabOptions()
    }
    
    /*
     @methodName     : buildUserFeatures
     @description    : create and add the feature controller. Also adds the tabdata dictionary with feature information
     */
    fileprivate func buildUserFeatures() {
        
        let activeFeat = SBFeatureManager.sharedManager.getActiveFeatures()
        for feature in activeFeat {
            
            let viewController = UIStoryboard(name: feature.featureStoryboard, bundle: nil).instantiateViewController(withIdentifier: feature.featureStoryboardIdentifier)
            if let vc = viewController as? SBFeatureController {
                vc.tabDelegate = self
            }
            self.contentControllerList.append(viewController)
        }
        
        if activeFeat.count == 1 {
            tabData["middle"] = activeFeat[0]
        } else if (activeFeat.count == 2) {
            tabData["middle"] = activeFeat[0]
            tabData["right"] = activeFeat[1]
        } else if (activeFeat.count == 3) {
            tabData["left"] = activeFeat[0]
            tabData["middle"] = activeFeat[1]
            tabData["right"] = activeFeat[2]
        }
    }
    
    
    /*
     @methodName     : getFirstControllerIndex
     @description    : to give the controller index based on the feature count
     return          : integer
     */
    func getFirstControllerIndex() -> Int {
        
        var index = 1
        let featuresList = SBFeatureManager.sharedManager.getActiveFeatures()
        if featuresList.count == 1 || (featuresList.count == 2) {
            index = 0
        }
        
        self.displayedFeature = featuresList[index]
        
        return index
    }
    
    /*
     @methodName     : addTabOptions
     @description    : this method sets the Rides tab as the visible controller to the page view controller
     */
    private func addTabOptions() {
        
        let firstFeatureIndex = self.getFirstControllerIndex()
        let firstFeatureVC = self.contentControllerList[firstFeatureIndex]
        
        self.homePageTabOptions.setViewControllers([firstFeatureVC], direction: .forward, animated: true, completion: nil)
        
        self.addChild(self.homePageTabOptions)
        homePageTabOptions.view.frame = self.view.frame
        self.view.addSubview(homePageTabOptions.view)
        
        if let tempVC = firstFeatureVC as? SBFeatureController {
            tempVC.showListHeader()
        }
        
        self.homeTabView.isHidden = true
        self.view.sendSubviewToBack(self.homeTabView)
        
        if self.displayedFeature?.featureID == "id_firstfeature" {
            self.homeTabView.configure(leftImage: UIImage.init(named: "Profile - Btn Icon")!, andRightImage: UIImage.init(named: "Common - Notifications Icon")!)
        } else if (self.displayedFeature?.featureID == "id_secondfeature") {
            self.homeTabView.configure(leftImage: UIImage.init(named: "Profile - Btn Icon")!, andRightImage: UIImage.init(named: "Common - Notifications Icon")!)
        } else if (self.displayedFeature?.featureID == "id_thirdfeature") {
            self.homeTabView.configure(leftImage: UIImage.init(named: "Profile - Btn Icon")!, andRightImage: UIImage.init(named: "Common - Notifications Icon")!)
        }
    }
    
}

// MARK: - RETabViewDelegate Methods

extension SBHomeViewController: SBTabViewDatasource {
    
    func selectedPageIndicator(in tabView: SBTabView) -> Int {
        return -1
    }
    
    
    func numberOfTabs(in tabView: SBTabView) -> Int {
        
        //return self.tabData.keys.count
        let activeFeatures = SBFeatureManager.sharedManager.getActiveFeatures()
        return activeFeatures.count
    }
    
    func shouldShowLeftTab(in tabView: SBTabView) -> Bool {
        if (self.tabData["left"] != nil) {
            return true
        }
        return false
    }
    
    func shouldShowMiddleTab(in tabView: SBTabView) -> Bool {
        if (self.tabData["middle"] != nil) {
            return true
        }
        return false
    }
    
    func shouldShowRightTab(in tabView: SBTabView) -> Bool {
        if (self.tabData["right"] != nil) {
            return true
        }
        return false
    }
    
    func titleForLeftTab(in tabView: SBTabView) -> String! {
        if let feature = self.tabData["left"] as? SBFeature {
            return feature.featureName
        }
        return STRING.Text.kEmpty
    }
    
    func titleForMiddleTab(in tabView: SBTabView) -> String! {
        if let feature = self.tabData["middle"] as? SBFeature {
            return feature.featureName
        }
        return STRING.Text.kEmpty
    }
    
    func titleForRightTab(in tabView: SBTabView) -> String! {
        if let feature = self.tabData["right"] as? SBFeature {
            return feature.featureName
        }
        return STRING.Text.kEmpty
    }
    
    func shouldShowPageIndicator(in tabView: SBTabView) -> Bool {
        
        let activeFeatures = SBFeatureManager.sharedManager.getActiveFeatures()
        if activeFeatures.count > 1 {
            return true
        }
        return false
    }
    
}

extension SBHomeViewController: SBTabViewDelegate {
    
    // Called when the left tab button is tapped
    func didTapOnLeftBtn(_ btn:UIButton, in tabView:SBTabView) {
        
        let activeFeatures = SBFeatureManager.sharedManager.getActiveFeatures()
        
        if self.displayedFeature != nil {
            
            if let indexOfCurrentFeature = activeFeatures.firstIndex(of: self.displayedFeature!) {
                
                if (activeFeatures.indices.contains(indexOfCurrentFeature - 1)) {
                    
                    if let newFeatureController = self.contentControllerList[(indexOfCurrentFeature - 1)] as? SBFeatureController {
                        self.homePageTabOptions.setViewControllers([newFeatureController], direction: UIPageViewController.NavigationDirection.reverse , animated: false, completion: nil)
                        newFeatureController.showListHeader()
                        
                        self.displayedFeature = activeFeatures[(indexOfCurrentFeature - 1)]
                        
                        self.homeTabView.isHidden = true
                        self.view.sendSubviewToBack(self.homeTabView)
                    }
                }
            }
        }
    }
    
    // Called when the right tab button is tapped
    func didTapOnRightBtn(_ btn:UIButton, in tabView:SBTabView) {
        
        let activeFeatures = SBFeatureManager.sharedManager.getActiveFeatures()
        
        if self.displayedFeature != nil {
            
            if let indexOfCurrentFeature = activeFeatures.firstIndex(of: self.displayedFeature!) {
                
                if (activeFeatures.indices.contains(indexOfCurrentFeature + 1)) {
                    
                    if let newFeatureController = self.contentControllerList[(indexOfCurrentFeature + 1)] as? SBFeatureController {
                        self.homePageTabOptions.setViewControllers([newFeatureController], direction: UIPageViewController.NavigationDirection.forward , animated: false, completion: nil)
                        newFeatureController.showListHeader()
                        
                        self.displayedFeature = activeFeatures[(indexOfCurrentFeature + 1)]
                        
                        self.homeTabView.isHidden = true
                        self.view.sendSubviewToBack(self.homeTabView)
                    }
                }
            }
        }
    }
    
    // Called after the left action button is tapped on the tab view
    func tabView(_ tabView:SBTabView, didTapLeftAction leftBtn:UIButton) {
        
    }
    
    // Called after the right action btn is tapped on the tab view
    func tabView(_ tabView:SBTabView, didTapOnRightAction rightBtn:UIButton) {
        
    }
    
}

// MARK: - UIPageViewControllerDelegate Methods

extension SBHomeViewController: UIPageViewControllerDelegate {
    
    public func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        
        for controller in self.contentControllerList {
            let typeVC = controller as? SBFeatureController
            typeVC?.hideListHeader()
        }
        
        self.homeTabView.isHidden = false
        self.view.bringSubviewToFront(self.homeTabView)
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        for controller in self.contentControllerList {
            let typeVC = controller as? SBFeatureController
            typeVC?.showListHeader()
        }
        
        let activeFeatures = SBFeatureManager.sharedManager.getActiveFeatures()
        
        if let destinationVC = pageViewController.viewControllers?.last {
            
            let destinationTxt = NSStringFromClass(destinationVC.classForCoder).components(separatedBy: ".").last!
            
            let destFeature = SBFeatureManager.sharedManager.getFeatureAndIndex(destinationTxt)
            
            let middleFeature = destFeature.0
            let destIndex = destFeature.1
            
            self.tabData.updateValue(middleFeature as Any, forKey: "middle")
            
            if (activeFeatures.indices.contains(destIndex + 1)) {
                let rightFeature = activeFeatures[(destIndex + 1)]
                self.tabData.updateValue(rightFeature, forKey: "right")
            } else {
                self.tabData["right"] = nil
            }
            
            if (activeFeatures.indices.contains(destIndex - 1)) {
                let leftFeature = activeFeatures[(destIndex - 1)]
                self.tabData.updateValue(leftFeature, forKey: "left")
            } else {
                self.tabData["left"] = nil
            }
            
            if middleFeature?.featureID == "id_ourworld" {
                self.homeTabView.configure(leftImage: UIImage.init(named: "Profile - Btn Icon")!, andRightImage: UIImage.init(named: "Common - Notifications Icon")!)
            } else if (middleFeature?.featureID == "id_rides") {
                self.homeTabView.configure(leftImage: UIImage.init(named: "Profile - Btn Icon")!, andRightImage: UIImage.init(named: "Common - Notifications Icon")!)
            } else if (middleFeature?.featureID == "id_servicing") {
                self.homeTabView.configure(leftImage: UIImage.init(named: "Profile - Btn Icon")!, andRightImage: UIImage.init(named: "Service - RSA Btn Icon")!)
            }
            
            self.displayedFeature = middleFeature
        }
        
        self.homeTabView.reloadTabs()
        
        self.homeTabView.isHidden = true
        self.view.sendSubviewToBack(self.homeTabView)
    }
}



// MARK: - UIPageViewControllerDataSource Methods

extension SBHomeViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = self.contentControllerList.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard contentControllerList.count > previousIndex else {
            return nil
        }
        
        return contentControllerList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = self.contentControllerList.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = contentControllerList.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return contentControllerList[nextIndex]
    }
    
}
