//
//  GLScreenRenderpass.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 11.05.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public class GLScreenRenderpass : GLRenderpassBase, GLRenderpass {
	
	public var program : GLProgram
	
	public var camera : GLCamera = GLCamera()
	
	public init (program: GLProgram) {
		self.program = program
	}
	
	/**
	Renders the stage
	*/
	public func execute () {
		program.use()
		
		applyCapabilities()
		applyHints()
		clear()
		
		if camera.stage == nil {
			print("No stage set for camera.")
			return
		}
		
		var uniforms : [GLurl : GLUniform] = camera.uniforms
		for url in uniforms.keys {
			let location : GLuniformloc? = program.getUniformLocation(url)
			
			if nil == location {continue}
			
			let uniform : GLUniform = uniforms[url]!
			uniform.assign(location!)
		}
		
		let stage : GLStage = camera.stage!
		for shape in stage.shapes {
			var uniforms : [GLurl : GLUniform] = shape.uniforms
			
			for url in uniforms.keys {
				let location : GLuniformloc? = program.getUniformLocation(url)
				let uniform : GLUniform = uniforms[url]!
				if nil == location {continue}
				uniform.assign(location!)
			}
			
			shape.draw(program: program)
		}
		
		glFlush()
	}
}