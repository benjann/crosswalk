<pre id="stlog-1" class="sthlp"><b>help crosswalk</b>                                    https://github.com/benjann/crosswalk/
---------------------------------------------------------------------------------------

<b><u>Title</u></b>

    <b>crosswalk</b> -- Recode variable based on crosswalk table (bulk recoding)


<a name="syntax"></a><b><u>Syntax</u></b>

    Main command: recode a variable using crosswalk table <i>fcn</i><b>()</b>

        <b>crosswalk</b> <a href="http://www.stata.com/help.cgi?newvar"><i>newvar</i></a> <b>=</b> <a href="#fcn"><i>fcn</i></a><b>(</b><i>varname</i> [<a href="#case"><i>case</i></a>]<b>)</b> [<a href="http://www.stata.com/help.cgi?if"><i>if</i></a>] [<a href="http://www.stata.com/help.cgi?in"><i>in</i></a>] [<b>,</b> <a href="#opt"><i>options</i></a> ]

    Utilities:

    o Generate <a href="#case"><i>case</i></a> indicator

        <b>crosswalk</b> <a href="http://www.stata.com/help.cgi?newvar"><i>newvar</i></a> <b>=</b> <a href="#casefcn"><i>casefcn</i></a><b>(</b><i>arguments</i><b>)</b> [<a href="http://www.stata.com/help.cgi?if"><i>if</i></a>] [<a href="http://www.stata.com/help.cgi?in"><i>in</i></a>] [<b>,</b> <b><u>r</u></b><b>eplace</b> ]

    o Assign value labels (to existing variables)

        <b>crosswalk</b> <b><u>l</u></b><b>abel</b> <a href="#lblset"><i>lblset</i></a> [<a href="http://www.stata.com/help.cgi?varlist"><i>varlist</i></a>] [<b>,</b> <a href="#lblopt"><i>label_options</i></a> ]

    o Define and manage <a href="#cwtable">custom crosswalk tables</a> in memory

        <b>crosswalk</b> <b><u>d</u></b><b>efine</b> <i>fcn</i>[<b>()</b>]
        <i>&lt;line 1&gt;</i>
        <i>&lt;line 2&gt;</i>
        <i>...</i>
        <b>end</b>

      defines custom crosswalk table <i>fcn</i><b>()</b> in memory. Crosswalk tables in memory take
      precedence over crosswalk tables on disk. However, note that names of crosswalk
      tables in memory are case sensitive, whereas names of crosswalk tables on disk
      are typically not.

        <b>crosswalk</b> <b>drop</b> <i>fcn</i>[<b>()</b>]

      deletes custom crosswalk table <i>fcn</i><b>()</b> from memory.

        <b>crosswalk</b> <b>save</b> <i>fcn</i>[<b>()</b>] [<b>,</b> <b><u>r</u></b><b>eplace</b> <b>path(</b><i>path</i><b>)</b> ]

      stores custom crosswalk table <i>fcn</i><b>()</b> in a file on disk, to make it permanently
      available. Option <b>replace</b> allows overwriting an existing file; <b>path()</b> specifies
      a destination directory.

        <b>crosswalk</b> <b><u>di</u></b><b>r</b>

      lists the names of all crosswalk tables that are currently defined in memory.

        <b>crosswalk</b> <b>clear</b>

      deletes all crosswalk tables that are currently defined in memory.

    o List the contents of a crosswalk table (from disk or memory) in the results
      window

        <b>crosswalk</b> <b>list</b> <i>fcn</i>[<b>()</b>]

    o Manipulate an existing crosswalk table

        <b>crosswalk</b> <b>import</b> <i>fcn</i>[<b>()</b>] [<b>,</b> <b>clear</b> ]

      imports the contents of crosswalk table <i>fcn</i><b>()</b> (be it from memory or from disk)
      into the (current) data frame, so that it can be modified using Stata's <a href="http://www.stata.com/help.cgi?data_management">data</a>
      <a href="http://www.stata.com/help.cgi?data_management">management</a> commands. Option <b>clear</b> allows replacing the current data even though
      it has not been saved. Each column of the crosswalk table will be imported as a
      separate string variable. Use command <a href="http://www.stata.com/help.cgi?destring"><b>destring</b></a> to convert variables to numeric
      format if needed.

        <b>crosswalk</b> <b>post</b> <i>fcn</i>[<b>()</b>]

      posts the contents of the (current) data frame as crosswalk table <i>fcn</i><b>()</b> in
      memory. Use this command after <b>crosswalk import</b> to make the imported and
      possibly modified data available as a custom crosswalk table in memory. Numeric
      variables will be converted to string using their <a href="http://www.stata.com/help.cgi?format">display format</a>.

        <b>crosswalk</b> <b>export</b> <i>fcn</i>[<b>()</b>] [<b>,</b> <b><u>r</u></b><b>eplace</b> <b>path(</b><i>path</i><b>)</b> ]

      stores the contents of the (current) data frame as crosswalk table <i>fcn</i><b>()</b> in a
      file on disk. Use this command after <b>crosswalk import</b> to make the imported and
      possibly modified data permanently available as a new crosswalk table on disk.
      Numeric variables will be converted to string using their <a href="http://www.stata.com/help.cgi?format">display format</a>.
      Option <b>replace</b> allows overwriting an existing file; <b>path()</b> specifies a
      destination directory.


<a name="opt"></a>    <a href="#opts"><i>options</i></a>                     Description
    ---------------------------------------------------------------------------------
    <b><u>expand</u></b><b>ok</b>                    allow non-unique crosswalk table and expand data if
                                  needed
    <b><u>mis</u></b><b>sing</b>                     treat missing values like other values
    <b><u>copy</u></b><b>rest</b>[<b>(</b><b><u>nol</u></b><b>abel)</b>]         retain values that are not matched
    <b><u>copymis</u></b><b>sing</b>[<b>(</b><b><u>nol</u></b><b>abel)</b>]      copy extended missing values
    <b><u>l</u></b><b>abel(</b>[<a href="#lblset"><i>lblset</i></a>][<b>,</b> <b><u>min</u></b><b>imal</b>]<b>)</b>  assign custom value labels
    <b><u>nol</u></b><b>abel</b>                     omit automatic value labels
    <b><u>str</u></b><b>ing</b>                      enforce string format
    <b><u>num</u></b><b>eric</b>                     enforce numeric format
    <b>noinfo</b>                      omit information on values that are not matched
    <b>out(</b><i>outname</i><b>)</b>                tag observations that are not matched
    <b>fast</b>                        do not restore data on error or break if <b>expandok</b> is
                                  specified
    <b><u>r</u></b><b>eplace</b>                     allow overwriting existing variables
    ---------------------------------------------------------------------------------

<a name="lblopt"></a>    <a href="#lbloptions"><i>label_options</i></a>               Description
    ---------------------------------------------------------------------------------
    <b>name(</b><i>lblname</i><b>)</b>               provide a custom name for the value label
    <b><u>mod</u></b><b>ify</b>                      modify (rather than replace) existing value label
    <b><u>min</u></b><b>imal</b>                     only include labels for existing values
    ---------------------------------------------------------------------------------

<a name="fcn"></a>    <i>fcn</i>()                       Description
    ---------------------------------------------------------------------------------
    Scales for ISCO-08
      <a href="http://www.stata.com/help.cgi?_cwfcn_isco08_to_isei"><b>isco08_to_isei()</b></a>          ISCO-08 to ISEI scores
      <a href="http://www.stata.com/help.cgi?_cwfcn_isco08_to_iseisps"><b>isco08_to_iseisps()</b></a>       alternative to <b>isco08_to_isei()</b>
      <a href="http://www.stata.com/help.cgi?_cwfcn_isco08_to_siops"><b>isco08_to_siops()</b></a>         ISCO-08 to SIOPS scores; <a href="http://www.stata.com/help.cgi?_cwfcn_isco08_to_treiman"><b>isco08_to_treiman()</b></a> is a
                                  synonym
      <a href="http://www.stata.com/help.cgi?_cwfcn_isco08_to_oep"><b>isco08_to_oep()</b></a>           ISCO-08 to OEP scores; also see
                                  <a href="http://www.stata.com/help.cgi?_cwfcn_isco08_3_to_oep"><b>isco08_3_to_oep()</b></a>
                                  <a href="http://www.stata.com/help.cgi?_cwfcn_isco08_2_to_oep"><b>isco08_2_to_oep()</b></a>
                                  <a href="http://www.stata.com/help.cgi?_cwfcn_isco08_1_to_oep"><b>isco08_1_to_oep()</b></a>
      <a href="http://www.stata.com/help.cgi?_cwfcn_isco08_to_esec"><b>isco08_to_esec()</b></a>          ISCO-08 to ESEC classes; also see
                                  <a href="http://www.stata.com/help.cgi?_cwfcn_isco08_3_to_esec"><b>isco08_3_to_esec()</b></a>
      <a href="http://www.stata.com/help.cgi?_cwfcn_isco08_to_oesch"><b>isco08_to_oesch()</b></a>         ISCO-08 to OESCH classes; also see
                                  <a href="http://www.stata.com/help.cgi?_cwfcn_isco08_to_oesch8"><b>isco08_to_oesch8()</b></a>
                                  <a href="http://www.stata.com/help.cgi?_cwfcn_isco08_to_oesch5"><b>isco08_to_oesch5()</b></a>
                                  <a href="http://www.stata.com/help.cgi?_cwfcn_oesch_to_oesch8"><b>oesch_to_oesch8()</b></a>
                                  <a href="http://www.stata.com/help.cgi?_cwfcn_oesch_to_oesch5"><b>oesch_to_oesch5()</b></a>

    Scales for ISCO-88
      <a href="http://www.stata.com/help.cgi?_cwfcn_isco88_to_isei"><b>isco88_to_isei()</b></a>          ISCO-88 to ISEI scores
      <a href="http://www.stata.com/help.cgi?_cwfcn_isco88_to_siops"><b>isco88_to_siops()</b></a>         ISCO-88 to SIOPS scores; <a href="http://www.stata.com/help.cgi?_cwfcn_isco88_to_treiman"><b>isco88_to_treiman()</b></a> is a
                                  synonym
      <a href="http://www.stata.com/help.cgi?_cwfcn_isco88_to_oep"><b>isco88_to_oep()</b></a>           ISCO-88 to OEP scores; also see
                                  <a href="http://www.stata.com/help.cgi?_cwfcn_isco88_3_to_oep"><b>isco88_3_to_oep()</b></a>
                                  <a href="http://www.stata.com/help.cgi?_cwfcn_isco88_2_to_oep"><b>isco88_2_to_oep()</b></a>
                                  <a href="http://www.stata.com/help.cgi?_cwfcn_isco88_1_to_oep"><b>isco88_1_to_oep()</b></a>
      <a href="http://www.stata.com/help.cgi?_cwfcn_isco88_to_mps"><b>isco88_to_mps()</b></a>           ISCO-88 to MPS scores
      <a href="http://www.stata.com/help.cgi?_cwfcn_isco88_to_esec"><b>isco88_to_esec()</b></a>          ISCO-88 to ESEC classes; also see
                                  <a href="http://www.stata.com/help.cgi?_cwfcn_isco88_3_to_esec"><b>isco88_3_to_esec()</b></a>
      <a href="http://www.stata.com/help.cgi?_cwfcn_isco88_to_egp"><b>isco88_to_egp()</b></a>           ISCO-88 to EGP classes; also see
                                  <a href="http://www.stata.com/help.cgi?_cwfcn_isco88_to_egp11"><b>isco88_to_egp11()</b></a>
      <a href="http://www.stata.com/help.cgi?_cwfcn_isco88_to_oesch"><b>isco88_to_oesch()</b></a>         ISCO-88 to OESCH classes; also see
                                  <a href="http://www.stata.com/help.cgi?_cwfcn_isco88_to_oesch8"><b>isco88_to_oesch8()</b></a>
                                  <a href="http://www.stata.com/help.cgi?_cwfcn_isco88_to_oesch5"><b>isco88_to_oesch5()</b></a>
                                  <a href="http://www.stata.com/help.cgi?_cwfcn_oesch_to_oesch8"><b>oesch_to_oesch8()</b></a>
                                  <a href="http://www.stata.com/help.cgi?_cwfcn_oesch_to_oesch5"><b>oesch_to_oesch5()</b></a>

    Scales for ISCO-68
      <a href="http://www.stata.com/help.cgi?_cwfcn_isco68_to_isei"><b>isco68_to_isei()</b></a>          ISCO-68 to ISEI scores
      <a href="http://www.stata.com/help.cgi?_cwfcn_isco68_to_siops"><b>isco68_to_siops()</b></a>         ISCO-68 to SIOPS scores; <a href="http://www.stata.com/help.cgi?_cwfcn_isco68_to_treiman"><b>isco68_to_treiman()</b></a> is a
                                  synonym
      <a href="http://www.stata.com/help.cgi?_cwfcn_isco68_to_egp"><b>isco68_to_egp()</b></a>           ISCO-68 to EGP classes; also see
                                  <a href="http://www.stata.com/help.cgi?_cwfcn_isco68_to_egp11"><b>isco68_to_egp11()</b></a>

    Translation (unique)
      <a href="http://www.stata.com/help.cgi?_cwfcn_isco08_to_isco88"><b>isco08_to_isco88()</b></a>        ISCO-08 to ISCO-88
      <a href="http://www.stata.com/help.cgi?_cwfcn_isco88_to_isco08"><b>isco88_to_isco08()</b></a>        ISCO-88 to ISCO-08
      <a href="http://www.stata.com/help.cgi?_cwfcn_isco88_to_isco88com"><b>isco88_to_isco88com()</b></a>     ISCO-88 to ISCO-88(COM)
      <a href="http://www.stata.com/help.cgi?_cwfcn_isco88_to_isco68"><b>isco88_to_isco68()</b></a>        ISCO-88 to ISCO-68
      <a href="http://www.stata.com/help.cgi?_cwfcn_isco68_to_isco88"><b>isco68_to_isco88()</b></a>        ISCO-68 to ISCO-88
      <a href="http://www.stata.com/help.cgi?_cwfcn_isco68_to_isco08"><b>isco68_to_isco08()</b></a>        ISCO-68 to ISCO-08

    Translation (many-to-many)
      <a href="http://www.stata.com/help.cgi?_cwfcn_ilo_isco08_to_isco88"><b>ilo_isco08_to_isco88()</b></a>    ISCO-08 to ISCO-88 (non-unique); also see
                                  <a href="http://www.stata.com/help.cgi?_cwfcn_ilo_isco88_to_isco08"><b>ilo_isco88_to_isco08()</b></a>
      <a href="http://www.stata.com/help.cgi?_cwfcn_isco08_to_soc10"><b>isco08_to_soc10()</b></a>         ISCO-08 to 2010 SOC (non-unique); also see
                                  <a href="http://www.stata.com/help.cgi?_cwfcn_soc10_to_isco08"><b>soc10_to_isco08()</b></a>
      <a href="http://www.stata.com/help.cgi?_cwfcn_isco88_to_soc00"><b>isco88_to_soc00()</b></a>         ISCO-88 to 2000 SOC (non-unique); also see
                                  <a href="http://www.stata.com/help.cgi?_cwfcn_soc00_to_isco88"><b>soc00_to_isco88()</b></a>
      <a href="http://www.stata.com/help.cgi?_cwfcn_soc10_to_soc18"><b>soc10_to_soc18()</b></a>          2010 SOC to 2018 SOC (non-unique); also see
                                  <a href="http://www.stata.com/help.cgi?_cwfcn_soc18_to_soc10"><b>soc18_to_soc10()</b></a>
      <a href="http://www.stata.com/help.cgi?_cwfcn_soc00_to_soc10"><b>soc00_to_soc10()</b></a>          2000 SOC to 2010 SOC (non-unique); also see
                                  <a href="http://www.stata.com/help.cgi?_cwfcn_soc10_to_soc00"><b>soc10_to_soc00()</b></a>

    Aggregation
      <a href="http://www.stata.com/help.cgi?_cwfcn_isco08_to_isco08_3"><b>isco08_to_isco08_3()</b></a>      4-digit to 3-digit ISCO-08; also see
                                  <a href="http://www.stata.com/help.cgi?_cwfcn_isco08_to_isco08_2"><b>isco08_to_isco08_2()</b></a>
                                  <a href="http://www.stata.com/help.cgi?_cwfcn_isco08_to_isco08_1"><b>isco08_to_isco08_1()</b></a>
                                  <a href="http://www.stata.com/help.cgi?_cwfcn_isco08_3_to_isco08_2"><b>isco08_3_to_isco08_2()</b></a>
                                  <a href="http://www.stata.com/help.cgi?_cwfcn_isco08_3_to_isco08_1"><b>isco08_3_to_isco08_1()</b></a>
                                  <a href="http://www.stata.com/help.cgi?_cwfcn_isco08_2_to_isco08_1"><b>isco08_2_to_isco08_1()</b></a>
      <a href="http://www.stata.com/help.cgi?_cwfcn_isco88_to_isco88_3"><b>isco88_to_isco88_3()</b></a>      4-digit to 3-digit ISCO-88; also see
                                  <a href="http://www.stata.com/help.cgi?_cwfcn_isco88_to_isco88_2"><b>isco88_to_isco88_2()</b></a>
                                  <a href="http://www.stata.com/help.cgi?_cwfcn_isco88_to_isco88_1"><b>isco88_to_isco88_1()</b></a>
                                  <a href="http://www.stata.com/help.cgi?_cwfcn_isco88_3_to_isco88_2"><b>isco88_3_to_isco88_2()</b></a>
                                  <a href="http://www.stata.com/help.cgi?_cwfcn_isco88_3_to_isco88_1"><b>isco88_3_to_isco88_1()</b></a>
                                  <a href="http://www.stata.com/help.cgi?_cwfcn_isco88_2_to_isco88_1"><b>isco88_2_to_isco88_1()</b></a>

    Other
      <a href="#cwtable"><i>myname</i></a><a href="#cwtable"><b>()</b></a>                  custom crosswalk table
    ---------------------------------------------------------------------------------

<a name="casefcn"></a>    <i>casefcn</i>()                   Description
    ---------------------------------------------------------------------------------
    <a href="http://www.stata.com/help.cgi?_cwcasefcn_egp"><b>case.egp()</b></a>                  EGP case function for ISCO-88
    <a href="http://www.stata.com/help.cgi?_cwcasefcn_egp68"><b>case.egp68()</b></a>                EGP case function for ISCO-68
    <a href="http://www.stata.com/help.cgi?_cwcasefcn_esec"><b>case.esec()</b></a>                 ESEC case function for ISCO-08
    <a href="http://www.stata.com/help.cgi?_cwcasefcn_esec"><b>case.esec88()</b></a>               ESEC case function for ISCO-88
    <a href="http://www.stata.com/help.cgi?_cwcasefcn_oesch"><b>case.oesch()</b></a>                OESCH case function
    <a href="#cwcasefun"><b>case.</b></a><a href="#cwcasefun"><i>myname</i></a><a href="#cwcasefun"><b>()</b></a>               custom case function
    ---------------------------------------------------------------------------------

<a name="lblset"></a>    <i>lblset</i>                      Description
    ---------------------------------------------------------------------------------
    <a href="http://www.stata.com/help.cgi?_cwfcn_labels_egp"><b>egp</b></a>                         EGP labels; also see <a href="http://www.stata.com/help.cgi?_cwfcn_labels_egp11"><b>egp11</b></a>
    <a href="http://www.stata.com/help.cgi?_cwfcn_labels_esec"><b>esec</b></a>                        ESeC labels
    <a href="http://www.stata.com/help.cgi?_cwfcn_labels_oesch"><b>oesch</b></a>                       OESCH labels; also see <a href="http://www.stata.com/help.cgi?_cwfcn_labels_oesch8"><b>oesch8</b></a>, <a href="http://www.stata.com/help.cgi?_cwfcn_labels_oesch5"><b>oesch5</b></a>
    <a href="http://www.stata.com/help.cgi?_cwfcn_labels_isco08"><b>isco08</b></a>                      ISCO-08 labels; also see <a href="http://www.stata.com/help.cgi?_cwfcn_labels_isco08_3"><b>isco08_3</b></a>, <a href="http://www.stata.com/help.cgi?_cwfcn_labels_isco08_2"><b>isco08_2</b></a>, <a href="http://www.stata.com/help.cgi?_cwfcn_labels_isco08_1"><b>isco08_1</b></a>
    <a href="http://www.stata.com/help.cgi?_cwfcn_labels_isco88"><b>isco88</b></a>                      ISCO-88 labels; also see <a href="http://www.stata.com/help.cgi?_cwfcn_labels_isco88_3"><b>isco88_3</b></a>, <a href="http://www.stata.com/help.cgi?_cwfcn_labels_isco88_2"><b>isco88_2</b></a>, <a href="http://www.stata.com/help.cgi?_cwfcn_labels_isco88_1"><b>isco88_1</b></a>
    <a href="http://www.stata.com/help.cgi?_cwfcn_labels_isco88com"><b>isco88com</b></a>                   ISCO-88(COM) labels; also see <a href="http://www.stata.com/help.cgi?_cwfcn_labels_isco88com_3"><b>isco88com_3</b></a>,
                                  <a href="http://www.stata.com/help.cgi?_cwfcn_labels_isco88com_2"><b>isco88com_2</b></a>, <a href="http://www.stata.com/help.cgi?_cwfcn_labels_isco88com_1"><b>isco88com_1</b></a>
    <a href="http://www.stata.com/help.cgi?_cwfcn_labels_isco88a"><b>isco88a</b></a>                     ISCO-88 labels by Ganzeboom/Treiman; also see <a href="http://www.stata.com/help.cgi?_cwfcn_labels_isco88b"><b>isco88b</b></a>
    <a href="http://www.stata.com/help.cgi?_cwfcn_labels_isco68"><b>isco68</b></a>                      ISCO-68 labels
    <a href="http://www.stata.com/help.cgi?_cwfcn_labels_soc18"><b>soc18</b></a>                       2018 SOC labels
    <a href="http://www.stata.com/help.cgi?_cwfcn_labels_soc10"><b>soc10</b></a>                       2010 SOC labels
    <a href="http://www.stata.com/help.cgi?_cwfcn_labels_soc00"><b>soc00</b></a>                       2000 SOC labels
    <a href="#cwlblset"><i>myname</i></a>                      custom label set
    ---------------------------------------------------------------------------------


<a name="description"></a><b><u>Description</u></b>

    <b>crosswalk</b> applies fast table-based recoding. Pre-defined crosswalk tables are
    provided for common recoding tasks related to occupational classifications. See
    <a href="#cwtable">below</a> on how to define custom crosswalk tables.

    <b>crosswalk</b> works via indexing or hash tables, depending on type of data. The heavy
    lifting is done by Mata function <a href="http://www.stata.com/help.cgi?mf_mm_crosswalk"><b>mm_crosswalk()</b></a> from the <a href="http://www.stata.com/help.cgi?moremata"><b>moremata</b></a> package (Jann
    2005), which needs to be installed on the system (see ssc describe moremata).

    <b>crosswalk</b> supersedes command <a href="http://www.stata.com/help.cgi?iscogen"><b>iscogen</b></a> (Jann 2019).


<a name="options"></a><b><u>Options</u></b>

<a name="opts"></a>        +--------------+
    ----+ Main options +-------------------------------------------------------------

<a name="expandok"></a>    <b>expandok</b> allows the crosswalk table to contain duplicate origin values and adds
        observations to the dataset if needed. By default, <b>crosswalk</b> requires the
        origin values in the crosswalk table to be unique, such that each value of
        <i>varname</i> only has a single match in the crosswalk table (one-to-one or
        one-to-many crosswalk). Specify <b>expandok</b> to allow duplicate origin values
        (many-to-one or many-to-many crosswalk). In this case, if an observation has
        multiple matches in the crosswalk table, copies of the observation will be
        added to the data, one for each match (similar to forming pairwise
        combinations using <a href="http://www.stata.com/help.cgi?joinby"><b>joinby</b></a>).

    <b>missing</b> treats missing values like other values. The default is to exclude
        missing values from the evaluated subsample. Only one of <b>missing</b> and
        <b>copymissing</b> is allowed.

    <b>copyrest</b>[<b>(</b><b><u>nol</u></b><b>abel)</b>] copies values that are not matched by the crosswalk table
        into the generated variable (within the subsample selected by <a href="http://www.stata.com/help.cgi?if"><i>if</i></a> and <a href="http://www.stata.com/help.cgi?in"><i>in</i></a>). By
        default, the generated variable will be set to missing for these
        observations; specify <b>copyrest</b> to retain the original values. Unless argument
        <b>nolabel</b> is specified, <b>copyrest</b> also copies all value labels from <i>varname</i> to
        the generated variable (but note that individual labels may subsequently be
        overwritten by labels obtained from <i>lblset</i>). <b>copyrest</b> implies <b>copymissing</b>
        unless <b>missing</b> is specified or the source variable is string. Furthermore,
        <b>copymissing</b> implies <b>string</b> or <b>numeric</b> depending on the data type of the
        source variable.

    <b>copymissing</b>[<b>(</b><b><u>nol</u></b><b>abel)</b>] copies extended missing values into the generated variable
        (within the subsample selected by <a href="http://www.stata.com/help.cgi?if"><i>if</i></a> and <a href="http://www.stata.com/help.cgi?in"><i>in</i></a>). Specify <b>copymissing</b> if the
        source variable has extended missing values that you want to pass through to
        the generated variable; value labels of extended missings will also be
        copied, unless argument <b>nolabel</b> is specified. <b>copymissing</b> implies <b>numeric</b> and
        is only allowed if the source variable is numeric. Only one of <b>missing</b> and
        <b>copymissing</b> is allowed. Only one of <b>copyrest</b> and <b>copymissing</b> is allowed.

    <b>label(</b>[<i>lblset</i>][<b>,</b> <b>minimal</b>]<b>)</b> specifies a <a href="#lblset"><i>lblset</i></a> to be used for the value labels. By
        default, when applying function <i>origin</i><b>_to_</b><i>destination</i><b>()</b>, the <i>lblset</i> called
        <i>destination</i> will be used, if such a set exists. Suboption <b>minimal</b> requests
        that only values be labeled that exist in the data; the default is to include
        all defined labels. <b>label()</b> has no effect if the generated variable is
        string. Specify <b>nolabel</b> to omit the automatic assignment of value labels.

    <b>string</b> enforces string format for the generated variable. The default is to use a
        numeric format as long as all destination values in the crosswalk table are
        numeric.

    <b>numeric</b> enforces numeric format for the generated variable even if there are
        nonnumeric destination values. Only one of <b>string</b> and <b>numeric</b> is allowed.

    <b>noinfo</b> skips collecting information on levels of <i>varname</i> that are not matched by
        the crosswalk table. This saves some computer time.

    <b>out(</b><i>outname</i><b>)</b> adds an indicator to the data that tags observations without match
        in the crosswalk table (1 = not matched, 0 = matched, . = not in evaluated
        subsample).

    <b>fast</b> does not restore the original dataset if <b>expandok</b> has been specified and
        there is an error or the user presses <b>Break</b>. This saves memory and some
        computer time. <b>fast</b> has no effect if <b>expandok</b> is omitted.

    <b>replace</b> allows overwriting an existing variable.

<a name="lbloptions"></a>        +-----------------------------+
    ----+ Options for crosswalk label +----------------------------------------------

    <b>name(</b><i>lblname</i><b>)</b> provides a custom name for the value label. By default, a separate
        set of labels is assigned to each variable using the name of the variable as
        the name of the value label. Specify option <b>name()</b> to use a common set across
        all variables. If <b>name()</b> is omitted and <i>varlist</i> is empty, a single set called
        <i>lblset</i> will be created.

    <b>modify</b> causes existing value labels to be modified rather than replaced.

    <b>minimal</b> equests that only values be labeled that exist in the data. The default
        is to include all defined labels. <b>minimal</b> is only allowed if <i>varlist</i> is
        specified.


<a name="remarks"></a><b><u>Remarks</u></b>

        <a href="#case">The case argument</a>
        <a href="#cwtable">Custom crosswalk tables</a>
        <a href="#cwcasefun">Custom case functions</a>
        <a href="#cwlblset">Custom label sets</a>
        <a href="#manipulate">Manipulate existing crosswalk table</a>

<a name="case"></a>        +--------------------+
    ----+ The case argumment +-------------------------------------------------------

    Some crosswalk tables contain multiple destination columns, each representing a
    specific case. Use argument <i>case</i> in <a href="#fcn"><i>fcn</i></a><b>(</b><i>varname</i> <i>case</i><b>)</b> to select the destination
    column. Argument <i>case</i> may be one of the following.

        <i>casevar</i>             a numeric variable indicating the destination column of
                            each observation (1 for the first destination column, 2
                            for the second destination column, etc.)
        <a href="http://www.stata.com/help.cgi?exp"><i>exp</i></a>                 an expression, possibly involving multiple variables
        <a href="#casefcn"><i>casefcn</i></a><b>(</b><i>arguments</i><b>)</b>  a special-purpose function determining the destination
                            column

    For example, the translation of ISCO-88 codes into EGP classes depends on
    employment status and supervisory function. See the documentation of
    <a href="http://www.stata.com/help.cgi?_cwfcn_isco88_to_egp"><b>isco88_to_egp()</b></a> for detailed information. You could use you own code to construct
    a variable, say <b>egpcase</b>, indicating the appropriate combination of employment
    status and supervisory function for each observation (1 = employee without
    subordinates, 2 = employee with 1 subordinate, etc.), and then specify

        . <b>crosswalk</b> <i>newvar</i> <b>=</b> <b>isco88_to_egp(</b><i>varname</i> <b>egpcase)</b>

    Alternatively, use pre-defined case function <a href="http://www.stata.com/help.cgi?_cwcasefcn_egp"><b>case.egp()</b></a> as in

        . <b>crosswalk</b> <b>egpcase =</b> <b>case.egp(</b><i>sempl</i> <i>supvis</i><b>)</b>
        . <b>crosswalk</b> <i>newvar</i> <b>=</b> <b>isco88_to_egp(</b><i>varname</i> <b>egpcase))</b>

    or, equivalently, in

        . <b>crosswalk</b> <i>newvar</i> <b>=</b> <b>isco88_to_egp(</b><i>varname</i> <b>case.egp(</b><i>sempl</i> <i>supvis</i><b>))</b>

    where <i>sempl</i> contains the employment status (0 = employed, 1 = self-employed) and
    <i>supvis</i> contains the number of subordinates or employees.

    Argument <i>case</i> will be ignored by crosswalk tables that only have a single
    destination column.

<a name="cwtable"></a>        +-------------------------+
    ----+ Custom crosswalk tables +--------------------------------------------------

    Custom crosswalk tables can be defined on the fly using <b>crosswalk define</b>, or be
    provided permanently as files on disk (in the working directory or somewhere else
    along the <a href="http://www.stata.com/help.cgi?adopath"><b>adopath</b></a>). For example, you could type

        <b>. crosswalk define myrecode()</b>
<b>         1  3</b>
<b>         2  2</b>
<b>         3  1</b>
<b>        .a .b</b>
<b>        end</b>

    and then used the defined crosswalk table as follows:

        <b>. crosswalk Y = myrecode(X), missing</b>

    Each line after <b>crosswalk define</b> specifies a recoding rule consisting of an
    origin value followed by a destination value (or several destination values; see
    the <a href="#case"><i>case</i></a> argument). Empty lines are not allowed, and the input must be terminated
    by keyword <b>end</b>.

    Alternatively, you could make <b>myrecode()</b> available by storing

         1  3
         2  2
         3  1
        .a .b

    in file <b>_cwfcn_myrecode.sthlp</b> in the working directory. The syntax of crosswalk
    files is as follows.

      o Each line defines a recoding rule consisting of an origin value followed by
        one or several destination values. The values must be space-separated.
      o Values containing spaces must be enclosed in single quotes ('...'), double
        quotes ("..."), or compound double quotes (`"..."').
      o Empty lines and lines starting with <b>*</b> will be ignored.
      o Line <b>{smcl}</b> starts an SMCL formatted section that will be ignored. Line
        <b>{asis}</b> ends the SMCL section.
      o The filename must start with prefix <b>_cwfcn_</b> and end with suffix <b>.sthlp</b>.

    A crosswalk table can also be implemented as a wrapper for one or several other
    crosswalk tables (only one wrapper level is allowed; that is, wrappers cannot
    call wrappers). Within a wrapper, use alias syntax <b>.</b><i>fcn</i>[<b>(</b><i>#</i><b>)</b>] to call crosswalk
    table <i>fcn</i><b>()</b> (and take origin values from column <i>#</i>; default is 1). For example,
    the definition of <a href="http://www.stata.com/help.cgi?_cwfcn_isco08_to_esec"><b>isco08_to_esec()</b></a> is

        <b>. crosswalk define isco08_to_esec()</b>
<b>        .isco08_to_isco08_3</b>
<b>        .isco08_3_to_esec</b>
<b>        end</b>

    This means that <b>isco08_to_esec()</b> first calls <a href="http://www.stata.com/help.cgi?_cwfcn_isco08_to_isco08_3"><b>isco08_to_isco08_3()</b></a> to translate
    4-digit ISCO-08 to 3-digit ISCO-08, and then <a href="http://www.stata.com/help.cgi?_cwfcn_isco08_3_to_esec"><b>isco08_3_to_esec()</b></a> to translate
    3-digit ISCO-08 to ESeC.

<a name="cwcasefun"></a>        +-----------------------+
    ----+ Custom case functions +----------------------------------------------------

    A custom <a href="#case">case function</a> called <b>case.</b><i>myname</i><b>()</b> can be provided by storing file
    <b>_cwcasefcn_</b><i>myname</i><b>.sthlp</b> in the working directory or somewhere else along the 
    <a href="http://www.stata.com/help.cgi?adopath"><b>adopath</b></a>. Similar to a <a href="#cwtable">crosswalk table</a>, the file may contain SMCL sections that
    will be ignored. Apart from that, the file is assumed to contain Stata code that
    will be called by <b>crosswalk</b> using command <a href="http://www.stata.com/help.cgi?run"><b>run</b></a>. The following arguments are passed
    through: the name of the variable to be generated, the name of the variable
    marking the evaluated subsample, any other <i>arguments</i> specified by the user.

<a name="cwlblset"></a>        +-------------------+
    ----+ Custom label sets +--------------------------------------------------------

    Label sets have the same format as crosswalk tables, but their name must start
    with <b>labels_</b>. For example, type

        <b>. crosswalk define labels_myrecode</b>
<b>         3 "New three (was 1)"</b>
<b>         2 "Two (did not change)"</b>
<b>         1 "New one (was 3)"</b>
<b>        .b "New missing (was .a)"</b>
<b>        end</b>

    to provide label set <b>myrecode</b>. You could then use it together with crosswalk
    table <b>myrecode()</b> defined <a href="#cwtable">above</a> about as follows:

        <b>. crosswalk Y = myrecode(X), missing label(myrecode)</b>

    Hint: Use name <b>labels_</b><i>destination</i> if you want to provide labels that will be
    picked up automatically by crosswalk table <i>origin</i><b>_to_</b><i>destination</i><b>()</b>.

<a name="manipulate"></a>        +-------------------------------------+
    ----+ Manipulate existing crosswalk table +--------------------------------------

    Many-to-many crosswalk table <a href="http://www.stata.com/help.cgi?_cwfcn_ilo_isco08_to_isco88"><b>ilo_isco08_to_isco88()</b></a> is defined at the unit-group
    level (4-digit) only. That is, the table assigns one or several ISCO-88 unit
    groups to each ISCO-08 unit group. Empirical data, however, often also contain
    4-digit variants of codes for major, sub-major, or minor groups (i.e., 1, 2, or
    3-digits codes padded with zeros on the right), because sometimes there is not
    enough information to code an observation at the unit-group level. When applying
    <b>ilo_isco08_to_isco88()</b> these codes will be left without match. An approach to
    solve this issue, is to take the original crosswalk table, truncate all origin
    and destination codes to 3 digits, remove duplicates, and then add a trailing
    zero back in to each code. The resulting table assigns one or several ISCO-88
    minor groups to each ISCO-08 minor group (using 4-digit variants of the codes).
    Correspondence tables for major (1-digit) and sub-major (2-digit) groups can be
    constructed analogously. We can then append these tables to the original table
    (skipping origin codes that may already exist in the original table) to obtain a
    many-to-many crosswalk that covers all four levels at the same time.

    Illustrating the use of commands <b>crosswalk import</b> and <b>crosswalk post</b>, the
    described procedure could be implemented about as follows:

        // import original crosswalk table
        <b>crosswalk import ilo_isco08_to_isco88()</b>
        // generate unique ID
        <b>generate _id = _n</b>
        // replace each original row by 4 copies
        <b>expand 4</b>
        // assign a number of digits (1, 2, 3, or 4) to each copy
        <b>bysort _id: generate _digits = _n</b>
        // repeat for 1, 2, or 3 digits
        <b>forv d = 1/3 {</b>
            // number of trailing zeros in d-digit code
            <b>local r = 4 - `d'</b>
            // drop observation if it already has r trailing zeros
            <b>drop if substr(v1,-`r',.)==(`r'*"0") &amp; _digits==`d'</b>
            // replace original values by d-digit codes with r trailing zeros
            <b>replace v1 = substr(v1,1,`d') + (`r'*"0") if _digits==`d'</b>
            <b>replace v2 = substr(v2,1,`d') + (`r'*"0") if _digits==`d'</b>
        <b>}</b>
        // drop helper variables
        <b>drop _id _digits</b>
        // drop duplicate rows
        <b>duplicates drop</b>
        // sort data (optional)
        <b>sort v1 v2</b>
        // post result as a custom crosswalk table
        <b>crosswalk post my_isco08_to_isco88()</b>

    The new crosswalk table can then be used as <b>my_isco08_to_isco88()</b> in subsequent
    <b>crosswalk</b> commands in the same Stata session.  Alternatively, if you want to make
    the new crosswalk table available permanently, use <b>crosswalk export</b> in the last
    step to save it to disk.

    Original <b>ilo_isco08_to_isco88()</b> is bi-directional and, consequently,
    <a href="http://www.stata.com/help.cgi?_cwfcn_ilo_isco88_to_isco08"><b>ilo_isco88_to_isco08()</b></a> is implemented as a wrapper for <b>ilo_isco08_to_isco88()</b>.
    For <b>my_isco08_to_isco88()</b>, bi-directionality no longer holds. To obtain the
    reverse translator, say <b>my_isco88_to_isco08()</b>, use the above code, but swap
    variables <b>v1</b> and <b>v2</b> after importing <b>ilo_isco08_to_isco88()</b>.


<a name="examples"></a><b><u>Examples</u></b>

    Generate ISEI scores from ISCO-88 codes:

        <b>. crosswalk isei = isco88_to_isei(job)</b>

    Translate ISCO-88 to ISCO-08:

        <b>. crosswalk job08 = isco88_to_isco08(job)</b>

    Translate 4-digit ISCO-88 unit groups to 2-digit sub-major groups:

        <b>. crosswalk job_isco2 = isco88_to_isco88_2(job)</b>

    Generate EGP classes from ISCO-88 codes:

        <b>. crosswalk EGP = isco88_to_egp11(job case.egp(selfemp nemployees))</b>

    Assign ISCO-88(COM) labels to existing variables:

        <b>. crosswalk label isco88com job_mother job_father</b>


<a name="stored"></a><b><u>Stored results</u></b>

    Command <b>crosswalk</b> <i>newvar</i> <b>=</b> <i>fcn</i><b>()</b> stores the following results in <b>r()</b>.

      Scalars:
      <b>r(string)</b>      <b>1</b> if the generated variable is string, else <b>0</b>
      <b>r(r_out)</b>       number of levels of <i>varname</i> without match; only if <b>noinfo</b> is not
                     specified
      <b>r(N_add)</b>       number of added observations; only if <b>expandok</b> is specified

      Macros:
      <b>r(fcn)</b>         name of applied <a href="#fcn"><i>fcn</i></a><a href="#fcn">()</a>
      <b>r(fn)</b>          filename of applied <a href="#fcn"><i>fcn</i></a><a href="#fcn">()</a> (empty if from memory)
      <b>r(lblset)</b>      name of applied <a href="#lblset"><i>lblset</i></a>
      <b>r(fn_lblset)</b>   filename of applied <a href="#lblset"><i>lblset</i></a> (empty if from memory)
      <b>r(newvar)</b>      name of generated variable
      <b>r(varname)</b>     name of source variable
      <b>r(case)</b>        <a href="#case"><i>case</i></a> specification
      <b>r(fn_casefcn)</b>  filename of applied <a href="#casefcn"><i>casefcn</i></a><a href="#casefcn">()</a> (or empty)
      <b>r(levels_out)</b>  list of levels of <i>varname</i> without match; only if <b>noinfo</b> is not
                     specified

    Command <b>crosswalk</b> <i>newvar</i> <b>=</b> <i>casefcn</i><b>()</b> stores the following macros in <b>r()</b>.

      <b>r(casefcn)</b>     name of applied <a href="#casefcn"><i>casefcn</i></a><a href="#casefcn">()</a>
      <b>r(fn_casefcn)</b>  filename of applied <a href="#casefcn"><i>casefcn</i></a><a href="#casefcn">()</a>
      <b>r(newvar)</b>      name of generated variable

    Command <b>crosswalk label</b> stores the following macros in <b>r()</b>.

      <b>r(lblset)</b>      name of applied <a href="#lblset"><i>lblset</i></a>
      <b>r(fn_lblset)</b>   filename of applied <a href="#lblset"><i>lblset</i></a> (empty if from memory)
      <b>r(lbname)</b>      name(s) used for the value labels
      <b>r(varlist)</b>     specified variables

    Command <b>crosswalk define</b> stores the name of the defined function in macro <b>r(fcn)</b>.

    Command <b>crosswalk save</b> stores the name of the saved function in macro <b>r(fcn)</b> and
    the used filename in macro <b>r(fn)</b>.

    Command <b>crosswalk dir</b> stores the number of functions in scalar <b>r(n)</b> and a space
    separated list of the function names in macro <b>r(fcns)</b>.

    Command <b>crosswalk list</b> stores the length of the function (number of rows) in
    scalar <b>r(r)</b> and the filename of the function in macro <b>r(fn)</b> (empty if from
    memory).

    Command <b>crosswalk import</b> stores the filename of the imported function in macro
    <b>r(fn)</b> (empty if from memory) and passes through all stored results from <a href="http://www.stata.com/help.cgi?describe"><b>describe</b></a>
    applied to the imported data.

    Command <b>crosswalk post</b> stores the name of the posted function in macro <b>r(fcn)</b>.

    Command <b>crosswalk export</b> stores the name of the saved function in macro <b>r(fcn)</b>
    and the used filename in macro <b>r(fn)</b>.


<a name="references"></a><b><u>References</u></b>

    Jann, B. 2005. moremata: Stata module (Mata) to provide various functions.
        Available from https://ideas.repec.org/c/boc/bocode/s455001.html.
    Jann, B. 2019. iscogen: Stata module to translate ISCO codes. Available from 
        https://ideas.repec.org/c/boc/bocode/s458665.html.


<a name="author"></a><b><u>Author</u></b>

    Ben Jann, University of Bern, ben.jann@unibe.ch

    Thanks for citing this software as follows:

        Jann, B. 2025. crosswalk: Stata module to recode variable based on crosswalk
        table (bulk recoding). Available from 
        https://ideas.repec.org/c/boc/bocode/s459420.html.


<a name="alsosee"></a><b><u>Also see</u></b>

</pre>
