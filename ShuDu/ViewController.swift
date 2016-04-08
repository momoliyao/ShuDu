//
//  ViewController.swift
//  ShuDu
//
//  Created by 殷艳 on 16/4/7.
//  Copyright © 2016年 Yinyan. All rights reserved.
//

import UIKit

var swidth:CGFloat = UIScreen.mainScreen().bounds.width
var sheight:CGFloat = UIScreen.mainScreen().bounds.height
var numberArr = [String]()
var n = 5

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.whiteColor()
        
        var button:UIButton = UIButton(frame: CGRectMake(swidth/2 - 50, 40, 100, 40))
        button.setTitle("生成九宫格", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        button.addTarget(self, action: "test", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func test() {
        
        var sudokuArr = [[NSInteger]]()
        for (var i = 0; i < n; i++) {
            var arr = [NSInteger]()
            for (var j = i * n + 1; j < (i + 1) * n + 1; j++) {
                arr.append(0)
            }
            sudokuArr.append(arr)
        }
        
        var middleRow = (n + 1) / 2
        //将1放在第一行的中间列
        sudokuArr[0][middleRow - 1] = 1
        //
        var x = 0
        var y = middleRow - 1
        for (var i = 2; i <= n*n; i++){
            if (x == 0 && y == n - 1) {
                x += 1
            } else {
                var indexX = x - 1 < 0 ? n - 1 : x - 1
                var indexY = y + 1 > n - 1 ? 0 : y + 1
                if (sudokuArr[indexX][indexY] > 0) {
                    indexX = x + 1
                    indexY = y
                }
                x = indexX
                y = indexY
            }
            sudokuArr[x][y] = i
        }
        for (var i = 0; i < sudokuArr.count; i++) {
            for (var j = 0; j < sudokuArr.count; j++) {
                numberArr.append(String(sudokuArr[i][j]))
            }
        }
        
        setLadels()
        print(numberArr)
        print(numberArr.count)
        
    }
    
    func setLadels(){
        for var i = 0; i < n*n; ++i {
            var label:UILabel = UILabel()
            var subX = i%n*Int(swidth)/(n+1)
            var x = subX+20*(i)%(n)+1
            var y = CGFloat(100+(Int(i)/n)*60)
            label.frame = CGRectMake(CGFloat(x), y, swidth/CGFloat(n+1), 40.0)
            label.font = UIFont(name: "zapfino", size: 15.0)
            label.textColor = UIColor.grayColor()
            label.layer.cornerRadius = 5
            label.layer.borderWidth = 1.0
            label.layer.borderColor = UIColor.redColor().CGColor
            label.textAlignment = NSTextAlignment.Center
            label.text = numberArr[i]
            self.view.addSubview(label)
            
        }
        
    }
}

