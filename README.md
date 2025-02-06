# crosswalk
Stata module to recode variable based on crosswalk table (bulk recoding)

`crosswalk` applies fast table-based recoding. Pre-defined
crosswalk tables are provided for common recoding tasks related to occupational
classifications.

Installation of `crosswalk` from GitHub:

    . net from https://raw.githubusercontent.com/benjann/crosswalk/main/
    . net install crosswalk, replace

Stata version 14 or newer is required, and the 
[`moremata`](https://github.com/benjann/moremata) package needs to be installed:

    . ssc install moremata, replace

---

Main changes:

    06feb2025 (version 0.1.0)
    - released on GitHub
