//
//  GLRenderpassCapability.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 03.05.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation
import OpenGL
import OpenGL.GL

/**
Struct to en- or disable OpenGL rendering capabilities
*/
public struct GLcap {
	
	/// Contains the capability type such as GL_DEPTH_TEST
	public let type : GLenum
	
	/// Indicates if the capability should be en- or disabled
	public let enabled : Bool
	
	/// Provides either glEnable or glDisable
	private let _apply : (cap: GLenum) -> Void
	
	
	public init (_ type: GLenum, _ enable: Bool) {
		self.type = type
		self.enabled = enable
		_apply = enable ? glEnable : glDisable
	}
	
	
	public init (_ type: GLenum) {
		self.init(type, true)
	}
	
	/**
	Initializes the capability
	
	- parameter type: The capability type
	- parameter enable: Indicates either to enable
	*/
	public init (_ type: Int32, _ enable: Bool) {
		self.init(GLenum(type), enable)
	}
	
	
	public init (_ type: Int32) {
		self.init(GLenum(type), true)
	}
	
	/**
	Applies the capability setting
	*/
	public func apply () {
		_apply(cap: type)
	}
}