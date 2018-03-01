//
//  TutorialViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

class TutorialViewController: UIPageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 1, green: 214/255, blue: 158/255, alpha: 1)
        dataSource = self
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = .white
        appearance.currentPageIndicatorTintColor = UIColor(red: 232/255, green: 162/255, blue: 53/255, alpha: 1)
        appearance.backgroundColor = UIColor(red: 1, green: 214/255, blue: 158/255, alpha: 1)
        
        if let firstViewController = orderedViewControllers.first{
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

private(set) var orderedViewControllers: [UIViewController] = {
    let storyboard = UIStoryboard(name: "Tutorial", bundle: nil)
    return [storyboard.instantiateViewController(withIdentifier: "Tutorial1"), storyboard.instantiateViewController(withIdentifier: "Tutorial2"), storyboard.instantiateViewController(withIdentifier: "Tutorial3")]
}()

extension TutorialViewController: UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = orderedViewControllers.index(of: viewController) else { return nil }
        let previousIndex = index - 1
        guard previousIndex >= 0 else { return nil }
        guard orderedViewControllers.count > previousIndex else { return nil }
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = orderedViewControllers.index(of: viewController) else { return nil }
        let nextIndex = index + 1
        let orderedViewControllersCount = orderedViewControllers.count
        guard orderedViewControllersCount != nextIndex else { return nil }
        guard orderedViewControllersCount > nextIndex else { return nil }
        return orderedViewControllers[nextIndex]
    }
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return 3
    }
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    
}
