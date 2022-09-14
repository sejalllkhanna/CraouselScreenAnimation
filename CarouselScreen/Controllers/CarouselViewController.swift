//
//  ViewController.swift
//  CarouselScreen
//
//  Created by Apple on 23/11/21.
//

import UIKit
import Foundation

class CarouselViewController: UIViewController,UICollectionViewDelegate,UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate, hamBurgerButtonProtocol {
    
    @IBOutlet weak var AddCardsLabel: UILabel!
    @IBOutlet weak var AddButton: UIButton!
    @IBOutlet weak var CardsTitleLabel: UILabel!
    @IBOutlet weak var BackButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak private var flowLayout: SnappingCollectionViewLayout!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loaderView: UIView!
    
    //MARK:- Variable Declaration
    private var cardList:[String]=["1","2","3","4","5","6"]
    private var currentPage:Int = 0
    private var cardBuffer = 0
    
    var button: HamburgerButton! = nil
    var evenDataArray: [EvenUserData] = [
        EvenUserData(amountLabel: "Rs. 6000", dayLabel: "Today", userNameLabel: "Sejal Khanna"),
        EvenUserData(amountLabel: "Rs. 4022", dayLabel: "1 Week", userNameLabel: "Ayesha Mehra"),
        EvenUserData(amountLabel: "Rs. 4140", dayLabel: "Yesterday", userNameLabel: "Kabir"),
        EvenUserData(amountLabel: "Rs. 9400", dayLabel: "Last Week", userNameLabel: "Shivang"),
    ]
    var oddDataArray: [OddUserData] = [
        OddUserData(amountLabel: "Rs. 4000", dayLabel: "Today", userNameLabel: "Rishabh"),
        OddUserData(amountLabel: "Rs. 4730", dayLabel: "1 Week Ago", userNameLabel: "Ayush"),
        OddUserData(amountLabel: "Rs. 4500", dayLabel: "Yesterday", userNameLabel: "Kartik"),
        OddUserData(amountLabel: "Rs. 4855", dayLabel: "Last Week", userNameLabel: "Riya"),
    ]
    
    // MARK:- UIViewController Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        getDetails()
        tableView.dataSource = self
        tableView.delegate = self
        
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "TableViewCell")
        
        BackButton.setTitle("", for: .normal)
        AddButton.setTitle("", for: .normal)
        
        flowLayout.itemSize = CGSize(width: view.frame.width-40, height:250)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        
        cardBuffer = cardList.count*2
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        collectionView.scrollToItem(at: IndexPath(item: cardBuffer/2, section: 0), at: .centeredHorizontally, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        flowLayout.invalidateLayout()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle  {
        return .lightContent
    }
    
    //    MARK:- TableView Functions for displaying transactions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if currentPage % 2 == 0{
            return evenDataArray.count
        }else{
            return oddDataArray.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let TableViewCell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        if currentPage % 2 == 0{
            TableViewCell.SetData(amountLabel: evenDataArray[indexPath.row].amountLabel!,
                                  userNameLabel: evenDataArray[indexPath.row].userNameLabel!, dayLabel: evenDataArray[indexPath.row].dayLabel!)
            
        }else{
            TableViewCell.SetData(amountLabel: oddDataArray[indexPath.row].amountLabel!,
                                  userNameLabel: oddDataArray[indexPath.row].userNameLabel!,
                                  dayLabel: oddDataArray[indexPath.row].dayLabel!)
        }
        
        return TableViewCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection
                   section: Int) -> String? {
        if section == 0{
            return "    Transactions"
        }else {
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {
            return
        }
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        header.textLabel?.textColor = .black
        header.textLabel?.frame = header.bounds
    }
    
    
    //    MARK:- Infinte Scrolling using Buffer Approach
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        guard let visibleIndexPath = collectionView.indexPathForItem(at: visiblePoint) else { return }
        if visibleIndexPath.row >= (cardList.count + cardBuffer/2) {
            let pos = ((visibleIndexPath.row - (cardList.count + cardBuffer/2)) % cardList.count) + cardBuffer/2
            self.collectionView.scrollToItem(at: IndexPath(item: pos, section: 0), at: .centeredHorizontally, animated: false)
        } else if (visibleIndexPath.row < cardBuffer/2) {
            let pos = ((visibleIndexPath.row + (cardList.count - cardBuffer/2)) % cardList.count) + cardBuffer/2
            self.collectionView.scrollToItem(at: IndexPath(item: pos, section: 0), at: .centeredHorizontally, animated: false)
        } else{
            
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let pageF = (scrollView.contentOffset.x / scrollView.frame.size.width)
        currentPage = Int(ceil(pageF))%6
       
        if scrollView == collectionView {
            let value = ((scrollView.contentOffset.x + CGFloat(currentPage - 10)) / 384.0).truncatingRemainder(dividingBy: 1)
            
            
            print(1-value.truncatingRemainder(dividingBy: 1))

            if scrollView.panGestureRecognizer.translation(in: scrollView.superview).x > 0 {
                if value <= 0.1{
                    tableView.alpha = 1
                }else{
                    tableView.alpha = value
                }
            } else {
                if 1-value <= 0.1{
                    tableView.alpha = 1
                }else{
                    tableView.alpha = 1-value
                }
            }
           
            showAnimatingDotsInImageView()
            
        }
        tableView.reloadData()
        
    }
    
    func isShowMenuTrue(showMenu: Bool) {
        collectionView.isScrollEnabled = !showMenu
    }
    
    // MARK:- Loader Animation
    func showAnimatingDotsInImageView() {
        let lay = CAReplicatorLayer()
        lay.frame = CGRect(x: 200, y: 200, width: 200, height: 200) //yPos == 12
        let circle = CALayer()
        circle.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        circle.cornerRadius = circle.frame.width / 2
        circle.backgroundColor = UIColor(red: 34/255.0, green: 37/255.0, blue: 73/255.0, alpha: 1).cgColor
        lay.addSublayer(circle)
        lay.instanceCount = 3
        lay.instanceTransform = CATransform3DMakeTranslation(10, 0, 0)
        let anim = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        anim.fromValue = 1.0
        anim.toValue = 0.2
        anim.duration = 1
        anim.repeatCount = .infinity
        circle.add(anim, forKey: nil)
        lay.instanceDelay = anim.duration / Double(lay.instanceCount)
        loaderView.layer.addSublayer(lay)
    }
}

//    MARK:- FORMATION OF COLLECTION VIEW CELLS - CARDS

extension CarouselViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardList.count + cardBuffer
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CardsCollectionCell
        cell.layer.cornerRadius = 10
        cell.indexLabel.text = "\(cardList[indexPath.row % cardList.count])"
        cell.delegate = self
        return cell
    }
}

protocol hamBurgerButtonProtocol{
    func isShowMenuTrue(showMenu:Bool)
}

