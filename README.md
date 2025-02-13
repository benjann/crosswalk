# crosswalk
Stata module to recode variable based on crosswalk table (bulk recoding)

`crosswalk` applies fast table-based recoding. Pre-defined
crosswalk tables are provided for common recoding tasks related to occupational
classifications.

To install `crosswalk` from the SSC Archive, type

    . ssc install crosswalk, replace

in Stata. Alternatively, install `crosswalk` from GitHub as follows:

    . net from https://raw.githubusercontent.com/benjann/crosswalk/main/
    . net install crosswalk, replace

Stata version 14 or newer is required. Furthermore, the 
[`moremata`](https://github.com/benjann/moremata) package needs to be installed
on the system:

    . ssc install moremata, replace

---

Main changes:

    version 1.0.1  13feb2025
    - command -crosswalk drop- added
    - command -crosswalk save- added
    - command -crosswalk list- added
    - command -crosswalk import- added
    - command -crosswalk post- added
    - command -crosswalk export- added
    - ilo_isco08_to_isco88()/ilo_isco88_to_isco08() added
    - soc10_to_soc18()/soc18_to_soc10() added
    - soc00_to_soc10()/soc10_to_soc00() added
    - isco08_to_soc10()/soc10_to_isco08() added
    - isco88_to_soc00()/soc00_to_isco88() added
    - labels soc18, soc10, soc00 added
    - can now specify .name(#) in crosswalk wrapper, where # select the column
      containing the origin values; # is assumed 1 if omitted; .name() is now also
      allowed

    version 1.0.0  06feb2025
    - released on GitHub
