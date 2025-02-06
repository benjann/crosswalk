{smcl}
{* version 1.0.0  30jan2025  Ben Jann}{...}
{hi:isco08_3_to_esec()} {hline 2} Translate 3-digit ISCO-08 to ESeC classes

{title:Syntax}

        {cmd:isco08_3_to_esec(}{varname} [{help crosswalk##case:{it:case}}]{cmd:)}

{pstd}
    where {it:varname} contains 3-digit ISCO-08 codes
    and {it:case} selects the destination column.

{pstd}
    Typical usage:

        {cmd:isco08_3_to_esec(}{varname} {cmd:case.esec(}{it:sempl} {it:supvis}{cmd:)}{cmd:)}

{pstd}
    with {it:sempl} and {it:supvis} as described in {helpb _cwcasefcn_esec:case.esec()}.

{title:Description}

{pstd}
    {helpb crosswalk} table translating 3-digit ISCO-08 codes to ESeC classes
    (European Socio-economic Classification; see Harrison/Rose 2006).

{pstd}
    Cases (destination columns):

            1 = employed, without supervisory status
            2 = employed, with supervisory status
            3 = self-employed, no employees
            4 = self-employed, 1-9 employees
            5 = self-employed, 10 or more employees

{pstd}
    Employees with supervisory status are employees who have formal responsibility
    for supervising the work of other employees. If the data does not contain a
    direct measure of supervisory status, Harrison and Rose (2006, section 4.7)
    suggest coding employees as supervisors if they are supervising at least
    three people.

{title:Source}

{pstd}
    File {bf:{browse "https://www.ericharrison.co.uk/uploads/2/3/9/9/23996844/esec_08_3_digit_public.xlsx":esec_08_3_digit_public.xlsx}}
    provided by Eric Harrison at
    {browse "https://www.ericharrison.co.uk/european-socio-economic-classification-esec.html"}. For
    information on the ESeC classification also see
    {browse "https://www.iser.essex.ac.uk/archives/esec"}. ISCO minor groups
    960, 961, and 962 are missing in the ESeC list provided in
    {bf:esec_08_3_digit_public.xlsx}; {cmd:isco08_3_to_esec()} applies the same
    ESeC classes as for minor groups 950, 951, and 952.

{title:References}

{phang}
    Harrison, E., D. Rose. 2006. The European Socio-economic Classification
    (ESeC) User Guide. Institute for Social and Economic Research,
    University of Essex. Available from
    {browse "http://www.iser.essex.ac.uk/archives/esec/user-guide"}.
    {p_end}
{hline}
{asis}
011 1 1 1 1 1
021 3 2 3 3 3
031 3 2 3 3 3
100 1 1 4 4 1
110 1 1 1 1 1
111 1 1 1 1 1
112 1 1 1 1 1
120 1 1 4 4 1
121 1 1 4 4 1
122 1 1 4 4 1
130 1 1 4 4 1
131 2 2 5 5 1
132 2 2 4 4 1
133 1 1 4 4 1
134 1 1 4 4 1
140 2 2 4 4 1
141 2 2 4 4 1
142 2 2 4 4 1
143 2 2 4 4 1
200 1 1 1 1 1
210 1 1 1 1 1
211 1 1 1 1 1
212 1 1 1 1 1
213 1 1 1 1 1
214 1 1 1 1 1
215 1 1 1 1 1
216 1 1 1 1 1
220 1 1 1 1 1
221 1 1 1 1 1
222 2 2 2 2 1
223 2 2 2 2 1
224 6 6 4 4 1
225 1 1 1 1 1
226 1 1 1 1 1
230 1 1 1 1 1
231 1 1 1 1 1
232 1 1 1 1 1
233 2 2 2 2 1
234 2 2 2 2 1
235 1 1 1 1 1
240 1 1 1 1 1
241 1 1 1 1 1
242 2 2 2 2 1
243 1 1 1 1 1
250 1 1 1 1 1
251 1 1 1 1 1
252 2 2 2 2 1
260 2 2 2 2 1
261 1 1 1 1 1
262 2 2 2 2 1
263 1 1 1 1 1
264 2 2 2 2 1
265 2 2 2 2 1
300 3 2 4 4 1
310 2 2 2 2 1
311 2 2 2 2 1
312 2 2 2 2 1
313 6 2 4 4 1
314 2 2 2 2 1
315 2 2 2 2 1
320 6 6 4 4 1
321 2 2 2 2 1
322 2 2 2 2 1
323 2 2 2 2 1
324 3 6 4 4 1
325 3 2 4 4 1
330 1 1 1 1 1
331 1 1 1 1 1
332 1 1 1 1 1
333 2 2 2 2 1
334 3 2 4 4 1
335 2 2 2 2 2
340 3 2 4 4 1
341 3 2 2 2 1
342 3 2 4 4 1
343 3 2 4 4 1
350 3 2 4 4 1
351 3 2 4 4 1
352 3 2 4 4 1
400 3 2 4 4 1
410 3 2 4 4 1
411 3 2 4 4 1
412 3 2 4 4 1
413 3 2 4 4 1
420 7 6 4 4 1
421 7 6 4 4 1
422 7 6 4 4 1
430 3 2 4 4 1
431 3 2 4 4 1
432 7 2 4 4 1
440 3 6 4 4 1
441 3 6 4 4 1
500 7 6 4 4 1
510 7 6 4 4 1
511 7 6 4 4 1
512 7 6 4 4 1
513 7 6 4 4 1
514 7 6 4 4 1
515 7 6 4 4 1
516 7 6 4 4 1
520 7 6 4 4 1
521 9 7 4 4 1
522 7 6 4 4 1
523 7 6 4 4 1
524 7 6 4 4 1
530 7 6 4 4 1
531 7 6 4 4 1
532 7 6 4 4 1
540 7 6 3 3 3
541 7 6 3 3 3
600 8 6 5 5 1
610 8 6 5 5 1
611 8 6 5 5 1
612 8 6 5 5 1
613 8 6 5 5 1
620 8 6 5 5 1
621 8 6 5 5 1
622 8 6 5 5 1
630 5 5 5 5 5
631 5 5 5 5 5
632 5 5 5 5 5
633 5 5 5 5 5
634 5 5 5 5 5
700 8 6 4 4 1
710 8 6 4 4 1
711 8 6 4 4 1
712 8 6 4 4 1
713 8 6 4 4 1
720 8 6 4 4 1
721 8 6 4 4 1
722 8 6 4 4 1
723 8 6 4 4 1
730 8 6 4 4 1
731 8 6 4 4 1
732 8 6 4 4 1
740 8 6 4 4 1
741 8 6 4 4 1
742 6 6 4 4 1
750 8 6 4 4 1
751 8 6 4 4 1
752 8 6 4 4 1
753 8 6 4 4 1
754 8 6 4 4 1
800 9 6 4 4 1
810 9 6 4 4 1
811 9 6 4 4 1
812 9 6 4 4 1
813 9 6 4 4 1
814 9 6 4 4 1
815 9 6 4 4 1
816 9 6 4 4 1
817 9 6 4 4 1
818 9 6 4 4 1
820 9 6 4 4 1
821 9 6 4 4 1
830 8 6 4 4 1
831 8 6 4 4 1
832 9 6 4 4 1
833 8 6 4 4 1
834 9 6 4 4 1
835 8 6 4 4 1
900 9 6 4 4 1
910 9 6 4 4 1
911 9 6 4 4 1
912 9 6 4 4 1
920 9 6 5 5 1
921 9 6 5 5 1
930 9 6 5 5 1
931 9 6 4 4 1
932 9 6 4 4 1
933 9 6 4 4 1
940 9 6 4 4 1
941 9 6 4 4 1
950 9 6 4 4 1
951 9 6 4 4 1
952 9 6 4 4 1
960 9 6 4 4 1
961 9 6 4 4 1
962 9 6 4 4 1
