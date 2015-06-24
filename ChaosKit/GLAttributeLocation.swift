//
//  Attribute.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 30.01.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation
import OpenGL

/*
|--------------------------------------------------------------------------
| AttribLocation
|--------------------------------------------------------------------------
*/

public class GLAttributeLocation : GLLocation {
	
	private var _ptr :  UnsafeMutablePointer<UnsafeMutablePointer<Void>>
	
	
	/**
	Initializes the attribute location
	
	:param: index The attribute location fetched by glGetAttribLocation
	:param: name The string variable name of the attribute
	*/
	public init (index: GLuint, name: String) {
		_ptr = UnsafeMutablePointer<UnsafeMutablePointer<Void>>.alloc(1)
		glGetVertexAttribPointerv(index, GLenum(GL_VERTEX_ATTRIB_ARRAY_POINTER), _ptr)
		super.init(index, name)
	}
	
	
	/**
	En- or disables the attribute location for the accroding program
	
	:param: enable
	*/
	public func setEnabled (enable: Bool) {
		if enable {self.enable()}
		else {self.disable()}
	}
	
	
	/**
	Shortcut for glGetVertexAttribPointerv
	
	:return: The pointer to the attribute
	*/
	public func getVertexAttribPointer () -> UnsafeMutablePointer<Void> {
		return _ptr.memory
	}
	
	
	/**
	Shortcut for glVertexAttribPointer
	
	:param: block The buffer block that holds the information for the attribute within the accroding buffer
	*/
	public func setVertexAttribPointer (block: GLBufferBlock) {
		var floatSize : Int = sizeof(GLfloat)
		setVertexAttribPointer(block.size, block.type, block.normalized, block.stride, block.offset)
	}
	
	
	/**
	Shortcut for glVertexAttribPointer
	
	:param: size The size of the attribute value per vertex in the buffer
	:param: type The data type of an element of an attribute values
	:param: normalized
	:param: stride
	:param: pointer
	*/
	public func setVertexAttribPointer (size: GLint, _ type: GLenum, _ normalized: Bool, _ stride: Int) {
		setVertexAttribPointer(size, type, normalized, stride, _ptr.memory)
	}
	
	
	/**
	Shortcut for glVertexAttribPointer
	
	:param: size The size of the attribute value per vertex in the buffer
	:param: type The data type of an element of an attribute values
	:param: normalized
	:param: stride
	:param: pointer
	*/
	public func setVertexAttribPointer (size: GLint, _ type: GLenum, _ normalized: Bool, _ stride: Int, _ offset: Int) {
		setVertexAttribPointer(size, type, normalized, stride, _ptr.memory.advancedBy(sizeof(GLfloat) * offset))
	}
	
	
	/**
	Shortcut for glVertexAttribPointer
	
	:param: size The size of the attribute value per vertex in the buffer
	:param: type The data type of an element of an attribute values
	:param: normalized
	:param: stride
	:param: pointer
	*/
	public func setVertexAttribPointer (size: GLint, _ type: GLenum, _ normalized: Bool, _ stride: Int, _ pointer: UnsafeMutablePointer<Void>) {
		glVertexAttribPointer(id, size, type, GLboolean(normalized ? GL_TRUE : GL_FALSE), GLsizei(stride * sizeof(GLfloat)), pointer)
	}
	
	/**
	Enables the attribute for the program
	*/
	public func enable () {
		glEnableVertexAttribArray(id)
	}
	
	/**
	Disables the attribute for the program
	*/
	public func disable () {
		glDisableVertexAttribArray(id)
	}
	
	
	deinit {
		_ptr.destroy()
		_ptr.dealloc(1)
	}
}

