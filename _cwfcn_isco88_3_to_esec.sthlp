{smcl}
{* version 1.0.0  30jan2025  Ben Jann}{...}
{hi:isco88_3_to_esec()} {hline 2} Translate 3-digit ISCO-88 to ESeC classes

{title:Syntax}

        {cmd:isco88_3_to_esec(}{varname} [{help crosswalk##case:{it:case}}]{cmd:)}

{pstd}
    where {it:varname} contains 3-digit ISCO-88 codes
    and {it:case} selects the destination column.

{pstd}
    Typical usage:

        {cmd:isco88_3_to_esec(}{varname} {cmd:case.esec88(}{it:sempl} {it:supvis}{cmd:)}{cmd:)}

{pstd}
    with {it:sempl} and {it:supvis} as described in {helpb _cwcasefcn_esec88:case.esec88()}.

{title:Description}

{pstd}
    {helpb crosswalk} table translating 3-digit ISCO-88 codes to ESeC classes
    (European Socio-economic Classification; see Harrison/Rose 2006).

{pstd}
    Cases (destination columns):

        1 = employment status unknown (simplified ESeC)
        2 = employed, without supervisory status
        3 = employed, with supervisory status
        4 = self-employed, no employees
        5 = self-employed, 1-9 employees
        6 = self-employed, 10 or more employees

{pstd}
    Employees with supervisory status are employees who have formal responsibility
    for supervising the work of other employees. If the data does not contain a
    direct measure of supervisory status, Harrison and Rose (2006, section 4.7)
    suggest coding employees as supervisors if they are supervising at least
    three people.

{title:Source}

{pstd}
    File {bf:{browse "https://www.iser.essex.ac.uk/files/esec/nsi/matrices/Euroesec%20matrix.xls":Euroesec matrix.xls}}
    from {browse "https://www.iser.essex.ac.uk/archives/esec"}. Note that the ESeC translator is
    based on {browse "https://warwick.ac.uk/fac/soc/ier/research/classification/isco88":ISCO-88(COM)},
    the European Union variant of the ISCO-88. If your data contains ISCO-88 codes
    you might first want to translate these codes to ISCO-88(COM) using
    {cmd:isco88_to_isco88com()}.

{title:References}

{phang}
    Harrison, E., D. Rose. 2006. The European Socio-economic Classification
    (ESeC) User Guide. Institute for Social and Economic Research,
    University of Essex. Available from
    {browse "http://www.iser.essex.ac.uk/archives/esec/user-guide"}.
    {p_end}
{hline}
{asis}
010 1 1 1 1 1 1
011 3 3 2 3 3 3
100 1 1 1 4 4 1
110 1 1 1 1 1 1
111 1 1 1 1 1 1
114 1 1 1 1 1 1
120 1 1 1 4 4 1
121 1 1 1 4 4 1
122 2 2 2 4 4 1
123 1 1 1 4 4 1
130 4 2 2 4 4 1
131 4 2 2 4 4 1
200 1 1 1 1 1 1
210 1 1 1 1 1 1
211 1 1 1 1 1 1
212 1 1 1 1 1 1
213 1 1 1 1 1 1
214 1 1 1 1 1 1
220 1 1 1 1 1 1
221 1 1 1 1 1 1
222 1 1 1 1 1 1
223 2 2 2 2 2 1
230 2 2 2 2 2 1
231 1 1 1 1 1 1
232 2 2 2 2 2 1
233 2 2 2 2 2 1
234 2 2 2 2 2 1
235 1 1 1 1 1 1
240 1 1 1 1 1 1
241 1 1 1 1 1 1
242 1 1 1 1 1 1
243 2 2 2 2 2 1
244 2 2 2 2 2 1
245 2 2 2 2 2 1
246 2 2 2 2 2 1
247 2 2 2 2 2 1
300 3 3 2 4 4 1
310 2 2 2 2 2 1
311 2 2 2 2 2 1
312 2 2 2 2 2 1
313 6 6 2 4 4 1
314 2 2 2 2 2 1
315 6 6 6 4 4 1
320 2 2 2 2 2 1
321 2 2 2 2 2 1
322 2 2 2 2 2 1
323 2 2 2 2 2 1
330 3 3 2 4 4 1
331 3 3 2 4 4 1
332 3 3 2 4 4 1
333 3 3 2 4 4 1
334 2 2 2 2 2 1
340 3 3 2 4 4 1
341 3 3 2 4 4 1
342 2 2 2 2 2 1
343 3 3 2 4 4 1
344 2 2 2 2 2 2
345 2 2 2 2 2 2
346 3 3 2 4 4 1
347 3 3 2 4 4 1
348 2 2 2 2 2 1
400 3 3 2 4 4 1
410 3 3 2 4 4 1
411 3 3 2 4 4 1
412 3 3 2 4 4 1
413 7 7 6 4 4 1
414 9 9 6 4 4 1
419 3 3 2 4 4 1
420 3 3 2 4 4 1
421 7 7 6 4 4 1
422 7 7 6 4 4 1
500 7 7 6 4 4 1
510 7 7 6 4 4 1
511 7 7 6 4 4 1
512 9 9 6 4 4 1
513 7 7 6 4 4 1
514 7 7 6 4 4 1
516 7 7 6 3 3 3
520 7 7 6 4 4 1
521 2 2 2 4 4 1
522 7 7 6 4 4 1
600 5 8 6 5 5 1
610 5 8 6 5 5 1
611 5 8 6 5 5 1
612 5 8 6 5 5 1
613 5 8 6 5 5 1
614 8 8 6 5 5 1
615 8 8 6 5 5 1
621 5 5 5 5 5 5
700 8 8 6 4 4 1
710 8 8 6 4 4 1
711 8 8 6 4 4 1
712 8 8 6 4 4 1
713 8 8 6 4 4 1
714 8 8 6 4 4 1
720 8 8 6 4 4 1
721 8 8 6 4 4 1
722 8 8 6 4 4 1
723 8 8 6 4 4 1
724 8 8 6 4 4 1
730 6 6 6 4 4 1
731 6 6 6 4 4 1
732 8 8 6 4 4 1
733 8 8 6 4 4 1
734 8 8 6 4 4 1
740 8 8 6 4 4 1
741 8 8 6 4 4 1
742 8 8 6 4 4 1
743 8 8 6 4 4 1
744 8 8 6 4 4 1
800 9 9 6 4 4 1
810 9 9 6 4 4 1
811 9 9 6 4 4 1
812 9 9 6 4 4 1
813 9 9 6 4 4 1
814 9 9 6 4 4 1
815 9 9 6 4 4 1
816 9 9 6 4 4 1
817 9 9 6 4 4 1
820 9 9 6 4 4 1
821 9 9 6 4 4 1
822 9 9 6 4 4 1
823 9 9 6 4 4 1
824 9 9 6 4 4 1
825 8 8 6 4 4 1
826 9 9 6 4 4 1
827 9 9 6 4 4 1
828 9 9 6 4 4 1
829 9 9 6 4 4 1
830 9 9 6 4 4 1
831 8 8 6 4 4 1
832 9 9 6 4 4 1
833 9 9 6 4 4 1
834 8 8 6 4 4 1
900 9 9 6 4 4 1
910 9 9 6 4 4 1
911 4 7 6 4 4 1
912 9 9 6 4 4 1
913 9 9 6 4 4 1
914 9 9 6 4 4 1
915 9 9 6 4 4 1
916 9 9 6 4 4 1
920 9 9 6 5 5 1
921 9 9 6 5 5 1
930 9 9 6 4 4 1
931 9 9 6 4 4 1
932 9 9 6 4 4 1
933 9 9 6 4 4 1
