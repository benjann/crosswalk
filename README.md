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

    version 1.0.7  05dec2025
    - in case of an automatic wrapper, crosswalk now returns the link name in r(lnk)

    version 1.0.6  04dec2025
    - fcn(): syntax <prefix>.<basename>() is now supported to declare that <prefix>
      in function <prefix>_<basename>() is a prefix; this has two consequences
      1) crosswalk will look for prefixed labelsets 
      2) crosswalk will use the link defined in file _cwlink_<prefix>.sthlp to
         build automatic wrappers

    02dec2025
    - added to the documentation a reference to the -crosswalk-countries- add-on
      package by Uli Kohler

    version 1.0.5  09sep2025
    - crosswalk generated unwanted output if used with option duplicates(mean), 
      duplicates(min), or duplicates(max); this is fixed

    15apr2025
    - added to the documentation a reference to the -kldbrecode- add-on package
      available from SSC

    version 1.0.4 12mar2025
    - OEP scales updated to version published on OSF on 2025-03-11

    version 1.0.3 08mar2025
    - option -duplicates()- added; -expandok- no longer documented but still
      supported; -expandok- is equivalent to -duplicates(expand)-
    - OEP scales updated to version published on OSF on 2025-03-04
    - may now override the data type implied by -copyrest-; values will be converted
      if necessary; likewise, -string- is now allowed with -copymissing-

    version 1.0.2  21feb2025
    - OEP scales updated to version published on OSF on 2025-02-20; 1-, 2-, 3-digit
      variants of OEP crosswalks removes because they are redundant in the new
      verion

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
