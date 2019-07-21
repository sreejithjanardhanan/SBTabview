/*
 * SBFirstFeatureHomeViewController.swift
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

class SBFirstFeatureHomeViewController: SBFeatureController {
    
    @IBOutlet weak var firstFeatureHeaderView: SBTabView!
    
    @IBOutlet weak var firstFeatureListView: UITableView!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        firstFeatureListView.estimatedRowHeight =  firstFeatureListView.rowHeight
        firstFeatureListView.rowHeight = UITableView.automaticDimension
        
        self.firstFeatureHeaderView.delegate = self.tabDelegate
        self.firstFeatureHeaderView.datasource = self
        self.firstFeatureHeaderView.reloadTabs()
    }
    
    override func hideListHeader() {
        self.firstFeatureListView?.tableHeaderView?.isHidden = true
    }
    
    override func showListHeader() {
        self.firstFeatureListView?.tableHeaderView?.isHidden = false
    }
}

extension SBFirstFeatureHomeViewController: SBTabViewDatasource {
    
    func selectedPageIndicator(in tabView: SBTabView) -> Int {
        
        let activeFeatures = SBFeatureManager.sharedManager.getActiveFeatures()
        
        var indexOfOurWorldFeature : Int = -1
        for (i, feature) in activeFeatures.enumerated() {
            if (feature.featureID == "id_firstfeature") {
                indexOfOurWorldFeature = i
                break
            }
        }
        return indexOfOurWorldFeature
    }
    
    
    func numberOfTabs(in tabView: SBTabView) -> Int {
        
        let activeFeat = SBFeatureManager.sharedManager.getActiveFeatures()
        return activeFeat.count
    }
    
    func shouldShowLeftTab(in tabView: SBTabView) -> Bool {
        return false
    }
    
    func shouldShowMiddleTab(in tabView: SBTabView) -> Bool {
        return true
    }
    
    func shouldShowRightTab(in tabView: SBTabView) -> Bool {
        
        let activeFeatures = SBFeatureManager.sharedManager.getActiveFeatures()
        
        var indexOfOurWorldFeature : Int = -1
        for (i, feature) in activeFeatures.enumerated() {
            if (feature.featureID == "id_firstfeature") {
                indexOfOurWorldFeature = i
                break
            }
        }
        
        if (activeFeatures.indices.contains(indexOfOurWorldFeature + 1)) {
            return true
        }
        return false
    }
    
    func titleForLeftTab(in tabView: SBTabView) -> String! {
        return STRING.Text.kEmpty
    }
    
    func titleForMiddleTab(in tabView: SBTabView) -> String! {
        return STRING.Text.kFirstFeature
    }
    
    func titleForRightTab(in tabView: SBTabView) -> String! {
        let activeFeatures = SBFeatureManager.sharedManager.getActiveFeatures()
        
        var indexOfOurWorldFeature : Int = -1
        for (i, feature) in activeFeatures.enumerated() {
            if (feature.featureID == "id_firstfeature") {
                indexOfOurWorldFeature = i
                break
            }
        }
        
        if (activeFeatures.indices.contains(indexOfOurWorldFeature + 1)) {
            let leftFeature = activeFeatures[(indexOfOurWorldFeature + 1)]
            return leftFeature.featureName
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
