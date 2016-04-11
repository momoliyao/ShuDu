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
var n:Int!

class ViewController: UIViewController {
    
    var textField:UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.whiteColor()
        //创建输入框
        textField = UITextField(frame: CGRectMake(10,40,200,30))
        textField.borderStyle = UITextBorderStyle.RoundedRect
        textField.placeholder = "输入值（3，5，7）"
        self.view.addSubview(textField)
        
        let button:UIButton = UIButton(frame: CGRectMake(CGRectGetMaxX(textField.frame), 40, 100, 40))
        button.setTitle("生成数独", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        button.addTarget(self, action: "test", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func test() {
        //每次计算时，先移除界面上的显示数据
        //获取到界面上所有的子视图
        let chileViews = self.view.subviews
        //        print(chileViews)
        for view:UIView in chileViews  {
            //如果是label对象就移除
            if view.isKindOfClass(UILabel) {
                numberArr .removeAll()
                view.removeFromSuperview()
            }
            
        }
        //把输入框的值赋给n
        let str = textField.text
        if (str == "") {
            //如果没有输入值，默认为3
            n = 3
        } else {
            
            n = Int(str!)!
        }
        
        var sudokuArr = [[NSInteger]]()
        for (var i = 0; i < n; i++) {
            var arr = [NSInteger]()
            for (var j = i * n + 1; j < (i + 1) * n + 1; j++) {
                arr.append(0)
            }
            sudokuArr.append(arr)
        }
        
        let middleRow = (n + 1) / 2
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
            let label:UILabel = UILabel()
            let subX = i%n*Int(swidth)/(n+1)
            let x = subX+20*(i)%(n)+1
            let y = CGFloat(100+(Int(i)/n)*60)
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
        
        textField.text = ""
    }
}

