# SBTabview

This is an implementation of a tabview component for iOS written in Swift 4.0.

# Requirements

* iOS 8.0+
* XCode 9.0+
* Swift 4.2

# Usage

1. Add SBTabview to view controller and set IBOutlet.
         
         @IBOutlet weak var firstFeatureHeaderView: SBTabView!

2. Set delegate and datasource for SBTabview

        self.ViewController.delegate = self
        
        self.ViewController.datasource = self
        
3. Call reload Tabs function
        
        self.ViewController.reloadTabs()

4. Implement SBTabViewDatasource methods

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

5. Implement SBTabViewDelegate methods

        // Called after the left action button is tapped on the tab view
        func tabView(_ tabView:SBTabView, didTapLeftAction leftBtn:UIButton )
    
        // Called after the right action btn is tapped on the tab view
        func tabView(_ tabView:SBTabView, didTapOnRightAction rightBtn:UIButton)
    
        // Called when the left tab button is tapped
        func didTapOnLeftBtn(_ btn:UIButton, in tabView:SBTabView)
    
        // Called when the right tab button is tapped
        func didTapOnRightBtn(_ btn:UIButton, in tabView:SBTabView)

