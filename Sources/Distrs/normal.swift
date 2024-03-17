//
//  File.swift
//  
//
//  Created by Aaron Beckley on 3/17/24.
//
//https://forums.swift.org/t/how-to-get-natural-constant-eulers-number/56572

import Foundation


public struct Normal {
    
    public init() {
        
    }
    
    public func pdf(x: Double, mean: Double, std_dev: Double) -> Double {
        if std_dev <= 0.0 {
            return Double.nan;
        }
        let n = (x - mean) / std_dev
        return (1.0 / (std_dev * sqrt(2.0 * Double.pi))) * exp(-0.5 * n * n)
        
    }
    
    public func cdf(x: Double, mean: Double, std_dev: Double) -> Double {
        let Sqrt2 = 1.4142135623730951
        if std_dev <= 0.0 {
            return Double.nan;
        }
        return 0.5 * (1.0 + erf((x - mean) / (std_dev * Sqrt2)))
    }
    // Wichura, M. J. (1988).
    // Algorithm AS 241: The Percentage Points of the Normal Distribution.
    // Journal of the Royal Statistical Society. Series C (Applied Statistics), 37(3), 477-484.
    //https://developer.apple.com/documentation/swift/floatingpoint
    public func ppf(p: Double, mean: Double, std_dev: Double) -> Double {
        if !(0.0...1.0).contains(p) || std_dev <= 0.0 || mean.isNaN || std_dev.isNaN {
            return Double.nan
        }
        if p == 0.0 {
            return -Double.infinity
        }
        if p == 1.0 {
            return Double.infinity
        }
        let q = p - 0.5
        if abs(q) < 0.425 {
            let r = 0.180625 - q * q
            return mean + std_dev * q * (((((((2.5090809287301226727e3 * r + 3.3430575583588128105e4) * r + 6.7265770927008700853e4) * r + 4.5921953931549871457e4) * r + 1.3731693765509461125e4) * r + 1.9715909503065514427e3) * r + 1.3314166789178437745e2) * r + 3.3871328727963666080e0) / (((((((5.2264952788528545610e3 * r + 2.8729085735721942674e4) * r + 3.9307895800092710610e4) * r + 2.1213794301586595867e4) * r + 5.3941960214247511077e3) * r + 6.8718700749205790830e2) * r + 4.2313330701600911252e1) * r + 1.0)
        } else {
            var r = 0.0
            if q < 0.0 {
                r = p
            } else {
                r = 1.0 - p
            }
            r = sqrt(-log(r))
            let sign = if q < 0.0 { -1.0 } else { 1.0 }
            if r < 5.0 {
                r -= 1.6
                return mean + std_dev * sign *
                (((((((7.74545014278341407640e-4 * r + 2.27238449892691845833e-2) * r + 2.41780725177450611770e-1) * r + 1.27045825245236838258e0) * r + 3.64784832476320460504e0) * r + 5.76949722146069140550e0) * r + 4.63033784615654529590e0) * r + 1.42343711074968357734e0) /
                (((((((1.05075007164441684324e-9 * r + 5.47593808499534494600e-4) * r + 1.51986665636164571966e-2) * r + 1.48103976427480074590e-1) * r + 6.89767334985100004550e-1) * r + 1.67638483018380384940e0) * r + 2.05319162663775882187e0) * r + 1.0)
            } else {
                r -= 5.0;
                return mean + std_dev * sign *
                (((((((2.01033439929228813265e-7 * r + 2.71155556874348757815e-5) * r + 1.24266094738807843860e-3) * r + 2.65321895265761230930e-2) * r + 2.96560571828504891230e-1) * r + 1.78482653991729133580e0) * r + 5.46378491116411436990e0) * r + 6.65790464350110377720e0) /
                (((((((2.04426310338993978564e-15 * r + 1.42151175831644588870e-7) * r + 1.84631831751005468180e-5) * r + 7.86869131145613259100e-4) * r + 1.48753612908506148525e-2) * r + 1.36929880922735805310e-1) * r + 5.99832206555887937690e-1) * r + 1.0)
                
            }
            
        }
        
    }
    
}


