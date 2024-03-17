//
//  File 4.swift
//  
//
//  Created by Aaron Beckley on 3/17/24.
//

import Foundation


public struct StudentsT {
    
    public init() {
        
    }
    

    public func pdf(x: Double, n: Double) -> Double {
        if n.isNaN || n <= 0.0 {
            return Double.nan
        }
        if n == Double.infinity {
            return Normal().pdf(x: x, mean: 0.0, std_dev: 1.0)
        }
        return tgamma((n + 1.0) / 2.0) / (sqrt(n * Double.pi) * tgamma(n / 2.0)) * pow(1.0 + x * x / n, -(n + 1.0) / 2.0)
        
    }
    
    public func cdf(x: Double, n: Double) -> Double {
        if x.isNaN || n.isNaN || n < 1.0 {
            return Double.nan
        }
        if x == -Double.infinity {
            return 0.0
        }
        if x == Double.infinity {
            return 1.0
        }
        if n == Double.infinity {
            return Normal().cdf(x: x, mean: 0.0, std_dev: 1.0)
        }
        
        let (start, sign) = if x < 0.0 {
            (0.0, 1.0)
        } else {
            (1.0, -1.0)
        }
        var z = 1.0
        let t = x * x
        var y = t / n
        var b = 1.0 + y
        
        if n > floor(n) || (n >= 20.0 && t < n) || n > 200.0 {
            // asymptotic series for large or noninteger n
            if y > 10e-6 {
                y = log(b)
            }
            let a = n - 0.5
            b = 48.0 * a * a
            y *= a
            y = (((((-0.4 * y - 3.3) * y - 24.0) * y - 85.5) / (0.8 * y * y + 100.0 + b) + y + 3.0) / b + 1.0) * sqrt(y)
            return start + sign * Normal().cdf(x: -y, mean: 0.0, std_dev: 1.0)
        }
        // make n mutable and int
        // n is int between 1 and 200 if made it here
        //n = UInt8(n)
        var n = n
        
        if n < 20 && t < 4.0 {
            // nested summation of cosine series
            y = sqrt(y)
            var a = y
            if n == 1{
                a = 0.0
            }
            //loop
            if n > 1 {
                n -= 2
                while n > 1 {
                    a = (n - 1) / (b * n) * a + y
                    n -= 2
                }
            }
      
            a = if n == 0 { a / sqrt(b) } else { (atan(y) + a / b) * (2.0 / Double.pi) }
            return start + sign * (z - a) / 2.0
            
        }
        
        // tail series expanation for large t-values
        var a = sqrt(b)
        y = a * n
        var j = 0.0
        while a != z {
            j += 2
            z = a
            y = y * (j - 1) / (b * j)
            a += y / (n + j)
            }
        z = 0.0
        y = 0.0
        a = -a
        
        // loop (without n + 2 and n - 2)
        while n > 1 {
            a = (n - 1) / (b * n) * a + y
            n -= 2
        }
        a = if n == 0 { a / sqrt(b) } else { (atan(y) + a / b) * (2.0 / Double.pi) }
        return start + sign * (z - a) / 2.0
        
    }
    
    
    // Hill, G. W. (1970).
    // Algorithm 396: Student's t-quantiles.
    // Communications of the ACM, 13(10), 619-620.
    public func ppf(p: Double, n: Double) -> Double {
        if !(0.0...1.0).contains(p) || n < 1.0 {
            return Double.nan
        }
        if n == Double.infinity {
            return Normal().ppf(p: p, mean: 0.0, std_dev: 1.0)
        }
        
        // distribution is symmetric
        var (sign, p) = if p < 0.5 {
            (-1.0, 1.0 - p)
        } else {
            (1.0, p)
        }
        // two-tail to one-tail
        p = 2.0 * (1.0 - p)
        if n == 2.0 {
            return sign * sqrt(2.0 / (p * (2.0 - p)) - 2.0)
        }
        
        let half_pi = Double.pi / 2.0;
        if n == 1.0 {
            p = p * half_pi
            return sign * cos(p) / sin(p)
        }
        let a = 1.0 / (n - 0.5)
        let b = 48.0 / (a * a)
        var c = ((20700.0 * a / b - 98.0) * a - 16.0) * a + 96.36
        let d = ((94.5 / (b + c) - 3.0) / b + 1.0) * sqrt(a * half_pi) * n
        var x = d * p
        var y = pow(x, 2.0 / n)
        if y > 0.05 + a {
            // asymptotic inverse expansion about normal
            x = Normal().ppf(p: p * 0.5, mean: 0.0, std_dev: 1.0)
            y = x * x
            if n < 5.0 {
                c += 0.3 * (n - 4.5) * (x + 0.6)
            }
            c += (((0.05 * d * x - 5.0) * x - 7.0) * x - 2.0) * x + b
            y = (((((0.4 * y + 6.3) * y + 36.0) * y + 94.5) / c - y - 3.0) / b + 1.0) * x
            y = a * y * y
            y = if y > 0.002 { exp(y) - 1.0 } else { 0.5 * y * y + y}
        } else {
            y = ((1.0 / (((n + 6.0) / (n * y) - 0.089 * d - 0.822) * (n + 2.0) * 3.0) + 0.5 / (n + 4.0)) * y - 1.0) * (n + 1.0) / (n + 2.0) + 1.0 / y
        }
        return sign * sqrt(n * y)
        
    }
    
    
    
    
}
