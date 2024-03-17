# Normal and Student T distributions Swift

PDF, CDF, and percent-point/quantile functions for the normal and Student’s T distributions adapted from [Rust Library](https://github.com/ankane/dist-rust/)

## Getting Started

- [Normal](#normal)
- [Student’s t](#students-t)

### Normal

### Normal

```swift
import Distrs

Normal().pdf(x: x, mean: mean, std_dev: std_dev)
Normal().cdf(x: x, mean: mean, std_dev: std_dev)
Normal().ppf(p: p, mean: mean, std_dev: std_dev)
```

### Student’s t

```swift
import Distrs

StudentsT().pdf(x: x, n: n)
StudentsT().cdf(x: x, n: n)
StudentsT().ppf(p: p, n: n)
```

## References

- [Algorithm AS 241: The Percentage Points of the Normal Distribution](https://www.jstor.org/stable/2347330)
- [Algorithm 395: Student’s t-distribution](https://dl.acm.org/doi/10.1145/355598.355599)
- [Algorithm 396: Student’s t-quantiles](https://dl.acm.org/doi/10.1145/355598.355600)
- [Rust Library](https://github.com/ankane/dist-rust/)

## Contributing

Everyone is encouraged to help improve this project. Here are a few ways you can help:

- [Report bugs](https://github.com/ambeckley/Normal-and-Student-T-distributions-Swift/issues)
- Fix bugs and [submit pull requests](https://github.com/ambeckley/Normal-and-Student-T-distributions-Swift/pulls)
- Write, clarify, or fix documentation
- Suggest or add new features


