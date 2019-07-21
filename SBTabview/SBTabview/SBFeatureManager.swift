/*
 * SBFeatureManager.swift
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

class SBFeatureManager: NSObject {
    
    //MARK: - PROPERTIES
    
    // Shared instance of the feature manager
    static let sharedManager = SBFeatureManager()
    
    // Overall app features list in the application
    private var featuresList = [SBFeature]()
    
    //MARK: - METHODS
    
    
    /*
     @methodName     : init
     @description    : init method for the feature
     */
    override init() {
        super.init()
    }
    
    
    /*
     @methodName     : registerFeature
     @description    : register the feature to the application from the meta data
     param           : key - plist meta data key for each feature
     */
    func registerFeature(_ key: String) -> Void {
        
        if let plistPath = Bundle.main.path(forResource: "FeatureMetaData", ofType: "plist") {
            let metaData = NSDictionary.init(contentsOfFile: plistPath)
            let feature = SBFeature.init(featureInfo: metaData?[key] as! [String : Any])
            self.featuresList.append(feature)
        }
    }
    
    /*
     @methodName     : resetRegisteredFeatures
     @description    : clear the features by making them inactive
     */
    func resetRegisteredFeatures() -> Void {
        for feature in self.featuresList {
            feature.setActive(false)
        }
    }
    
    /*
     @methodName     : getActiveFeatures
     @description    : get the list of active features
     return          : Array of type REFeature which are active
     */
    func getActiveFeatures() -> [SBFeature] {
        var activeFeaturesList = [SBFeature]()
        for feature in self.featuresList {
            if feature.isActive() {
                activeFeaturesList.append(feature)
            }
        }
        return activeFeaturesList
    }
    
    /*
     @methodName     : getFeatureAndIndex
     @description    : this method identifies the feature and its index in the active feature set
     param           : txt identifier for the search
     return          : tuple of (feature, index)
     */
    func getFeatureAndIndex(_ txt:String) -> (SBFeature?, Int) {
        
        var featureToReturn : SBFeature?
        var index : Int = -1
        
        let featuresList = self.getActiveFeatures()
        for (i, feat) in featuresList.enumerated() {
            if (feat.featureController == txt) {
                featureToReturn = feat
                index = i
                break
            }
        }
        return (featureToReturn, index)
    }
    
    /*
     @methodName     : activateFeaturesOnUseCases
     @description    : activate the features based on the input use cases
     param          : useCases - set of usecases to enable the features in the application
     */
    func activateFeaturesOnUseCases(_ useCases:Set<NSNumber>) -> Void {
        
        for feature in self.featuresList {
            if useCases.contains(feature.featureRequiredUseCaseToActivate) {
                feature.setActive(true)
            }
        }
    }
}
