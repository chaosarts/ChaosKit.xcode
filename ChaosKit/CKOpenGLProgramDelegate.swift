//
//  CKOpenGLProgramDelegate.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 05.02.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa
import OpenGL

@objc public protocol CKOpenGLProgramDelegate {	
	optional func bindLocations (view: CKOpenGLView)
}
