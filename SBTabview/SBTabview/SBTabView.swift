/*
 * SBTabView.swift
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

protocol SBTabViewDatasource : NSObjectProtocol {
    
    // Get the number of tabs in the tab view
    func numberOfTabs(in tabView: SBTabView) -> Int
    
    // To know whether the left tab button be shown
    func shouldShowLeftTab(in tabView: SBTabView) -> Bool
    
    // To know whether the middle tab button be shown
    func shouldShowMiddleTab(in tabView: SBTabView) -> Bool
    
    // To know whether the right tab button be shown
    func shouldShowRightTab(in tabView: SBTabView) -> Bool
    
    // Get the title for the left tab button
    func titleForLeftTab(in tabView: SBTabView) -> String!
    
    // Get the title for the middle tab button
    func titleForMiddleTab(in tabView: SBTabView) -> String!
    
    // Get the title for the right tab button
    func titleForRightTab(in tabView: SBTabView) -> String!
    
    // To know whether the page indicator be shown
    func shouldShowPageIndicator(in tabView: SBTabView) -> Bool
    
    // To select the page indicator
    func selectedPageIndicator(in tabView: SBTabView) -> Int
    
}

// Tab View Delegate Methods
protocol  SBTabViewDelegate : NSObjectProtocol {
    
    // Called after the left action button is tapped on the tab view
    func tabView(_ tabView:SBTabView, didTapLeftAction leftBtn:UIButton )
    
    // Called after the right action btn is tapped on the tab view
    func tabView(_ tabView:SBTabView, didTapOnRightAction rightBtn:UIButton)
    
    // Called when the left tab button is tapped
    func didTapOnLeftBtn(_ btn:UIButton, in tabView:SBTabView)
    
    // Called when the right tab button is tapped
    func didTapOnRightBtn(_ btn:UIButton, in tabView:SBTabView)
}

// Tab Options
enum TabOption: Int {
    case first, second, third
}

// File Owner class
class SBTabView: SBXibBaseView {
    
    // MARK: - Properties
    
    // Outlet for the right action Button
    @IBOutlet private weak var rightActionBtn : UIButton!
    
    // Outlet for the left action Button
    @IBOutlet private weak var leftActionBtn : UIButton!
    
    // Outlet for the middle tab Button
    @IBOutlet private weak var middleTabBtn : UIButton!
    
    // Outlet for the left tab Button
    @IBOutlet private weak var leftTabBtn : UIButton!
    
    // Outlet for the right tab Button
    @IBOutlet private weak var rightTabBtn : UIButton!
    
    // Outlet for the first Indicator label
    @IBOutlet private weak var firstIndicationLbl : UILabel!
    
    // Outlet for the second Indicator label
    @IBOutlet private weak var secondIndicationLbl : UILabel!
    
    // Outlet for the third Indicator label
    @IBOutlet private weak var thirdIndicationLbl : UILabel!
    
    // Outlet for the indicator container
    @IBOutlet private weak var indicatorContainerView: UIView!
    
    // Delegate for header view
    weak  var delegate: SBTabViewDelegate?
    
    // Datasource for header view
    weak var datasource: SBTabViewDatasource?
    
    // tabs count
    private var tabsCount: Int?
    
    // MARK: - Class Methods
    
    /*
     @methodName     : awakeFromNib
     @description    : life cycle method
     */
    override func awakeFromNib() {
        
        super.awakeFromNib()
        self.indicatorContainerView.isHidden = true
        self.firstIndicationLbl.isHidden = true
        self.secondIndicationLbl.isHidden = true
        self.thirdIndicationLbl.isHidden = true
        
        self.unselectPage(self.firstIndicationLbl)
        self.unselectPage(self.secondIndicationLbl)
        self.unselectPage(self.thirdIndicationLbl)
    }
    
    /*
     @methodName     : configure
     params          : lImage - Left Image, rImage - Right Image
     @description    : sets the left and right image to respective action buttons
     */
    func configure(leftImage lImage:UIImage, andRightImage rImage:UIImage) {
        
        self.leftActionBtn.setImage(lImage, for: .normal)
        self.rightActionBtn.setImage(rImage, for: .normal)
    }
    
    /*
     @methodName     : reloadTabs
     @description    : load the tab data from the datasource methods
     */
    func reloadTabs() {
        
        if let shouldShowLeftTab = self.datasource?.shouldShowLeftTab(in: self) {
            leftTabBtn.isHidden = !shouldShowLeftTab
            
            if (shouldShowLeftTab) {
                let title = self.datasource?.titleForLeftTab(in: self)
                leftTabBtn.setTitle(title, for: .normal)
            }
        }
        
        if let shouldShowMiddleTab = self.datasource?.shouldShowMiddleTab(in: self) {
            middleTabBtn.isHidden = !shouldShowMiddleTab
            
            if (shouldShowMiddleTab) {
                let title = self.datasource?.titleForMiddleTab(in: self)
                middleTabBtn.setTitle(title, for: .normal)
            }
        }
        
        if let shouldShowRightTab = self.datasource?.shouldShowRightTab(in: self) {
            rightTabBtn.isHidden = !shouldShowRightTab
            
            if (shouldShowRightTab) {
                let title = self.datasource?.titleForRightTab(in: self)
                rightTabBtn.setTitle(title, for: .normal)
            }
        }
        
        if let tabCount = self.datasource?.numberOfTabs(in: self) {
            tabsCount = tabCount
            
            if tabCount > 1 {
                self.indicatorContainerView.isHidden = false
                self.firstIndicationLbl.isHidden = false
                self.secondIndicationLbl.isHidden = false
                self.thirdIndicationLbl.isHidden = false
            }
            
            // If the number of tabs are 2, then remove the third indicator
            if tabCount == 2 {
                self.thirdIndicationLbl.removeFromSuperview()
            }
        }
        
        if let showPage = self.datasource?.shouldShowPageIndicator(in: self) {
            if (showPage) {
                if let pageIndex = self.datasource?.selectedPageIndicator(in: self) {
                    
                    switch pageIndex {
                    case 0:
                        self.selectPage(self.firstIndicationLbl)
                    case 1:
                        self.selectPage(self.secondIndicationLbl)
                    case 2:
                        self.selectPage(self.thirdIndicationLbl)
                    default: break
                    }
                }
            }
        }
    }
    
    
    /*
     @methodName     : init
     @description    : view life cycle method
     param           : frame - frame of type CGRect
     */
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    /*
     @methodName     : init
     @description    : view life cycle method
     param           : aDecoder - decoder of type NSCoder
     */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /*
     @methodName     : prepareForInterfaceBuilder
     @description    : view life cycle method
     */
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
    /*
     @methodName     : selectPage
     @description    : method to make the page indicator labels as selected
     param           : lbl - Indicator label to be marked as selected
     */
    private func selectPage(_ lbl:UILabel) {
        lbl.backgroundColor = UIColor.white
    }
    
    /*
     @methodName     : unselectPage
     @description    : method to make the page indicator labels as unselected
     param           : lbl - Indicator label to be marked as unselected
     */
    private func unselectPage(_ lbl:UILabel) {
        lbl.backgroundColor = UIColor.init(red: 128.0/255.0, green: 128.0/255.0, blue: 128.0/255.0, alpha: 1.0)
    }
    
    /*
     @methodName     : selectPage
     @description    : select the page indicator
     param           : pageIndex - Page Index
     */
    func selectPage(_ pageIndex:Int) {
        
        self.unselectPage(self.firstIndicationLbl)
        self.unselectPage(self.secondIndicationLbl)
        self.unselectPage(self.thirdIndicationLbl)
        
        switch pageIndex {
        case 1:
            self.selectPage(self.firstIndicationLbl)
        case 2:
            self.selectPage(self.secondIndicationLbl)
        default:
            self.selectPage(self.thirdIndicationLbl)
        }
    }
    
    // MARK: - IBAction Methods
    
    // Action method for the button 'leftTabBtn'
    @IBAction func onTapOfLeftTabBtn(_ sender: Any) {
        self.delegate?.didTapOnLeftBtn(self.leftTabBtn, in: self)
    }
    
    // Action method for the button 'rightTabBtn'
    @IBAction func onTapOfRightTabBtn(_ sender: Any) {
        self.delegate?.didTapOnRightBtn(self.rightTabBtn, in: self)
    }
    
    // Action method for the button 'profileBtn'
    @IBAction func onTapOfLeftActionButton(_ sender: Any) {
        self.delegate?.tabView(self, didTapLeftAction: sender as! UIButton)
    }
    
    // Action method for the button 'notificationBtn'
    @IBAction func onTapOfRightActionButton(_ sender: Any) {
        self.delegate?.tabView(self, didTapOnRightAction: sender as! UIButton)
    }
    
}
