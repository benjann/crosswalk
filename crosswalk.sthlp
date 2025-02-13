{smcl}
{* 13feb2025}{...}
{viewerjumpto "Syntax" "crosswalk##syntax"}{...}
{viewerjumpto "Description" "crosswalk##description"}{...}
{viewerjumpto "Options" "crosswalk##options"}{...}
{viewerjumpto "Remarks" "crosswalk##remarks"}{...}
{viewerjumpto "Examples" "crosswalk##examples"}{...}
{viewerjumpto "Stored results" "crosswalk##stored"}{...}
{viewerjumpto "References" "crosswalk##references"}{...}
{viewerjumpto "Author" "crosswalk##author"}{...}
{viewerjumpto "Also see" "crosswalk##alsosee"}{...}
{hi:help crosswalk}{...}
{right:{browse "https://github.com/benjann/crosswalk/"}}
{hline}

{title:Title}

{pstd}{hi:crosswalk} {hline 2} Recode variable based on crosswalk table (bulk recoding)


{marker syntax}{...}
{title:Syntax}

{pstd}
    Main command: recode a variable using crosswalk table {it:fcn}{cmd:()}

{p 8 15 2}
    {cmd:crosswalk} {newvar} {cmd:=}
    {help crosswalk##fcn:{it:fcn}}{cmd:(}{it:varname} [{help crosswalk##case:{it:case}}]{cmd:)}
    {ifin} [{cmd:,} {help crosswalk##opt:{it:options}} ]

{pstd}
    Utilities:

{p 4 6 2}o
    Generate {help crosswalk##case:{it:case}} indicator

{p 8 15 2}
    {cmd:crosswalk} {newvar} {cmd:=}
    {help crosswalk##casefcn:{it:casefcn}}{cmd:(}{it:arguments}{cmd:)} {ifin}
    [{cmd:,} {opt r:eplace} ]

{p 4 6 2}o
    Assign value labels (to existing variables)

{p 8 15 2}
    {cmd:crosswalk} {cmdab:l:abel} {help crosswalk##lblset:{it:lblset}}
    [{varlist}] [{cmd:,} {help crosswalk##lblopt:{it:label_options}} ]

{p 4 6 2}o
    Define and manage {help crosswalk##cwtable:custom crosswalk tables} in memory

        {cmd:crosswalk} {cmdab:d:efine} {it:fcn}[{cmd:()}]
        {it:<line 1>}
        {it:<line 2>}
        {it:...}
        {cmd:end}

{p 6 6 2}
    defines custom crosswalk table {it:fcn}{cmd:()} in memory. Crosswalk tables in memory take
    precedence over crosswalk tables on disk. However, note that names of
    crosswalk tables in memory are case sensitive, whereas names of crosswalk
    tables on disk are typically not.

        {cmd:crosswalk} {cmd:drop} {it:fcn}[{cmd:()}]

{p 6 6 2}
    deletes custom crosswalk table {it:fcn}{cmd:()} from memory.

        {cmd:crosswalk} {cmd:save} {it:fcn}[{cmd:()}] [{cmd:,} {opt r:eplace} {opt path(path)} ]

{p 6 6 2}
    stores custom crosswalk table {it:fcn}{cmd:()} in a file on disk, to make it
    permanently available. Option {cmd:replace} allows overwriting an existing
    file; {cmd:path()} specifies a destination directory.

        {cmd:crosswalk} {cmdab:di:r}

{p 6 6 2}
    lists the names of all crosswalk tables that are currently defined in
    memory.

        {cmd:crosswalk} {cmd:clear}

{p 6 6 2}
    deletes all crosswalk tables that are currently defined in memory.

{p 4 6 2}o
    List the contents of a crosswalk table (from disk or memory) in the
    results window

        {cmd:crosswalk} {cmd:list} {it:fcn}[{cmd:()}]

{p 4 6 2}o
    Manipulate an existing crosswalk table

        {cmd:crosswalk} {cmd:import} {it:fcn}[{cmd:()}] [{cmd:,} {opt clear} ]

{p 6 6 2}
    imports the contents of crosswalk table {it:fcn}{cmd:()} (be it from memory
    or from disk) into the (current) data frame, so that it can be modified
    using Stata's {help data_management:data management} commands. Option
    {cmd:clear} allows replacing the current data even though it has not been
    saved. Each column of the crosswalk table will be imported as a separate
    string variable. Use command {helpb destring} to convert variables to
    numeric format if needed.

        {cmd:crosswalk} {cmd:post} {it:fcn}[{cmd:()}]

{p 6 6 2}
    posts the contents of the (current) data frame as crosswalk table
    {it:fcn}{cmd:()} in memory. Use this command after {cmd:crosswalk import}
    to make the imported and possibly modified data available as a custom
    crosswalk table in memory. Numeric variables will be converted to string
    using their {help format:display format}.

        {cmd:crosswalk} {cmd:export} {it:fcn}[{cmd:()}] [{cmd:,} {opt r:eplace} {opt path(path)} ]

{p 6 6 2}
    stores the contents of the (current) data frame as crosswalk table
    {it:fcn}{cmd:()} in a file on disk. Use this command after
    {cmd:crosswalk import} to make the imported and possibly modified data
    permanently available as a new crosswalk table on disk. Numeric variables will be
    converted to string using their {help format:display format}. Option
    {cmd:replace} allows overwriting an existing file; {cmd:path()}
    specifies a destination directory.


{synoptset 26}{...}
{marker opt}{...}
{synopt :{help crosswalk##opts:{it:options}}}Description{p_end}
{synoptline}
{synopt :{opt expand:ok}}allow non-unique crosswalk table and expand data if needed
    {p_end}
{synopt :{opt mis:sing}}treat missing values like other values
    {p_end}
{synopt :{opt copy:rest}[{cmd:(}{cmdab:nol:abel}{cmd:)}]}copy values that are out of scope
    {p_end}
{synopt :{opt copymis:sing}[{cmd:(}{cmdab:nol:abel}{cmd:)}]}copy extended missing values
    {p_end}
{synopt :{cmdab:l:abel(}[{help crosswalk##lblset:{it:lblset}}][{cmd:,} {opt min:imal}]{cmd:)}}assign custom value labels
    {p_end}
{synopt :{opt nol:abel}}omit automatic value labels
    {p_end}
{synopt :{opt str:ing}}enforce string format
    {p_end}
{synopt :{opt num:eric}}enforce numeric format
    {p_end}
{synopt :{opt noinfo}}omit out-of-scope information
    {p_end}
{synopt :{opt out(outname)}}store out-of-scope indicator
    {p_end}
{synopt :{opt fast}}do not restore data on error or break if {cmd:expandok} is specified
    {p_end}
{synopt :{opt r:eplace}}allow overwriting existing variables
    {p_end}
{synoptline}

{synoptset 26}{...}
{marker lblopt}{...}
{synopt :{help crosswalk##lbloptions:{it:label_options}}}Description{p_end}
{synoptline}
{synopt :{opt name(lblname)}}provide a custom name for the value label
    {p_end}
{synopt :{opt mod:ify}}modify (rather than replace) existing value label
    {p_end}
{synopt :{opt min:imal}}only include labels for existing values
    {p_end}
{synoptline}

{synoptset 26}{...}
{marker fcn}{synopt :{it:fcn}()}Description{p_end}
{synoptset 26 tabbed}{...}
{synoptline}
{syntab :Scales for ISCO-08}
{synopt :{helpb _cwfcn_isco08_to_isei:isco08_to_isei()}}ISCO-08 to ISEI scores{p_end}
{synopt :{helpb _cwfcn_isco08_to_iseisps:isco08_to_iseisps()}}alternative to {cmd:isco08_to_isei()}{p_end}
{synopt :{helpb _cwfcn_isco08_to_siops:isco08_to_siops()}}ISCO-08 to SIOPS scores;
    {helpb _cwfcn_isco08_to_treiman:isco08_to_treiman()} is a synonym{p_end}
{synopt :{helpb _cwfcn_isco08_to_oep:isco08_to_oep()}}ISCO-08 to OEP scores; also see{break}
    {helpb _cwfcn_isco08_3_to_oep:isco08_3_to_oep()}{break}
    {helpb _cwfcn_isco08_2_to_oep:isco08_2_to_oep()}{break}
    {helpb _cwfcn_isco08_1_to_oep:isco08_1_to_oep()}{p_end}
{synopt :{helpb _cwfcn_isco08_to_esec:isco08_to_esec()}}ISCO-08 to ESEC classes; also see{break}
    {helpb _cwfcn_isco08_3_to_esec:isco08_3_to_esec()}{p_end}
{synopt :{helpb _cwfcn_isco08_to_oesch:isco08_to_oesch()}}ISCO-08 to OESCH classes; also see{break}
    {helpb _cwfcn_isco08_to_oesch8:isco08_to_oesch8()}{break}
    {helpb _cwfcn_isco08_to_oesch5:isco08_to_oesch5()}{break}
    {helpb _cwfcn_oesch_to_oesch8:oesch_to_oesch8()}{break}
    {helpb _cwfcn_oesch_to_oesch5:oesch_to_oesch5()}{p_end}

{syntab :Scales for ISCO-88}
{synopt :{helpb _cwfcn_isco88_to_isei:isco88_to_isei()}}ISCO-88 to ISEI scores{p_end}
{synopt :{helpb _cwfcn_isco88_to_siops:isco88_to_siops()}}ISCO-88 to SIOPS scores;
    {helpb _cwfcn_isco88_to_treiman:isco88_to_treiman()} is a synonym{p_end}
{synopt :{helpb _cwfcn_isco88_to_oep:isco88_to_oep()}}ISCO-88 to OEP scores; also see{break}
    {helpb _cwfcn_isco88_3_to_oep:isco88_3_to_oep()}{break}
    {helpb _cwfcn_isco88_2_to_oep:isco88_2_to_oep()}{break}
    {helpb _cwfcn_isco88_1_to_oep:isco88_1_to_oep()}{p_end}
{synopt :{helpb _cwfcn_isco88_to_mps:isco88_to_mps()}}ISCO-88 to MPS scores{p_end}
{synopt :{helpb _cwfcn_isco88_to_esec:isco88_to_esec()}}ISCO-88 to ESEC classes; also see{break}
    {helpb _cwfcn_isco88_3_to_esec:isco88_3_to_esec()}{p_end}
{synopt :{helpb _cwfcn_isco88_to_egp:isco88_to_egp()}}ISCO-88 to EGP classes; also see{break}
    {helpb _cwfcn_isco88_to_egp11:isco88_to_egp11()}{p_end}
{synopt :{helpb _cwfcn_isco88_to_oesch:isco88_to_oesch()}}ISCO-88 to OESCH classes; also see{break}
    {helpb _cwfcn_isco88_to_oesch8:isco88_to_oesch8()}{break}
    {helpb _cwfcn_isco88_to_oesch5:isco88_to_oesch5()}{break}
    {helpb _cwfcn_oesch_to_oesch8:oesch_to_oesch8()}{break}
    {helpb _cwfcn_oesch_to_oesch5:oesch_to_oesch5()}{p_end}

{syntab :Scales for ISCO-68}
{synopt :{helpb _cwfcn_isco68_to_isei:isco68_to_isei()}}ISCO-68 to ISEI scores{p_end}
{synopt :{helpb _cwfcn_isco68_to_siops:isco68_to_siops()}}ISCO-68 to SIOPS scores;
    {helpb _cwfcn_isco68_to_treiman:isco68_to_treiman()} is a synonym{p_end}
{synopt :{helpb _cwfcn_isco68_to_egp:isco68_to_egp()}}ISCO-68 to EGP classes; also see{break}
    {helpb _cwfcn_isco68_to_egp11:isco68_to_egp11()}{p_end}

{syntab :Translation (unique)}
{synopt :{helpb _cwfcn_isco08_to_isco88:isco08_to_isco88()}}ISCO-08 to ISCO-88{p_end}
{synopt :{helpb _cwfcn_isco88_to_isco08:isco88_to_isco08()}}ISCO-88 to ISCO-08{p_end}
{synopt :{helpb _cwfcn_isco88_to_isco88com:isco88_to_isco88com()}}ISCO-88 to ISCO-88(COM){p_end}
{synopt :{helpb _cwfcn_isco88_to_isco68:isco88_to_isco68()}}ISCO-88 to ISCO-68{p_end}
{synopt :{helpb _cwfcn_isco68_to_isco88:isco68_to_isco88()}}ISCO-68 to ISCO-88{p_end}
{synopt :{helpb _cwfcn_isco68_to_isco08:isco68_to_isco08()}}ISCO-68 to ISCO-08{p_end}

{syntab :Translation (many-to-many)}
{synopt :{helpb _cwfcn_ilo_isco08_to_isco88:ilo_isco08_to_isco88()}}ISCO-08 to ISCO-88 (non-unique); also see{break}
    {helpb _cwfcn_ilo_isco88_to_isco08:ilo_isco88_to_isco08()}{p_end}
{synopt :{helpb _cwfcn_isco08_to_soc10:isco08_to_soc10()}}ISCO-08 to 2010 SOC (non-unique); also see{break}
    {helpb _cwfcn_soc10_to_isco08:soc10_to_isco08()}{p_end}
{synopt :{helpb _cwfcn_isco88_to_soc00:isco88_to_soc00()}}ISCO-88 to 2000 SOC (non-unique); also see{break}
    {helpb _cwfcn_soc00_to_isco88:soc00_to_isco88()}{p_end}
{synopt :{helpb _cwfcn_soc10_to_soc18:soc10_to_soc18()}}2010 SOC to 2018 SOC (non-unique); also see{break}
    {helpb _cwfcn_soc18_to_soc10:soc18_to_soc10()}{p_end}
{synopt :{helpb _cwfcn_soc00_to_soc10:soc00_to_soc10()}}2000 SOC to 2010 SOC (non-unique); also see{break}
    {helpb _cwfcn_soc10_to_soc00:soc10_to_soc00()}{p_end}

{syntab :Aggregation}
{synopt :{helpb _cwfcn_isco08_to_isco08_3:isco08_to_isco08_3()}}4-digit to 3-digit ISCO-08; also see{break}
    {helpb _cwfcn_isco08_to_isco08_2:isco08_to_isco08_2()}{break}
    {helpb _cwfcn_isco08_to_isco08_1:isco08_to_isco08_1()}{break}
    {helpb _cwfcn_isco08_3_to_isco08_2:isco08_3_to_isco08_2()}{break}
    {helpb _cwfcn_isco08_3_to_isco08_1:isco08_3_to_isco08_1()}{break}
    {helpb _cwfcn_isco08_2_to_isco08_1:isco08_2_to_isco08_1()}{p_end}
{synopt :{helpb _cwfcn_isco88_to_isco88_3:isco88_to_isco88_3()}}4-digit to 3-digit ISCO-88; also see{break}
    {helpb _cwfcn_isco88_to_isco88_2:isco88_to_isco88_2()}{break}
    {helpb _cwfcn_isco88_to_isco88_1:isco88_to_isco88_1()}{break}
    {helpb _cwfcn_isco88_3_to_isco88_2:isco88_3_to_isco88_2()}{break}
    {helpb _cwfcn_isco88_3_to_isco88_1:isco88_3_to_isco88_1()}{break}
    {helpb _cwfcn_isco88_2_to_isco88_1:isco88_2_to_isco88_1()}{p_end}

{syntab :Other}
{synopt :{space 0}{help crosswalk##cwtable:{it:myname}{bf:()}}}custom crosswalk table{p_end}
{synoptline}

{synoptset 26}{...}
{marker casefcn}{synopt :{it:casefcn}()}Description{p_end}
{synoptline}
{synopt :{helpb _cwcasefcn_egp:case.egp()}}EGP case function for ISCO-88{p_end}
{synopt :{helpb _cwcasefcn_egp68:case.egp68()}}EGP case function for ISCO-68{p_end}
{synopt :{helpb _cwcasefcn_esec:case.esec()}}ESEC case function for ISCO-08{p_end}
{synopt :{helpb _cwcasefcn_esec:case.esec88()}}ESEC case function for ISCO-88{p_end}
{synopt :{helpb _cwcasefcn_oesch:case.oesch()}}OESCH case function{p_end}
{synopt :{help crosswalk##cwcasefun:{bf:case.}{it:myname}{bf:()}}}custom case function{p_end}
{synoptline}

{synoptset 26}{...}
{marker lblset}{synopthdr:lblset}
{synoptline}
{synopt :{helpb _cwfcn_labels_egp:egp}}EGP labels; also see
    {helpb _cwfcn_labels_egp11:egp11}{p_end}
{synopt :{helpb _cwfcn_labels_esec:esec}}ESeC labels{p_end}
{synopt :{helpb _cwfcn_labels_oesch:oesch}}OESCH labels; also see
    {helpb _cwfcn_labels_oesch8:oesch8},
    {helpb _cwfcn_labels_oesch5:oesch5}{p_end}
{synopt :{helpb _cwfcn_labels_isco08:isco08}}ISCO-08 labels; also see
    {helpb _cwfcn_labels_isco08_3:isco08_3},
    {helpb _cwfcn_labels_isco08_2:isco08_2},
    {helpb _cwfcn_labels_isco08_1:isco08_1}{p_end}
{synopt :{helpb _cwfcn_labels_isco88:isco88}}ISCO-88 labels; also see
    {helpb _cwfcn_labels_isco88_3:isco88_3},
    {helpb _cwfcn_labels_isco88_2:isco88_2},
    {helpb _cwfcn_labels_isco88_1:isco88_1}{p_end}
{synopt :{helpb _cwfcn_labels_isco88com:isco88com}}ISCO-88(COM) labels; also see
    {helpb _cwfcn_labels_isco88com_3:isco88com_3},
    {helpb _cwfcn_labels_isco88com_2:isco88com_2},
    {helpb _cwfcn_labels_isco88com_1:isco88com_1}{p_end}
{synopt :{helpb _cwfcn_labels_isco88a:isco88a}}ISCO-88 labels by Ganzeboom/Treiman; also see
    {helpb _cwfcn_labels_isco88b:isco88b}{p_end}
{synopt :{helpb _cwfcn_labels_isco68:isco68}}ISCO-68 labels{p_end}
{synopt :{helpb _cwfcn_labels_soc18:soc18}}2018 SOC labels{p_end}
{synopt :{helpb _cwfcn_labels_soc10:soc10}}2010 SOC labels{p_end}
{synopt :{helpb _cwfcn_labels_soc00:soc00}}2000 SOC labels{p_end}
{synopt :{help crosswalk##cwlblset:{it:myname}}}custom label set{p_end}
{synoptline}


{marker description}{...}
{title:Description}

{pstd}
    {cmd:crosswalk} applies fast table-based recoding. Pre-defined
    crosswalk tables are provided for common recoding tasks related to occupational
    classifications. See {help crosswalk##cwtable:below} on how to define
    custom crosswalk tables.

{pstd}
    {cmd:crosswalk} works via indexing or hash tables, depending on type of
    data. The heavy lifting is done by Mata function
    {helpb mf_mm_crosswalk:mm_crosswalk()} from the {helpb moremata} package
    (Jann 2005), which needs to be installed on the system (see
    {net "describe moremata, from(http://fmwww.bc.edu/RePEc/bocode/m)":ssc describe moremata}).

{pstd}
    {cmd:crosswalk} supersedes command {helpb iscogen} (Jann 2019).


{marker options}{...}
{title:Options}

{marker opts}{...}
{dlgtab:Main options}

{marker expandok}{...}
{phang}
    {cmd:expandok} allows the crosswalk table to contain duplicate origin values
    and adds observations to the dataset if needed. By default, {cmd:crosswalk}
    requires the origin values in the crosswalk table to be unique, such that
    each value of {it:varname} only has a single match in the crosswalk table
    (one-to-one or one-to-many crosswalk). Specify {cmd:expandok} to allow duplicate origin
    values (many-to-one or many-to-many crosswalk). In this case, if an observation has
    multiple matches in the crosswalk table, copies of the observation will be
    added to the data, one for each match (similar to forming pairwise
    combinations using {helpb joinby}).

{phang}
    {cmd:missing} treats missing values like other values. The default is
    to exclude missing values from the evaluated subsample. Only one of
    {cmd:missing} and {cmd:copymissing} is allowed.

{phang}
    {cmd:copyrest}[{cmd:(}{cmdab:nol:abel}{cmd:)}] copies values that are
    out of scope into the generated variable (within the subsample
    selected by {it:{help if}} and {it:{help in}}). By default, the generated
    variable will be set to missing for observation without match in the
    crosswalk table. Specify {cmd:copyrest} to retain the original values for
    these observations rather than setting the variable to missing. Unless
    argument {cmd:nolabel} is specified,
    {cmd:copyrest} also copies all value labels from {it:varname}
    to the generated variable (but note that individual labels may subsequently
    be overwritten by labels obtained from {it:lblset}). {cmd:copyrest}
    implies {cmd:copymissing} unless {cmd:missing} is
    specified or the source variable is string. Furthermore, {cmd:copymissing}
    implies {cmd:string} or {cmd:numeric} depending on the data type of the
    source variable.

{phang}
    {cmd:copymissing}[{cmd:(}{cmdab:nol:abel}{cmd:)}] copies extended missing
    values into the generated variable (within the subsample selected by {it:{help if}}
    and {it:{help in}}). Specify {cmd:copymissing} if the source variable has extended
    missing values that you want to pass through to the generated variable;
    value labels of extended missings will also be copied, unless argument
    {cmd:nolabel} is specified. {cmd:copymissing} implies {cmd:numeric} and
    is only allowed if the source variable is numeric. Only one of
    {cmd:missing} and {cmd:copymissing} is allowed. Only one of {cmd:copyrest}
    and {cmd:copymissing} is allowed.

{phang}
    {cmd:label(}[{it:lblset}][{cmd:,} {opt minimal}]{cmd:)} specifies a
    {help crosswalk##lblset:{it:lblset}} to be used for the value labels. By default,
    when applying function {it:origin}{cmd:_to_}{it:destination}{cmd:()},
    the {it:lblset} called {it:destination} will be used, if such a
    set exists. Suboption {cmd:minimal} requests that only values be labeled
    that exist in the data; the default is to include all defined
    labels. {cmd:label()} has no effect if the generated variable is
    string. Specify {cmd:nolabel} to omit the automatic assignment of value
    labels.

{phang}
    {cmd:string} enforces string format for the generated variable. The default
    is to use a numeric format as long as all destination values in the
    crosswalk table are numeric.

{phang}
    {cmd:numeric} enforces numeric format for the generated variable even if
    there are nonnumeric destination values. Only one of {cmd:string} and
    {cmd:numeric} is allowed.

{phang}
    {cmd:noinfo} omits the information on levels of {it:varname} that are out
    of scope (i.e., levels of {it:varname} that have no match in the crosswalk
    table). This saves some computer time.

{phang}
    {opt out(outname)} adds an out-of-scope indicator to the data (1 if
    no match in the crosswalk table, else 0; missing if outside of
    the evaluated subsample).

{phang}
    {cmd:fast} does not restore the original dataset if {cmd:expandok} has been
    specified and there is an error or the user presses {cmd:Break}. This saves
    memory and some computer time. {cmd:fast} has no effect if {cmd:expandok} is omitted.

{phang}
    {cmd:replace} allows overwriting an existing variable.

{marker lbloptions}{...}
{dlgtab:Options for crosswalk label}

{phang}
    {opt name(lblname)} provides a custom name for the value
    label. By default, a separate set of labels is assigned to each variable
    using the name of the variable as the name of the value label. Specify option
    {cmd:name()} to use a common set across all variables. If {cmd:name()} is
    omitted and {it:varlist} is empty, a single set called {it:lblset} will
    be created.

{phang}
    {cmd:modify} causes existing value labels to be modified rather than replaced.

{phang}
    {cmd:minimal} equests that only values be labeled that exist in the data. The default is to
    include all defined labels. {cmd:minimal} is only allowed if {it:varlist} is specified.


{marker remarks}{...}
{title:Remarks}

        {help crosswalk##case:The case argument}
        {help crosswalk##cwtable:Custom crosswalk tables}
        {help crosswalk##cwcasefun:Custom case functions}
        {help crosswalk##cwlblset:Custom label sets}
        {help crosswalk##manipulate:Manipulate existing crosswalk table}

{marker case}{...}
{dlgtab:The case argumment}

{pstd}
    Some crosswalk tables contain multiple destination columns,
    each representing a specific case. Use argument {it:case} in
    {help crosswalk##fcn:{it:fcn}}{cmd:(}{it:varname} {it:case}{cmd:)} to
    select the destination column. Argument {it:case} may be one of the following.

{p2colset 9 29 29 2}{...}
{p2col:{it:casevar}}a numeric variable indicating the destination column of each observation (1 for the first
    destination column, 2 for the second destination column, etc.)
    {p_end}
{p2col:{it:{help exp}}}an expression, possibly involving multiple variables{p_end}
{p2col:{help crosswalk##casefcn:{it:casefcn}}{cmd:(}{it:arguments}{cmd:)}}a special-purpose function
determining the destination column{p_end}

{pstd}
    For example, the translation of ISCO-88 codes into EGP classes depends on
    employment status and supervisory function. See the documentation of
    {helpb _cwfcn_isco88_to_egp:isco88_to_egp()} for detailed information. You could use you own code to
    construct a variable, say {cmd:egpcase}, indicating the appropriate combination
    of employment status and supervisory function for each observation
    (1 = employee without subordinates, 2 = employee with 1 subordinate, etc.),
    and then specify

{p 8 8 2}
. {cmd:crosswalk} {it:newvar} {cmd:=} {cmd:isco88_to_egp(}{it:varname} {cmd:egpcase)}

{pstd}
    Alternatively, use pre-defined case function
    {helpb _cwcasefcn_egp:case.egp()} as in

{p 8 8 2}
. {cmd:crosswalk} {cmd:egpcase =} {cmd:case.egp(}{it:sempl} {it:supvis}{cmd:)}{p_end}
{p 8 8 2}
. {cmd:crosswalk} {it:newvar} {cmd:=} {cmd:isco88_to_egp(}{it:varname} {cmd:egpcase))}

{pstd}
    or, equivalently, in

{p 8 8 2}
. {cmd:crosswalk} {it:newvar} {cmd:=} {cmd:isco88_to_egp(}{it:varname} {cmd:case.egp(}{it:sempl} {it:supvis}{cmd:))}

{pstd}
    where {it:sempl} contains the employment status (0 = employed, 1 = self-employed)
    and {it:supvis} contains the number of subordinates or employees.

{pstd}
    Argument {it:case} will be ignored by crosswalk tables that only have a
    single destination column.

{marker cwtable}{...}
{dlgtab:Custom crosswalk tables}

{pstd}
    Custom crosswalk tables can be defined on the fly using {cmd:crosswalk define},
    or be provided permanently as files on disk (in the working directory or
    somewhere else along the {helpb adopath}). For example, you could type

        {com}. crosswalk define myrecode()
         1  3
         2  2
         3  1
        .a .b
        end{txt}

{pstd}
    and then used the defined crosswalk table as follows:

        {com}. crosswalk Y = myrecode(X), missing{txt}

{pstd}
    Each line after {cmd:crosswalk define} specifies a recoding rule consisting of
    an origin value followed by a destination value (or several destination values;
    see the {help crosswalk##case:{it:case}} argument). Empty lines are
    not allowed, and the input must be terminated by keyword {cmd:end}.

{pstd}
    Alternatively, you could make {cmd:myrecode()} available by
    storing

         1  3
         2  2
         3  1
        .a .b

{pstd}
    in file {cmd:_cwfcn_myrecode.sthlp} in the working directory. The syntax of
    crosswalk files is as follows.

{phang}
    {space 2}o Each line defines a recoding rule consisting of an origin value
    followed by one or several destination values. The values must be
    space-separated.
    {p_end}
{phang}
    {space 2}o Values containing spaces must be enclosed in single quotes ('...'),
    double quotes ("..."), or compound double quotes (`"..."').
    {p_end}
{phang}
    {space 2}o Empty lines and lines starting with {cmd:*} will be ignored.
    {p_end}
{phang}
    {space 2}o Line {cmd:{smcl}} starts an SMCL formatted
    section that will be ignored. Line {cmd:{asis}} ends the SMCL section.
    {p_end}
{phang}
    {space 2}o The filename must start with prefix {cmd:_cwfcn_} and end with
    suffix {cmd:.sthlp}.
    {p_end}

{pstd}
    A crosswalk table can also be implemented as a wrapper for
    one or several other crosswalk tables (only one wrapper level is
    allowed; that is, wrappers cannot call wrappers). Within a wrapper, use
    alias syntax {cmd:.}{it:fcn}[{cmd:(}{it:#}{cmd:)}] to call crosswalk table
    {it:fcn}{cmd:()} (and take origin values from column {it:#}; default
    is 1). For example, the definition of
    {helpb _cwfcn_isco08_to_esec:isco08_to_esec()} is

        {com}. crosswalk define isco08_to_esec()
        .isco08_to_isco08_3
        .isco08_3_to_esec
        end{txt}

{pstd}
    This means that {cmd:isco08_to_esec()} first calls
    {helpb _cwfcn_isco08_to_isco08_3:isco08_to_isco08_3()}
    to translate 4-digit ISCO-08 to 3-digit ISCO-08, and then
    {helpb _cwfcn_isco08_3_to_esec:isco08_3_to_esec()} to translate
    3-digit ISCO-08 to ESeC.

{marker cwcasefun}{...}
{dlgtab:Custom case functions}

{pstd}
    A custom {help crosswalk##case:case function} called {cmd:case.}{it:myname}{cmd:()}
    can be provided by storing file {cmd:_cwcasefcn_}{it:myname}{cmd:.sthlp}
    in the working directory or somewhere else along the {helpb adopath}. Similar
    to a {help crosswalk##cwtable:crosswalk table}, the file may contain SMCL
    sections that will be ignored. Apart from that, the file is assumed to contain
    Stata code that will be called by {cmd:crosswalk} using command {helpb run}. The following
    arguments are passed through: the name of the variable to be
    generated, the name of the variable marking the evaluated subsample,
    any other {it:arguments} specified by the user.

{marker cwlblset}{...}
{dlgtab:Custom label sets}

{pstd}
    Label sets have the same format as crosswalk tables, but their name must start
    with {cmd:labels_}. For example, type

        {com}. crosswalk define labels_myrecode
         3 "New three (was 1)"
         2 "Two (did not change)"
         1 "New one (was 3)"
        .b "New missing (was .a)"
        end{txt}

{pstd}
    to provide label set {cmd:myrecode}. You could then use it together with
    crosswalk table {cmd:myrecode()} defined {help crosswalk##cwtable:above} about as follows:

        {com}. crosswalk Y = myrecode(X), missing label(myrecode){txt}

{pstd}
    Hint: Use name {cmd:labels_}{it:destination} if you want to provide labels that will be
    picked up automatically by crosswalk table
    {it:origin}{cmd:_to_}{it:destination}{cmd:()}.

{marker manipulate}{...}
{dlgtab:Manipulate existing crosswalk table}

{pstd}
    Many-to-many crosswalk table {helpb _cwfcn_ilo_isco08_to_isco88:ilo_isco08_to_isco88()}
    is defined at the unit-group level (4-digit) only. That is, the table assigns one
    or several ISCO-88 unit groups to each ISCO-08 unit group. Empirical data,
    however, often also contain 4-digit variants of codes for major, sub-major,
    or minor groups (i.e., 1, 2, or 3-digits codes padded with zeros on the
    right), because sometimes there is not enough information to code an
    observation at the unit-group level. When applying {cmd:ilo_isco08_to_isco88()}
    these codes will be left without match. An approach to solve this issue, is to take
    the original crosswalk table, truncate all origin and destination codes to
    3 digits, remove duplicates, and then add a trailing zero back in to each
    code. The resulting table assigns one or several ISCO-88 minor groups to
    each ISCO-08 minor group (using 4-digit variants of the codes). Correspondence
    tables for major (1-digit) and sub-major (2-digit) groups can be constructed
    analogously. We can then append these tables to the original
    table (skipping origin codes that may already exist in the original
    table) to obtain a many-to-many crosswalk that covers all four levels at
    the same time.

{pstd}
    Illustrating the use of commands {cmd:crosswalk import} and
    {cmd:crosswalk post}, the described procedure could be implemented about
    as follows:

        // import original crosswalk table
        {com}crosswalk import ilo_isco08_to_isco88(){txt}
        // generate unique ID
        {com}generate _id = _n{txt}
        // replace each original row by 4 copies
        {com}expand 4{txt}
        // assign a number of digits (1, 2, 3, or 4) to each copy
        {com}bysort _id: generate _digits = _n{txt}
        // repeat for 1, 2, or 3 digits
        {com}forv d = 1/3 {{txt}
            // number of trailing zeros in d-digit code
            {com}local r = 4 - `d'{txt}
            // drop observation if it already has r trailing zeros
            {com}drop if substr(v1,-`r',.)==(`r'*"0") & _digits==`d'{txt}
            // replace original values by d-digit codes with r trailing zeros
            {com}replace v1 = substr(v1,1,`d') + (`r'*"0") if _digits==`d'{txt}
            {com}replace v2 = substr(v2,1,`d') + (`r'*"0") if _digits==`d'{txt}
        {com}}{txt}
        // drop helper variables
        {com}drop _id _digits{txt}
        // drop duplicate rows
        {com}duplicates drop{txt}
        // sort data (optional)
        {com}sort v1 v2{txt}
        // post result as a custom crosswalk table
        {com}crosswalk post my_isco08_to_isco88(){txt}

{pstd}
    The new crosswalk table can then be used as {cmd:my_isco08_to_isco88()} in
    subsequent {cmd:crosswalk} commands in the same Stata session.
    Alternatively, if you want to make the new crosswalk table available
    permanently, use {cmd:crosswalk export} in the last step to save it to disk.

{pstd}
    Original {cmd:ilo_isco08_to_isco88()} is bi-directional and, consequently,
    {helpb _cwfcn_ilo_isco88_to_isco08:ilo_isco88_to_isco08()} is
    implemented as a wrapper for {cmd:ilo_isco08_to_isco88()}. For
    {cmd:my_isco08_to_isco88()}, bi-directionality no longer holds. To
    obtain the reverse translator, say {cmd:my_isco88_to_isco08()}, use the
    above code, but swap variables {cmd:v1} and {cmd:v2} after importing
    {cmd:ilo_isco08_to_isco88()}.


{marker examples}{...}
{title:Examples}

{pstd}
    Generate ISEI scores from ISCO-88 codes:

        {com}. crosswalk isei = isco88_to_isei(job){txt}

{pstd}
    Translate ISCO-88 to ISCO-08:

        {com}. crosswalk job08 = isco88_to_isco08(job){txt}

{pstd}
    Translate 4-digit ISCO-88 unit groups to 2-digit sub-major groups:

        {com}. crosswalk job_isco2 = isco88_to_isco88_2(job){txt}

{pstd}
    Generate EGP classes from ISCO-88 codes:

        {com}. crosswalk EGP = isco88_to_egp11(job case.egp(selfemp nemployees)){txt}

{pstd}
    Assign ISCO-88(COM) labels to existing variables:

        {com}. crosswalk label isco88com job_mother job_father{txt}


{marker stored}{...}
{title:Stored results}

{pstd}
    Command {cmd:crosswalk} {it:newvar} {cmd:=} {it:fcn}{cmd:()} stores the
    following results in {cmd:r()}.

      Scalars:
{p2colset 7 22 22 2}{...}
{p2col : {cmd:r(string)}}{cmd:1} if the generated variable is string, else {cmd:0}{p_end}
{p2col : {cmd:r(r_out)}}number of levels of {it:varname} that are out of scope; only if {cmd:noinfo} is not specified{p_end}
{p2col : {cmd:r(N_add)}}number of added observations; only if {cmd:expandok} is specified{p_end}

      Macros:
{p2col : {cmd:r(fcn)}}name of applied {help crosswalk##fcn:{it:fcn}()}{p_end}
{p2col : {cmd:r(fn)}}filename of applied {help crosswalk##fcn:{it:fcn}()} (empty if from memory){p_end}
{p2col : {cmd:r(lblset)}}name of applied {help crosswalk##lblset:{it:lblset}}{p_end}
{p2col : {cmd:r(fn_lblset)}}filename of applied {help crosswalk##lblset:{it:lblset}} (empty if from memory){p_end}
{p2col : {cmd:r(newvar)}}name of generated variable{p_end}
{p2col : {cmd:r(varname)}}name of source variable{p_end}
{p2col : {cmd:r(case)}}{help crosswalk##case:{it:case}} specification{p_end}
{p2col : {cmd:r(fn_casefcn)}}filename of applied {help crosswalk##casefcn:{it:casefcn}()} (or empty){p_end}
{p2col : {cmd:r(levels_out)}}list of levels of {it:varname} that are out of scope; only if {cmd:noinfo} is not specified{p_end}

{pstd}
    Command {cmd:crosswalk} {it:newvar} {cmd:=} {it:casefcn}{cmd:()} stores the
    following macros in {cmd:r()}.

{p2col : {cmd:r(casefcn)}}name of applied {help crosswalk##casefcn:{it:casefcn}()}{p_end}
{p2col : {cmd:r(fn_casefcn)}}filename of applied {help crosswalk##casefcn:{it:casefcn}()}{p_end}
{p2col : {cmd:r(newvar)}}name of generated variable{p_end}

{pstd}
    Command {cmd:crosswalk label} stores the following macros in {cmd:r()}.

{p2col : {cmd:r(lblset)}}name of applied {help crosswalk##lblset:{it:lblset}}{p_end}
{p2col : {cmd:r(fn_lblset)}}filename of applied {help crosswalk##lblset:{it:lblset}} (empty if from memory){p_end}
{p2col : {cmd:r(lbname)}}name(s) used for the value labels{p_end}
{p2col : {cmd:r(varlist)}}specified variables{p_end}

{pstd}
    Command {cmd:crosswalk define} stores the name of the defined
    function in macro {cmd:r(fcn)}.

{pstd}
    Command {cmd:crosswalk save} stores the name of the saved function in macro
    {cmd:r(fcn)} and the used filename in macro {cmd:r(fn)}.

{pstd}
    Command {cmd:crosswalk dir} stores the number of functions in scalar {cmd:r(n)}
    and a space separated list of the function names in macro {cmd:r(fcns)}.

{pstd}
    Command {cmd:crosswalk list} stores the length of the function (number of rows)
    in scalar {cmd:r(r)} and the filename of the function in macro {cmd:r(fn)}
    (empty if from memory).

{pstd}
    Command {cmd:crosswalk import} stores the filename of the imported function
    in macro {cmd:r(fn)} (empty if from memory) and
    passes through all stored results from {helpb describe} applied to the
    imported data.

{pstd}
    Command {cmd:crosswalk post} stores the name of the posted function in macro
    {cmd:r(fcn)}.

{pstd}
    Command {cmd:crosswalk export} stores the name of the saved function in macro
    {cmd:r(fcn)} and the used filename in macro {cmd:r(fn)}.


{marker references}{...}
{title:References}

{phang}
    Jann, B. 2005. moremata: Stata module (Mata) to provide various functions. Available
    from {browse "https://ideas.repec.org/c/boc/bocode/s455001.html"}.
    {p_end}
{phang}
    Jann, B. 2019. iscogen: Stata module to translate ISCO codes. Available from
    {browse "https://ideas.repec.org/c/boc/bocode/s458665.html"}.
    {p_end}


{marker author}{...}
{title:Author}

{pstd}
    Ben Jann, University of Bern, ben.jann@unibe.ch

{pstd}
    Thanks for citing this software as follows:

{pmore}
    Jann, B. 2025. crosswalk: Stata module to recode variable based on
    crosswalk table (bulk recoding). Available from
    {browse "https://ideas.repec.org/c/boc/bocode/s459420.html"}.


{marker alsosee}{...}
{title:Also see}

{psee}
    Online:  help for
    {helpb recode}, {helpb label}, {helpb merge}, {helpb joinby},
    {helpb moremata}
