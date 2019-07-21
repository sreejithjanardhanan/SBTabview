/*
 * SBFeature.swift
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

class SBFeature: NSObject {
    
    //MARK: - PROPERTIES
    
    // Feature ID
    var featureID: String!
    
    // Feature Name
    var featureName: String!
    
    // Feature Home Controller or Base Controller
    var featureController: String!
    
    // Stroyboard where the Feature Home Controller exist
    var featureStoryboard: String!
    
    // Storyboard VC Identifier
    var featureStoryboardIdentifier: String!
    
    // Use Cases required to activate the use case
    var featureRequiredUseCaseToActivate: NSNumber!
    
    // Boolean value to tell whether the feature is active
    var isFeatureActive: Bool!
    
    //MARK: - METHODS
    
    /*
     @methodName     : init
     @description    : init method for the feature
     param           : featureInfo - dictionary of feature meta data information
     */
    init(featureInfo: [String:Any]) {
        
        if let fID = featureInfo["featureID"] as? String {
            self.featureID = fID
        }
        
        if let fName = featureInfo["featureName"] as? String {
            self.featureName = fName
        }
        
        if let fVC = featureInfo["featureControllerName"] as? String {
            self.featureController = fVC
        }
        
        if let fStory = featureInfo["featureStoryboardSource"] as? String {
            self.featureStoryboard = fStory
        }
        
        if let fStoryId = featureInfo["featureControllerIdentifier"] as? String {
            self.featureStoryboardIdentifier = fStoryId
        }
        
        if let fUseCaList = featureInfo["featureRequiredUseCases"] as? NSNumber {
            self.featureRequiredUseCaseToActivate = fUseCaList
        }
        
        self.isFeatureActive = false
        
        super.init()
    }
    
    
    /*
     @methodName     : setActive
     @description    : method to activate or deactivate the feature
     param           : act - Boolean parameter to activate or deactivate
     */
    func setActive(_ act:Bool) {
        self.isFeatureActive = act
    }
    
    
    /*
     @methodName     : isActive
     @description    : method to return the status of the feature
     return          : type - Boolean
     */
    func isActive() -> Bool {
        return self.isFeatureActive
    }
    
}
