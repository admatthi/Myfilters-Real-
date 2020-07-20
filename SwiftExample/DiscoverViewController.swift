//
//  DiscoverViewController.swift
//  SwiftExample
//
//  Created by Alek Matthiessen on 7/6/20.
//  Copyright © 2020 9elements GmbH. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseDatabase
import Kingfisher
import Kingfisher
import Photos
import FBSDKCoreKit

var didpurchase = Bool()
var selectedgenre = String()
var counter = String()
var ref : DatabaseReference?
var referrer = String()

class DiscoverViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

   var counter = 0
        //
        var books: [Book] = [] {
            didSet {
                
                self.titleCollectionView.reloadData()

                
            }
        }
        @IBOutlet weak var tapHow: UIButton!
        
        override func viewDidAppear(_ animated: Bool) {
            
  
            
    
            
        }
        @IBAction func taphow(_ sender: Any) {
        }
        
        @IBOutlet var searchField: UITextField!
        
        @IBOutlet weak var tapback: UIButton!
        @IBOutlet weak var tapbuton: UIButton!
        @IBAction func tapBack(_ sender: Any) {
            
            titleCollectionView.alpha = 0
            
            if counter > 1 {
                
                tapbuton.alpha = 1
                counter -= 1
                
                
                tapgenre.text = genres[counter]
                selectedgenre = genres[counter]
                
                
                queryforids { () -> Void in
                    
                    
                }
                
                tapbuton.alpha = 0.25
                
            } else {
                
                counter -= 1
                
                
                tapgenre.text = genres[counter]
                selectedgenre = genres[counter]
                
                queryforids { () -> Void in
                    
                    
                }
                
                tapback.alpha = 0
                
            }
            
        }
        
        func queryforinfo() {
            
            ref?.child("Users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                
                let value = snapshot.value as? NSDictionary
                
                if let purchased = value?["Purchased"] as? String {
                    
                    if purchased == "True" {
                        
                        didpurchase = true
                        
                    } else {
                        
                        didpurchase = false
//                        self.performSegue(withIdentifier: "FDiscoverToSale", sender: self)
                        
                    }
                    
                } else {
                    
                    didpurchase = false
//                    self.performSegue(withIdentifier: "FDiscoverToSale", sender: self)
                }
                
            })
            
        }
        
        @IBAction func tapGenre(_ sender: Any) {
            
            titleCollectionView.alpha = 0
            
            if counter < genres.count-1 {
                
                tapbuton.alpha = 0.25
                
                
                tapgenre.text = genres[counter]
                selectedgenre = genres[counter]
                
                queryforids { () -> Void in
                    
                }
                
                tapback.alpha = 0.25
                
            } else {
                
                tapbuton.alpha = 0
                
            }
        }
        @IBOutlet weak var tapgenre: UILabel!
        @IBOutlet weak var tapselectedgenre: UIButton!
        @IBOutlet weak var titleCollectionView: UICollectionView!
        
        @IBOutlet weak var scrollView: UIScrollView!
        
        var swipecounter = Int()
        
        let swipeRightRec = UISwipeGestureRecognizer()
        let swipeLeftRec = UISwipeGestureRecognizer()
        let swipeUpRec = UISwipeGestureRecognizer()
        let swipeDownRec = UISwipeGestureRecognizer()
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            
            titleCollectionView.isUserInteractionEnabled = false
            
        }
        
        @objc func swipeR() {
            
            swipecounter += 1
            selectedindex = swipecounter
            
            genreCollectionView.reloadData()
            
        }
        
        @objc func swipeL() {
            
            swipecounter -= 1
            selectedindex = swipecounter
            genreCollectionView.reloadData()
            
        }
        
        var intdayofweek = Int()
        
        @IBOutlet var darklabel: UILabel!
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            
            print(searchField.text!)
            
            darklabel.alpha = 0
            titleCollectionView.isUserInteractionEnabled = true
            
            if searchField.text != "" {
                
                text = searchField.text!
                
                self.view.endEditing(true)
                
                
                
                queryforsearch()
                
            } else {
                
            }
            
            return true
        }
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            
            self.view.endEditing(true)
            
            titleCollectionView.isUserInteractionEnabled = true
            
        }
        
        @objc func loadList(notification: NSNotification) {
            
            self.titleCollectionView.reloadData()
            
        }
        
        var mycolors = [UIColor]()
        
        @IBOutlet weak var backimage: UIImageView!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            ref = Database.database().reference()
            
            queryforinfo()

            genres.removeAll()
            genres.append("Most Popular")
            genres.append("New")
            genres.append("Natural")
            genres.append("Vivid")
            genres.append("Bright")
            genres.append("High Contrast")
            genres.append("Detail")
            genres.append("Matte")

    //        genres.append("Travel")
    //        genres.append("Vintage")
    //        genres.append("B&W")
    //        genres.append("City")
    //        genres.append("Selfies")
    //        genres.append("Beauty")
    //        genres.append("Fashion")
    //        genres.append("Coast")
    //        genres.append("Island")
    //        genres.append("Nature")
    //        genres.append("Desert")
    //        genres.append("Beach")
    //        genres.append("Mexico")
    //        genres.append("Fall")
    //        genres.append("Winter")
            
            //                                                genres.append("Winter")
            //                                                genres.append("Fall")
            //                                                genres.append("Beauty")
            //                                                genres.append("Home")
            //                                                genres.append("City")
            //                                                genres.append("Fashion")
            //                                                genres.append("B&W")
            //                                                genres.append("Coast")
            //                            genres.append("Island")
            //                            genres.append("Nature")
            //                            genres.append("Beach")
            //
            
            
            
            
            
            
            selectedgenre = "Most Popular"
            
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d"
            let result = dateFormatter.string(from: date)
            
            
            //            let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
            //            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            //            blurEffectView.frame = backimage.bounds
            //            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            //           backimage.addSubview(blurEffectView)
            
            NotificationCenter.default.addObserver(self, selector: #selector(loadList(notification:)), name: NSNotification.Name(rawValue: "load"), object: nil)
            
            
            
            
            if selectedgenre == "" || selectedgenre == "None" {
                
                selectedgenre = "Selfie"
                
                selectedindex = genres.firstIndex(of: selectedgenre)!
                
//                genreCollectionView.reloadData()
                
            } else {
                
                print(selectedindex)
                
                selectedindex = genres.firstIndex(of: selectedgenre)!
                
//                genreCollectionView.reloadData()
                
            }
            
            titleCollectionView.reloadData()
            
            //        addstaticbooks()
            
            
            
   
            
            var screenSize = titleCollectionView.bounds
            var screenWidth = screenSize.width
            var screenHeight = screenSize.height
            
            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
          layout.itemSize = CGSize(width: screenWidth, height: screenWidth/0.85)
            
            titleCollectionView!.collectionViewLayout = layout
            
            queryforids { () -> Void in
                
            }
            
            let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
            swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
            self.view.addGestureRecognizer(swipeLeft)
            
            let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
            swipeRight.direction = UISwipeGestureRecognizer.Direction.right
            self.view.addGestureRecognizer(swipeRight)
            
            counter = 0
            
            
            // Do any additional setup after loading the view.
        }
        
        @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
            
            if let swipeGesture = gesture as? UISwipeGestureRecognizer {
                
                switch swipeGesture.direction {
                case UISwipeGestureRecognizer.Direction.right:
                    
                    if selectedindex > 0 {
                        
                        selectedindex = selectedindex - 1
                        
                        selectedgenre = genres[selectedindex]
                        
                        
                        
                        queryforids { () -> Void in
                            
                        }
                        
//                        genreCollectionView.reloadData()
                        
                    }
                    
                case UISwipeGestureRecognizer.Direction.down:
                    break
                case UISwipeGestureRecognizer.Direction.left:
                    
                    if selectedindex < 3 {
                        
                        selectedindex = selectedindex + 1
                        
                        selectedgenre = genres[selectedindex]
                        
                        
                        queryforids { () -> Void in
                            
                        }
                        
                        
                        genreCollectionView.reloadData()
                        
                    }
                case UISwipeGestureRecognizer.Direction.up:
                    break
                default:
                    break
                }
            }
        }
        
        func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
            
            URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
        }
        
        func downloadImage(from url: URL){
            print("Download Started")
            getData(from: url) { data, response, error in
                guard let _ = data, error == nil else { return }
                print(response?.suggestedFilename ?? url.lastPathComponent)
                //let ab = url.absoluteString
                
                // let image : UIImage = UIImage(data: data!)!
                
                
                print("Download Finished", url.lastPathComponent)
                
                let Url = url.absoluteURL
                
                
                let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                
                let fileURL = documentsURL.appendingPathComponent("\(url.lastPathComponent)")
                
                do {
                    try data?.write(to: fileURL, options: [])
                } catch {
                    print("Unable to write DNG file.")
                    return
                }
                
                let filePath = documentsURL.appendingPathComponent("\(url.lastPathComponent)").path
                
                var assetObj:PHFetchResult<PHAsset>!
                
                DispatchQueue.global(qos: .userInitiated).async {
                    let options = PHFetchOptions()
                    options.sortDescriptors = [NSSortDescriptor.init(key: "creationDate", ascending: true)]
                    options.predicate = NSPredicate(format: "mediaType = %d || mediaType = %d ", PHAssetMediaType.image.rawValue, PHAssetMediaType.video.rawValue)
                    options.includeAllBurstAssets = false
                    options.includeHiddenAssets = true
                    
                    let fileString = url.lastPathComponent
                    
                    let fetchResults = PHAsset.fetchAssets(with: options)
                    
                    DispatchQueue.main.async {
                        assetObj = fetchResults
                        print("Loaded \(fetchResults.count) images.")
                        
                        if(assetObj != nil){
                            
                            let temporaryDNGFileURL = URL(fileURLWithPath: filePath)
                            
                            let options = PHImageRequestOptions()
                            
                            options.isSynchronous = false
                            options.version = .current
                            options.deliveryMode = .opportunistic
                            options.resizeMode = .none
                            options.isNetworkAccessAllowed = false
                            
                            guard assetObj.count > 0 else { return }
                            
                            PHImageManager.default().requestImageData(for: assetObj.lastObject!, options: options, resultHandler: {
                                imageData, dataUTI, imageOrientation, info in
                                
                                let assetURL = temporaryDNGFileURL
                                _ = assetURL.pathExtension
                                
                                
                                // try? imageData?.write(to: temporaryDNGFileURL)
                                
                            })
                            
                            let shareAll = [temporaryDNGFileURL] as [Any]
                            
                            let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
                            
    //                        activityViewController.popoverPresentationController?.sourceView = self.view
                            

    //                        self.present(activityViewController, animated: true, completion: nil)
                            
                            if UIDevice.current.userInterfaceIdiom == .pad {
                                // The app is running on an iPad, so you have to wrap it in a UIPopOverController
                                
                                activityViewController.modalPresentationStyle = .popover
                                let screen = UIScreen.main.bounds
                                
                                let view: UIView = UIView(frame: CGRect(x: 0, y: Int(screen.height) - 250, width: Int(screen.width), height: 250));
                                activityViewController.popoverPresentationController?.sourceView = view
                                
                                
                                self.present(activityViewController, animated: true, completion: nil)
                            } else {
                                
                                self.present(activityViewController, animated: true, completion: nil)
                                
                            }
                        }
                        
                    }
                }
                
                
            }
            
        }
        
        var genreindex = Int()
        var text = String()
        
        func queryforsearch() {
            
            text = text.capitalized
            
            print(text)
            
            ref?.child("AllBooks3").child("All").queryOrdered(byChild: "Name").queryStarting(atValue: text).queryEnding(atValue: text+"\u{f8ff}").observeSingleEvent(of: .value, with: { (snapshot) in
                
                var value = snapshot.value as? NSDictionary
                
                print (value)
                
                if let snapDict = snapshot.value as? [String: AnyObject] {
                    
                    let genre = Genre(withJSON: snapDict)
                    
                    if let newbooks = genre.books {
                        
                        self.books = newbooks
                        
                        print(self.books)
                        
                        self.titleCollectionView.reloadData()
                        self.selectedindex = 1000
                        referrer = "Search"
                        selectedgenre = ""
                        
//                        self.genreCollectionView.reloadData()
                        
                    }
                    
                } else {
                    
                    self.books.shuffle()
                    self.titleCollectionView.reloadData()
                    
                }
                
            })
        }
        
        func queryforids(completed: @escaping (() -> Void) ) {
            
            titleCollectionView.alpha = 0
            
            var functioncounter = 0
            
            
            
            ref?.child("AllBooks1").child(selectedgenre).observeSingleEvent(of: .value, with: { (snapshot) in
                
                var value = snapshot.value as? NSDictionary
                
                print (value)
                
                if let snapDict = snapshot.value as? [String: AnyObject] {
                    
                    let genre = Genre(withJSON: snapDict)
                    
                    if let newbooks = genre.books {
                        
                        self.books = newbooks
                        
                        self.books = self.books.sorted(by: { $0.popularity ?? 0  > $1.popularity ?? 0 })
                        
                    }
                    
                    //                                for each in snapDict {
                    //
                    //                                    functioncounter += 1
                    //
                    //                                    let ids = each.key
                    //
                    //                                    seemoreids.append(ids)
                    //
                    //
                    //                                    if functioncounter == snapDict.count {
                    //
                    //                                        self.updateaudiostructure()
                    //
                    //                                    }
                    //                                }
                    
                }
                
            })
        }
  
        
        
        
        
        
        var dayofmonth = String()
        
        func addstaticbooks() {
                    
            var counter2 = 0
            
            while counter2 < 12 {
                
    //            ref?.child("AllBooks1").child(selectedgenre).child("\(counter2)").updateChildValues(["Author": "Jordan B. Peterson", "BookID": "\(counter2)", "Description": "What does everyone in the modern world need to know? Renowned psychologist Jordan B. Peterson's answer to this most difficult of questions uniquely combines the hard-won truths of ancient tradition with the stunning revelations of cutting-edge scientific research.", "Genre": "\(selectedgenre)", "Image": "F\(counter2)", "Name": "12 Rules for Life", "Completed": "No", "Views": "x", "AmazonURL": "https://www.amazon.com/b?ie=UTF8&node=17025012011"])
                
                //    ref?.child("AllBooks2").child(selectedgenre).child("\(counter2)").updateChildValues([ "Views" : "\(nineviews[counter2])"])
                
                var randomint = Int.random(in: 1..<10)

                ref?.child("AllBooks1").child(selectedgenre).childByAutoId().updateChildValues(["After" : "x", "Download" : "x", "Inspired" : "x", "Views" : "\(randomint)M Uses"])
                
                counter2 += 1
                
            }
            
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    self.view.endEditing(true)
    titleCollectionView.isUserInteractionEnabled = true
    
    
    
    if collectionView.tag == 1 {
      
      selectedindex = indexPath.row
      
      genreCollectionView.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
      
      collectionView.alpha = 0
      
      selectedgenre = genres[indexPath.row]
      
      
      genreindex = indexPath.row
      
      queryforids { () -> Void in
        
      }
      
      
      titleCollectionView.scrollToItem(at: indexPath, at: .top, animated: false)
      //            addstaticbooks()
      
      
      genreCollectionView.reloadData()
      
    } else {
      
      let book = self.book(atIndexPath: indexPath)
      
      if didpurchase {
              
        self.tabBarController?.selectedIndex = 1


//              self.performSegue(withIdentifier: "DiscoverToAdd", sender: self)
        
          } else {
              
              self.performSegue(withIdentifier: "DiscoverToSale", sender: self)

          }
      
      
      
      //print("CELL ITEM===>", book ?? [])
      
      
      
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DiscoverToAdd" {

            let nextView = segue.destination as! HomeTabViewController

                nextView.selectedIndex = 1

      }
    }

    
     var nextViewNumber = Int()

    
  }
        func configurationTextField(textField: UITextField!){
                   textField?.placeholder = "Promo Code"
                   
               }
        
        @IBAction func tapDiscount(_ sender: Any) {
            
            let alert = UIAlertController(title: "Please enter your discount code", message: "", preferredStyle: .alert)
            
            alert.addTextField(configurationHandler: configurationTextField)
            
            alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { action in
                switch action.style{
                case .default:
                    print("default")
                    
                    let textField = alert.textFields![0] // Force unwrapping because we know it exists.
                    
                    if textField.text != "" {
                                                   
                            didpurchase = true
                            
                            ref?.child("Users").child(uid).updateChildValues(["Purchased" : "True"])
                            
                        }
                        
                             
                    
                case .cancel:
                    print("cancel")
                    
                case .destructive:
                    print("destructive")
                    
                    
                }}))
            
            self.present(alert, animated: true, completion: nil)
            
            
        }
        
        private var contentOffset: CGPoint?
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
        }
        
        func organizebyalphabetical() {
            
            titleCollectionView.reloadData()
            
        }
        
        @IBOutlet weak var genreCollectionView: UICollectionView!
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            
            switch collectionView {
            case self.genreCollectionView:
                return genres.count
            case self.titleCollectionView:
                return books.count
            default:
                return 0
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            switch collectionView {
            // Genre collection
            case self.genreCollectionView:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Categories", for: indexPath) as! GenreCollectionViewCell
                
                collectionView.alpha = 1
                cell.titlelabel.text = genres[indexPath.row]
                //            cell.titlelabel.sizeToFit()
                
                //            cell.selectedimage.layer.cornerRadius = 5.0
                //            cell.selectedimage.layer.masksToBounds = true
                
                
                
                
                genreCollectionView.alpha = 1
                
                if selectedindex == 0 {
                    
                    if indexPath.row == 0 {
                        
                        cell.titlelabel.alpha = 1
                        cell.selectedimage.alpha = 1
                        
                    } else {
                        
                        cell.titlelabel.alpha = 0.25
                        cell.selectedimage.alpha = 0
                        
                    }
                }
                
                if selectedindex == 1 {
                    
                    if indexPath.row == 1 {
                        
                        cell.titlelabel.alpha = 1
                        cell.selectedimage.alpha = 1
                        
                    } else {
                        
                        cell.titlelabel.alpha = 0.25
                        cell.selectedimage.alpha = 0
                        
                    }
                    
                }
                
                if selectedindex == 2 {
                    
                    if indexPath.row == 2 {
                        
                        cell.titlelabel.alpha = 1
                        cell.selectedimage.alpha = 1
                        
                    } else {
                        
                        cell.titlelabel.alpha = 0.25
                        cell.selectedimage.alpha = 0
                        
                    }
                    
                }
                
                if selectedindex == 3 {
                    
                    if indexPath.row == 3 {
                        
                        cell.titlelabel.alpha = 1
                        cell.selectedimage.alpha = 1
                        
                    } else {
                        
                        cell.titlelabel.alpha = 0.25
                        cell.selectedimage.alpha = 0
                        
                    }
                    
                }
                
                if selectedindex == 4 {
                    
                    if indexPath.row == 4 {
                        
                        cell.titlelabel.alpha = 1
                        cell.selectedimage.alpha = 1
                        
                    } else {
                        
                        cell.titlelabel.alpha = 0.25
                        cell.selectedimage.alpha = 0
                        
                    }
                }
                
                if selectedindex == 5 {
                    
                    if indexPath.row == 5 {
                        
                        cell.titlelabel.alpha = 1
                        cell.selectedimage.alpha = 1
                        
                    } else {
                        
                        cell.titlelabel.alpha = 0.25
                        cell.selectedimage.alpha = 0
                        
                    }
                    
                }
                
                if selectedindex == 6 {
                    
                    if indexPath.row == 6 {
                        
                        cell.titlelabel.alpha = 1
                        cell.selectedimage.alpha = 1
                        
                    } else {
                        
                        cell.titlelabel.alpha = 0.25
                        cell.selectedimage.alpha = 0
                        
                    }
                    
                }
                
                if selectedindex == 7 {
                    
                    if indexPath.row == 7 {
                        
                        cell.titlelabel.alpha = 1
                        cell.selectedimage.alpha = 1
                        
                    } else {
                        
                        cell.titlelabel.alpha = 0.25
                        cell.selectedimage.alpha = 0
                        
                    }
                    
                }
                
                if selectedindex == 8 {
                    
                    if indexPath.row == 8 {
                        
                        cell.titlelabel.alpha = 1
                        cell.selectedimage.alpha = 1
                        
                    } else {
                        
                        cell.titlelabel.alpha = 0.25
                        cell.selectedimage.alpha = 0
                        
                    }
                    
                }
                
                
                if selectedindex == 9 {
                    
                    if indexPath.row == 9 {
                        
                        cell.titlelabel.alpha = 1
                        cell.selectedimage.alpha = 1
                        
                    } else {
                        
                        cell.titlelabel.alpha = 0.25
                        cell.selectedimage.alpha = 0
                        
                    }
                    
                }
                
                
                if selectedindex == 10 {
                    
                    if indexPath.row == 10 {
                        
                        cell.titlelabel.alpha = 1
                        cell.selectedimage.alpha = 1
                        
                    } else {
                        
                        cell.titlelabel.alpha = 0.25
                        cell.selectedimage.alpha = 0
                        
                    }
                    
                }
                
                
                if selectedindex == 11 {
                    
                    if indexPath.row == 11 {
                        
                        cell.titlelabel.alpha = 1
                        cell.selectedimage.alpha = 1
                        
                    } else {
                        
                        cell.titlelabel.alpha = 0.25
                        cell.selectedimage.alpha = 0
                        
                    }
                    
                }
                
                
                if selectedindex == 12 {
                    
                    if indexPath.row == 12 {
                        
                        cell.titlelabel.alpha = 1
                        cell.selectedimage.alpha = 1
                        
                    } else {
                        
                        cell.titlelabel.alpha = 0.25
                        cell.selectedimage.alpha = 0
                        
                    }
                    
                }
                
                
                if selectedindex == 13 {
                    
                    if indexPath.row == 13 {
                        
                        cell.titlelabel.alpha = 1
                        cell.selectedimage.alpha = 1
                        
                    } else {
                        
                        cell.titlelabel.alpha = 0.25
                        cell.selectedimage.alpha = 0
                        
                    }
                    
                }
                
                
                if selectedindex == 14 {
                    
                    if indexPath.row == 14 {
                        
                        cell.titlelabel.alpha = 1
                        cell.selectedimage.alpha = 1
                        
                    } else {
                        
                        cell.titlelabel.alpha = 0.25
                        cell.selectedimage.alpha = 0
                        
                    }
                    
                }
                
                
                if selectedindex == 15 {
                    
                    if indexPath.row == 15 {
                        
                        cell.titlelabel.alpha = 1
                        cell.selectedimage.alpha = 1
                        
                    } else {
                        
                        cell.titlelabel.alpha = 0.25
                        cell.selectedimage.alpha = 0
                        
                    }
                    
                }
                
                
                if selectedindex == 16 {
                    
                    if indexPath.row == 16 {
                        
                        cell.titlelabel.alpha = 1
                        cell.selectedimage.alpha = 1
                        
                    } else {
                        
                        cell.titlelabel.alpha = 0.25
                        cell.selectedimage.alpha = 0
                        
                    }
                    
                }
                
                
                if selectedindex == 17 {
                    
                    if indexPath.row == 17 {
                        
                        cell.titlelabel.alpha = 1
                        cell.selectedimage.alpha = 1
                        
                    } else {
                        
                        cell.titlelabel.alpha = 0.25
                        cell.selectedimage.alpha = 0
                        
                    }
                    
                }
                
                
                if selectedindex == 18 {
                    
                    if indexPath.row == 18 {
                        
                        cell.titlelabel.alpha = 1
                        cell.selectedimage.alpha = 1
                        
                    } else {
                        
                        cell.titlelabel.alpha = 0.25
                        cell.selectedimage.alpha = 0
                        
                    }
                    
                }
                
                
                if selectedindex == 1000 {
                    
                    cell.titlelabel.alpha = 0.25
                    cell.selectedimage.alpha = 0
                }
                
                return cell
                
            case self.titleCollectionView:
                let book = self.book(atIndexPath: indexPath)
                titleCollectionView.alpha = 1
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Books", for: indexPath) as! TitleCollectionViewCell
                //
                //            if book?.bookID == "Title" {
                //
                //                return cell
                //
                //            } else {
                

//
//                let name = book?.inspiredby
//
//                if (name?.contains(":"))! {
//
//                    var namestring = name?.components(separatedBy: ":")
//
//                    cell.titlelabel.text = namestring![0]
//
//                } else {
//
//                    cell.titlelabel.text = name
//
//                }
                
                
                if let imageURLString = book?.after, let imageUrl = URL(string: imageURLString) {
                    
                    cell.titleImage.kf.setImage(with: imageUrl)
                    
                    
                    
//                    cell.titleImage.layer.cornerRadius = 10.0
//                    cell.titleImage.clipsToBounds = true
                    cell.titleImage.alpha = 1
                    
                    
                    
                    
                    //                    let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
                    //                    let blurEffectView = UIVisualEffectView(effect: blurEffect)
                    //                    blurEffectView.frame = cell.titleback.bounds
                    //                    blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                    //                    cell.titleback.addSubview(blurEffectView)
                    
                    
                }
                
            
//
//                cell.layer.cornerRadius = 10.0
//                cell.layer.masksToBounds = true
                
           
                
//                if book?.views != nil {
//
//                    cell.viewslabel.text = book?.views
//
//
//                } else {
//
//                    cell.viewslabel.text = "1.3M"
//
//                }
//
                
                
                
                return cell
                
                //            }
                
            default:
                
                return UICollectionViewCell()
            }
            
        }
        
        var genres = [String]()
        
        
        var selectedindex = Int()
        
   
        
        @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destinationViewController.
         // Pass the selected object to the new view controller.
         }
         */
        
    }

            // MARK: - Helpers
            extension DiscoverViewController {
                func book(atIndex index: Int) -> Book? {
                    if index > books.count - 1 {
                        return nil
                    }

                    return books[index]
                }

                func book(atIndexPath indexPath: IndexPath) -> Book? {
                    return self.book(atIndex: indexPath.row)
                }
            }

            //var selectedurl = String()

          

