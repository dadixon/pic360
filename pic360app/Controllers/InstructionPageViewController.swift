//
//  InstructionPageViewController.swift
//  pic360app
//
//  Created by Domonique Dixon on 11/28/17.
//  Copyright © 2017 pic360. All rights reserved.
//

import UIKit

class InstructionPageViewController: UIPageViewController {

    lazy var orderedViewControllers: [UIViewController] = {
        return [self.newVC(viewController: "Walkthrough1ViewController"),
                self.newVC(viewController: "Walkthrough2ViewController")]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self

        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func newVC(viewController: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:viewController)
    }
}

extension InstructionPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
//            return orderedViewControllers.last
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        guard orderedViewControllers.count != nextIndex else {
//            return orderedViewControllers.first
            return nil
        }
        
        guard orderedViewControllers.count > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
}

extension InstructionPageViewController: UIPageViewControllerDelegate {
    
}
