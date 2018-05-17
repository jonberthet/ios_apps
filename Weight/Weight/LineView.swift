//
//  LineView.swift
//  Weight
//
//  Created by Matthew Newill on 24/11/2016.
//  Copyright © 2016 DevFright.com. All rights reserved.
//

import UIKit

class LineView: UIView {
    
    public var lineColour = UIColor .red
    public var pointColour = UIColor .red
    public var horizontalLineColour = UIColor .gray
    
    //// The value of the top line on the graph (defaulted to 10)
    public var height : CGFloat = 10.0
    
    //// point0 is on the far left of the graph.
    public var point0 : CGFloat = 8.0
    public var point1 : CGFloat = 1.0
    public var point2 : CGFloat = 2.0
    public var point3 : CGFloat = 3.0
    public var point4 : CGFloat = 4.0
    public var point5 : CGFloat = 5.0
    public var point6 : CGFloat = 100.0
    
    //// Linewidth is defaulted to 2.0
    public var lineWidth : CGFloat = 2.0
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        Graphs .draw_7PointLine(frame: self.frame,
                                resizing: .aspectFit,
                                line: lineColour,
                                point: pointColour,
                                horizontal: horizontalLineColour,
                                height: height,
                                point0Value: point0,
                                point1Value: point1,
                                point2Value: point2,
                                point3Value: point3,
                                point4Value: point4,
                                point5Value: point5,
                                point6Value: point6,
                                lineWidth: lineWidth)
    }
 

}


