//
//  GLSurface.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 07.06.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation
import OpenGL

/**
Surface struct for shapes
*/
public class GLSurface {
	
	/// Caches the uniforms
	private var _uniforms : [GLurl : GLUniform]?
	
	/// Provides a map of url domain to surface texture
	public var _textures : [GLUrlDomain : GLTextureMap] = [GLUrlDomain : GLTextureMap]()
	
	/// Returns the count of textures this surface uses
	public var textureCount : Int {get {return _textures.count}}
	
	/// Provides the refelction factor
	public var reflection : GLfloat = 0.5
	
	/// Provides the color of the surface
	public var color : GLAttribute?
	
	/// Provides the normals of the surface
	public var normal : GLAttribute?
	
	/// Provides the surface texture for bump mapping
	public var colormap : GLTextureMap? {
		get {return _textures[.ColorMap]}
		set {_textures[.ColorMap] = newValue; _uniforms = nil}
	}
	
	/// Provides the surface texture for bump mapping
	public var bumpmap : GLTextureMap? {
		get {return _textures[.BumpMap]}
		set {_textures[.BumpMap] = newValue}
	}
	
	/// Provides the surface texture for bump mapping
	public var normalmap : GLTextureMap? {
		get {return _textures[.NormalMap]}
		set {_textures[.NormalMap] = newValue}
	}
	
	/// Provides the surface texture for bump mapping
	public var heightmap : GLTextureMap? {
		get {return _textures[.HeightMap]}
		set {_textures[.HeightMap] = newValue}
	}
	
	/// Provides the surface texture for bump mapping
	public var displacementmap : GLTextureMap? {
		get {return _textures[.DisplacementMap]}
		set {_textures[.DisplacementMap] = newValue}
	}
	
	/// Provides the surface texture for bump mapping
	public var glowmap : GLTextureMap? {
		get {return _textures[.GlowMap]}
		set {_textures[.GlowMap] = newValue}
	}
	
	/// Provides the surface texture for bump mapping
	public var diffusemap : GLTextureMap? {
		get {return _textures[.DiffuseMap]}
		set {_textures[.DiffuseMap] = newValue}
	}
	
	/// Provides the surface texture for bump mapping
	public var specularmap : GLTextureMap? {
		get {return _textures[.SpecularMap]}
		set {_textures[.SpecularMap] = newValue}
	}
	
	
	/// Provides the uniforms to apply to program when using this surface
	public var uniforms : [GLurl : GLUniform] {
		get {
			if nil == _uniforms {
				_uniforms = [GLurl : GLUniform]()
				var index : Int = 0
				for domain in _textures.keys {
					if GLint(index) > GL.MAX_COMBINED_TEXTURE_IMAGE_UNITS {
						warn("Max combined texture units exceeded.")
						break
					}
					_uniforms![GLurl(domain, .Sampler)] = GLUniformTexture(_textures[domain]!.texture, index)
					index++
				}
				_uniforms![GLUrlSurfaceReflection] = GLuniform1f(reflection)
			}
			
			return _uniforms!
		}
	}
	
	/// Provides the bufferable properties
	public var bufferables : [GLurl : GLAttribute] {
		get {
			var bufferables : [GLurl : GLAttribute] = [GLurl : GLAttribute]()
			if nil != color {bufferables[GLUrlSurfaceColor] = color!}
			
			for domain in _textures.keys {
				bufferables[GLurl(domain, .TexCoord)] = _textures[domain]
			}
			return bufferables
		}
	}
	
	public init () {}
}