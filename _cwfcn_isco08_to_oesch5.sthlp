{smcl}
{* version 1.0.0  05feb2025  Ben Jann}{...}
{hi:isco08_to_oesch5()} {hline 2} Translate 4-digit ISCO-08 to 5 OESCH classes

{title:Syntax}

        {cmd:isco08_to_oesch5(}{varname} [{help crosswalk##case:{it:case}}]{cmd:)}

{pstd}
    where {it:varname} contains 4-digit ISCO-08 codes
    and {it:case} selects the destination column.

{pstd}
    Typical usage:

        {cmd:isco08_to_oesch5(}{varname} {cmd:case.oesch(}{it:sempl} {it:supvis}{cmd:)}{cmd:)}

{pstd}
    with {it:sempl} and {it:supvis} as described in {helpb _cwcasefcn_oesch:case.oesch()}.

{title:Description}

{pstd}
    {helpb crosswalk} table translating 4-digit ISCO-08 codes to 5 OESCH classes
    (Oesch 2006a,b). Also see {helpb _cwfcn_isco08_to_oesch:isco08_to_oesch()} and
    {helpb _cwfcn_isco08_to_oesch8:isco08_to_oesch8()}.

{pstd}
    Cases (destination columns):

        1 = employed
        2 = self-employed, no employees
        3 = self-employed, 1-9 employees
        4 = self-employed, 10 or more employees

{pstd}
    Case 2 includes helping family members.

{title:Source}

{pstd}
    {cmd:isco08_to_oesch5()} is implemented as a wrapper for 
    {helpb _cwfcn_isco08_to_oesch:isco08_to_oesch()} followed by
    {helpb _cwfcn_oesch_to_oesch5:oesch_to_oesch5()}.

{title:References}

{phang}
    Oesch, D. 2006a. Coming to Grips with a Changing Class Structure. An Analysis
    of Employment Stratification in Britain, Germany, Sweden and Switzerland. International
    Sociology 21(2): 263-288
    {p_end}
{phang}
    Oesch, D. 2006b. Redrawing the Class Map. Stratification and Institutions
    in Britain, Germany, Sweden and Switzerland. Palgrave Macmillan.
    {p_end}
{hline}
{asis}
.isco08_to_oesch
.oesch_to_oesch5
