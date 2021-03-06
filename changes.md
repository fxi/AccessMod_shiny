## List of changes in AccessMod

- 5.6.56 
   - Improvement 
    - Added catchment type, in catchment polygons attribute table ( column "type" ) :
      - A : Inner + outer ring.
      - B : Outer ring only. Less capacity than polualation within the minimal travel time isoband
      - C : Inner ring + remaining. More capacity than population within current full travel time
      - D : Inner ring. Catchment pop matches exactly the capacity
      - E : Inner ring. No capacity = all population at max time.
      
      Definitions:
      - Inner ring means the population is set to zero within a zone ( covered by the facility catchment area ).
      - Outer ring means that a travel time isoband is used as mask to reduce proportionally the population.

- 5.6.55 
    - Bug fix
      - Issue #340 reavelated a issue introduced by an optimisation fix in 5.6.12. A partial rewrite of the code of the geographic coverage module has been made to revert the change. The code should be more clear, too.
- 5.6.54
    - Bug fix
      - Missing friction layer in scaling up [ 2020-03-18 - 2020-04-06 ]
    - Improvement
      - Added an option to create columns for population coverage verification in capacity analysis #340 [2020-04-01 - ? ]
- 5.6.53
    - Bug fix
      - Changing project max upload limit was blocked by a hard-coded value. Now, there is no more maximum value. Could lead to some instability, but the user is warned.
- 5.6.52
    - Bug fix
      - Issue with table parsing resuting to an error message in different modules. Solves issue #330 [ 2020-10-11 - 2020-10-11 ]
- 5.6.51
    - Bug fix
      - Removed unique value restriction in 'adjust population distribution' column selection #327 [ 2020-09-22 – 2020-10-02 ]
      - Test if friction or speed layer (or both) should be pre-computed in case suitability need them. Should solve the issue #326 [ 2020-09-21 – 2020-10-02 ]
      - Removed multifeature export, as points (hf) were skipped. Removed also ADJUST_TYPE dsco : not supported by shapefile driver. Should solve the issue #325 [ 2020-09-21 – 2020-10-02 ]
      - Added a cleaning function to nearly all blocks that use read.table that could deal with GRASS table output. This step should clean unwanted characters (quotes, single quote, chariot return) that could produce bad results in tables. Should solve the issue #329 [ 2020-09-22 – 2020-10-02 ]
- 5.6.50
    - Merge landcover : improved performance in diagnonal bridge removal. One step instead of N steps, one per road item.
- 5.6.49
    - Test updating last 5.6.48 VM
- 5.6.48
    - Typos
      - Merge PR #315 for AccessMod dictionary
    - Improvement
      - Added '.tif' as correct extension for GeoTIFF file. Issue #319 [ 2020-07-03 – 2020-07-03 ]
- 5.6.47
    - Bug fix
      - Project names, when containing only numerals or coercible to numerals, produced an issue in 'mapcalc' commands. As rewriting all mapcalc would be a huge task that could break a lot of things, the solution was to set a rule to avoid such project name. See issue #318 [ 2020-06-25 – 2020-06-26 ].
      - Reset region and mapset after raster importation on exit, as it could set AccessMod in a stale state, in case of failure during the import see issue #317 [ 2020-06-23 – 2020-06-27].  
- 5.6.46
    - Improvement
       - Continue improvement requested in #198 [ 2018-09-20 - ? ] on proper licensing AccessMod : added copyright/license header in each AccessMod files (.R, .js, .sh). Added a copy of GPL-3 license and WHO terms of use files. 
- 5.6.45
    - Bug fix
       - Last patch of #302 fixed only imported suitability tables. Now, both exclusion and suitability should work as expected.  
- 5.6.44
    - Bug fix
       - A recent change made in geographic coverage table did not maintain the correct column order (#303) and produced a bug when ignoring capacity #316 [ 2020-06-19 – 2020-06-20 ]
- 5.6.43
    - Improvement
       - Handle 10 digits after decimal point in tables of the interface #300 [ 2019-12-15 - 2020-06-12 ]
       - Land cover merge : using text label version of classes is now possible when creating road stack item [ 2017-09-15 ~ 2020-06-12]  
    - Bug fix
       - When requesting column type and the column name contained the string "type", an error occured.
- 5.6.42
    - Bug fix
       - Columns order for imported suitability table did not match expected order for display. #302 [ 2019-12-15 – 2020-06-05 ]
    - Improvement
       - Geographic coverage: columns added / removed / reordered / renamed #303 [ 2019-12-15 – 2020-06-05 ] 

- 5.6.41
    - Improvement
       - Show selected count in tables with selection toolbar #276 [ 2019-11-02 2020-05-23 ].
       - Keep selection after table update (experimental) #293 [ 2019-11-11 2020-05-23 ].
       - Added new column option in catchment analysis : sum of original population under max travel time #303 [ 2019-12-15 - 2020-05-23 ]
       - Added new field to identify facilities outside DEM in interactive tables. #284 [ 2019-11-07 - 2020-05-23 ] 

- 5.6.40
     - Bug fix
       - Zonal statistic : 
         - Added popTotal colum in wide format
         - Removed bug occuring when the resulting zonal table was empty
     - Improvement
       - Zonal statistic
         - Text translation changes 
- 5.6.39
     - Improvement
       - Zonal statistic. Cast table into a wide table format: time value is tranfered to new columns
     - Bug fix
       - Geographic coverage : when ignoring capacity, the catchment limit was set to inner catchment instead of maximum travel time. #314 [ 2020-04-28 - 2020-05-08].
- 5.6.38
     - New features
       - Zonal statistics can be done for multiple travel time at once. Suggested in #299 [ 2019-12-03 - 2020-04-24].
       - All tables can be downloaded in csv format with a small button below all of them.
- 5.6.37
     - Bug fix
       - Solved new issues and changes requested in #305 [ 2020-04-04 - 2020-04-17 ].
       - Minor internal changes
- 5.6.36 - 2020-03-04
     - New feature
       - A new option is available to extract all networks generated during the distance analysis into a new layer #305 [ 2019-12-15 - 2020-04-03 ]  
- 5.6.35 - 2020-03-04
     - Bug fix
       - In geographic coverage analysis, when all catchments were empty, the catchment layer was not produced. Now, if requested, the catchment layer is available in output, even if all geometries are empty. #312 [ 2020-04-02 - 2020-04-03 ]
- 5.6.34 - 2020-03-13
     - Bug fix
       - Fix an issue in scaling up occurring when new facility catchments did not reach the population, with a specific suitability map, the algorithm did resolve each time with the same solution : an infinite loop was observed #311 [ 2020-03-13 - 2020-03-13 ].
- 5.6.33 - 2020-02-14
     - Bug fix
       - Facility relocation : facilities table was not updated after a relocation using the option  to overwrite of the original layer  #278 [ 2019-11-03 - 2020-02-14 ]
       - Referral : solve a bug occurring if no facility has been reached (e.g. with very low travel time), an aggregation function did not handle this case and an error was returned.   Issue #282 [ 2019-11-06 - 2020-02-14 ].

- 5.6.32 - 2020-02-09
     - Bug fix
       - Optimisation : solve issue when isolated facilities had no other facilities to reach in current region with current scenario
- 5.6.31 - 2020-02-06
     - Bug fix
       - Referral : estimated time remaining did not used correct units; 
       - Optimisation : 
          - Hull analysis is used only if n facilities >= 3; 
          - Optimisation use both 'from' and 'to' facilities group in isotropic mode or anisotropic mode when return path is true, otherwise, only from facilities is used
- 5.6.30 - 2020-02-06
     - Improvement
       - Cumulative cost region optimization option: 
          - Instead of using all starting/destination facilities to compute a buffer, use a convex hull instead;
          - If the optimization lead to more cells to compute, ignore optimization; 
       - Referral : added an estimated time remaining message in the referral progress message
     - Bug fix
       - Improvement regarding optimization should have solved also a bug where the buffer was not produced
- 5.6.29 - 2019-12-24
     - New feature
        - Experimental optimization option (checkbox) in referral analysis. Inverse the origin group (from) and destination group (to) during the cumulated cost analysis (travel time), while calculating cost backwards. If there is less facilities in the destination group, this new option will greatly reduce computation time : the first outer loop in the module is comparatively time-wise expensive. In normal mode, this loop is used with origin group (from). The new option use the second group in this loop.
- 5.6.28 - 2019-12-17
     - Improvement
        - In some case, cached files (exported project, raster tiles) could accumulate and fill up the disk. Until now the user had to take care of removing this cache manually. Now, the process for removing that cache is now automated : each time a project start, those files are deleted. The user can still force a full cache removal using the dedicated button in the configuration panel.
     - New feature
        - A button to remove all archives at once. Archives files, while small, could also fill up the disk. To easily remove unused archive files, a button is available in the advanced settings of the configuration panel.
     - Bug fix
        - A bug related to one of AccessMod dependency has been solved by this patch. This bug was quite important, as it affected all vector data in exported projects. All vector data were linked to the database using an absolute path. If the exported project was loaded with another name than the original project name, the database link was broken and the data, useless. The workaround was to update each vector data file with a relative path, using the new project name.
- 5.6.27 - 2019-12-17
     - Improvement
        - Land cover merge : Add two parameters in skeleton analysis : resolution and buffer size. 
- 5.6.26 - 2019-12-13
     - Improvement
        - Land cover merge : test of a new script to extract barrier from polygons. Discussed in issue #259.
- 5.6.25 - 2019-11-25
     - Improvement
        - Referral module : changed number of digits used in output table for the distance column, as requested in #292.
- 5.6.24 - 2019-11-24
     - Improvement
        - In the referral module, AccessMod use now cumulated cost in seconds internally : no visible change in the interface and ouput tables. As a result, there is less ties, the module is much faster, the precision in all tables are improved, case with 0 travel time and positive distance are less frequent. Related to issue #292 [ 2019-11-10 - 2019-11-24 ]
     - Bug fix
        - In the referral module, the column used as id for facilities was not properly reported in output table. Issue #289 [ 2019-11-09 - 2019-11-24 ]
- 5.6.23 - 2019-11-08
     - Improvement
        - In the 'Correct population distribution' tool:
          - An alignment step was added to avoid stat issues in the final count,
          - A type of "double precision" was added to the ratio column of the temporary zonal table instead of using the dynamically set type, 
          - Two validation steps have been added to make sure everything worked as it should,
          - More stats are available in output window.
     - Bug fix
        - In the raster preview tool, when the resolution was lower than 1 meter, the raster image had suddenly a resolution of 1km. It's solved. Issue #277 [ 2019-11-03 – 2019-11-08 ].
- 5.6.22 - 2019-11-01
     - Bug fix
        - In new table featured in 5.6.21, the values of the original population per zone were missing. The new columns are:
          - cat : id of the zone,
          - pop_orig : original population sum inside each zone,
          - pop_ratio : ratio used for the new distribution,
          - pop_output : the population sum in output,
          - pop_known : if the population is known and the column set, a copy of this column.
        - There was a bug when the name of the table was already present.
- 5.6.21 - 2019-11-01
     - New feature
        - The tool "adjust population distribution" output a table of changes by zones. There is four columns : id of the zone, population sum from raster or read from the layer of zones, ratio of change and population sum in output.
     - Bug fix
        - The issue #261 [ 2019-08-31 - 2019-11-01 ] is fixed : if the user chose not to compute the population on barrier, this step is now skipped.
- 5.6.20 - 2019-10-18
     - Bug fix :
        - In catchment analysis – used in geographic coverage – the case where no population was found under a travel time was not handled properly. Issue #272 [ 2019-10-15 - 2019-10-18 ]
- 5.6.19 - 2019-10-11
     - New feature
        - An optional column from the zone layer in the "correct for population" module can be selected to use known population value per zone to adjust population distribution across zones instead of deducing it from the original population layer using zonal statistic. Issue #200 [ 2018-10-04 - 2019-10-11 ] 
        - Link to the online user manual from the "About" tab. Issue #262 [ 2019-09-05 – 2019-10-11]
     - Bug fix :
        - When exporting very large raster in ERDAS imagine format (`.img`) larger than 4GiB, another file is produced to hold the data with the extension `.ige`. When trying to import that layer in AccessMod, this file was not allowed to be selected. It's allowed now. Issue #270 [ 2019-10-10 – 2019-10-11 ]
- 5.6.18 - 2019-09-27
     - Improvement
        - Single upload button for uploading project file (.am5p) and creating project from DEM
     - Bug fix :
        - Scaling up error: optimisation option was not supported. Issue #267 [ 2019-09-26 - 2019-09-27 ]
        - Uploading new project: progress bar was not removed. Issue #266 [ 2019-09-26 - 2019-09-27 ]
- 5.6.17 - 2019-09-13
     - New feature :
        - Ignore capacity, use full population under catchment coverage instead
     - Bug fix :
        - Parallel referal :
          - Issue with catchment optimisation based on scenario when using multiple starting point source;
          - Issue with time and dist column, the time column was duplicated and the time column did not show up
     - Improvement
        - Optimisation based on scenario : rewrite method, more generalisable.
        - Module land cover merge : removed option added in previous version and added skeleton / centerline approach when using polygon as barrier. See issue #259.
- 5.6.16 - 2019-08-30
     - New feature
        - In the land cover merge module, rasterisation of polygon could lead to unwanted bridges. See #260. A option has been added to use polygon edges as barrier to behave exactly like line barriers. With this option enabled, no cell where at least one vertice is present could be crossed by the travel time analysis. 
- 5.6.15 - 2019-08-22
     - New feature
        - Importation, exportation of projects.
     - Improvement
        - Minor improvement with the progress bar : text and title are two separate elements.
- 5.6.14 - 2019-08-22
     - Bug fix 
        - Major change. In 5323de, a step was added to avoid NULL in the middle of the DEM in a badly formatted layer. Null in the DEM could cause travel time computation issues. But, in some cases, the solution implemented caused wrong results, which is worse. This was already mentionned in #165. This is now fixed. Issue reported by email by @nicolasray. 
- 5.6.13 - 2019-08-02
     - New feature
        - In facilities relocation module, a column from the dataset can be selected to set facilities label value. The label is visible when the mouse pointer is over a facility on the map. Feature request from issue #242 [ 2019-05-30 - 2019-08-02 ]
- 5.6.12 - 2019-07-26
     - New feature
        - In accessibility modules, a new option has been implemented to optimize computation time using a smaller subset of cells based on the maximum area reachable at maximum speed allowed by the scenario. See issue #250.
- 5.6.11 - 2019-07-05
     - Bug fix
        - During importation, some rasters were silently altered: 0 values were interpreted as nodata by a dependency of AccessMod, while the default no data value was explicitly set at -9999. See #246
     - Improvement
        - Display warning message if an imported raster resolution does not match the resolution of the current project. Requested in #248 [ 2019-06-21 – 2019-07-05 ]
        - Tables : set height according to screen height : 30 - 80vh, depending of context
        - Tables : Solve issue with fixed columns not working
        - Minor interface fixes.
- 5.6.10 - 2019-06-28
     - Improvement
        - Fixed some typos
        - Better message to annonce update
        - New link to the source code in the change logs modal window
- 5.6.9 - 2019-06-28
     - Improvement
        - Added AccessMod version number in the left menu with link to the source code,
        - Display an update link in the left menu,
        - Added change logs visualization for current version and new version,
       markdown support in modal with class 'modal',
        - Fixes modal panel position issue: it was not well centered,
        - Added warning background in raster importation summary table if the resolution does not match, 
        - Solved an issue where some simplified error messages were not displayed;
     
- 5.6.8 - 2019-06-14
     - Improvement
        - Added new class "Imported travel time" as requested in #246 [ 2019-06-13 - 2019-06-14 ] 
        - Filter internal raster in GIS preview. Internal data could be added using expert options. Issue #168 [ 2017-05-09 - 2019-06-14 ] related to #93.
        - During importation, conversion of land cover map values in integers if needed. Issue #160 [ 2016-10-07 - 2019-06-14 ]
- 5.6.7 - 2019-06-10
     - Improvement
        - Facilities on barrier message improved: hint to use the new facilities relocation tool.
- 5.6.6 - 2019-06-10
     - Bug fix
        - Solve issue #243 [ 2019-06-10 - 2019-06-10 ] where duplicated spaces replaced by single space in ElementSelect.value parameter.
- 5.6.5 - 2019-05-24
     - Improvement
        - Added a new class of no data : without_data. It's not no_data, it's not considered as is by validation process. It could be used when we don't want a visually empty selection, but instead an explicit way of defining an empty slot: requested in #221 and/l #223 [ 2019-02-14 - 2019-05-24 ].
        - Added a way of translating dynamic layers such as [ OUTPUT FACILITIES ] and [ OUTPUT POPULATION ]. This will be effective when the translation is done.
- 5.6.4 - 2019-05-24
     - Improvement
        - Added scale bar in the interactive map, as requested in #222 
- 5.6.3 - 2019-05-24
     - Bugs fix
        - Solve issue #238 [ 2019-05-15 - 2019-05-24 ] except one point : hard coded string.
        - Solve issue where the table filter tool was not rendering the correct select value list. 
- 5.6.2 - 2019-05-17
     - Bug fixes
        - Add land cover to the stack : imported labels from a table were overwriting the original labels. This was not wanted : see #237 [ 2019-05-15 - 2019-05-17]
        - Accessibility Modules : list of output data should not include internal files
        - Merge Land cover module : fixed double list input that does not update when the user click on 'skip all' or 'use all' see #236 [ 2019-05-15 - 2019-05-17]
        - Button width not correct #240 [ 2019-05-15 - 2019-05-17]
     - Improvement
        - Optimization: Added memoize function to avoid too much latency in validation process
- 5.6.1 - 2019-05-17
     - Improvement
        - The tool for checking the remote server availability in the update script was based on ping command – it uses ICMP and this protocol seems to be blocked in many networks. If this tool fails, AccessMod can't be updated. This has been changed for another tool based on TCP: it should work better.
        - A small script has been written to automate version updating. It should help to prevent unversionned commits in the repository.
        - Fix some typos in this file.
- 5.6.0 - 2019-04-26
     - New feature
        - Multiple language support. For now, French and English are available.
        - Module to relocate facilities by hand (e.g. out of barriers) using a graphical interface
     - Improvements
        - Better performance. Inputs are now populated on demand to avoid full validation.
        - A new button is available in settings, under the expert panel. If pressed, AccessMod will be forced to update. This could solve an issue when AccessMod can't be updated with the standard update mechanism : corrupted project, manual modifications or similar cases.
        - The table system has been updated. It should solve many issues - not always reported - regarding style and performance. 
     - Bug fix
        - Solve bugs #231 [ 2019-04-24 - 2019-04-26 ] In Geographic coverage, if a facility with invalid capacity were encountered, the application crashed. There is now a new validation rule that warns the user of such a case.
- 5.3.2 - 2018-12-14
     - Improvement
        - Referral : keep ties in "closest by time", AccessMod should not decide, user does.
     - Bug fixes
        - Solved issues in facilities selection in the referral module.
        - New referral module did not export correct columns order in some tables
        - Memory management was not optimal in parallel jobs : split memory allowed by job.
        - If empty referral by time – out of reach facilities – don't try to compute a network.
- 5.3.1 - 2018-12-07
     - Improvement
        - Added progression bar for parallel processing in referral module
- 5.3.0 - 2018-11-30
     - Improvement 
        - Added parallel handling for parallel computing in referral module
- 5.2.6 - 2018-11-01
     - Rollback
        - Removed option for raster type in output in the data module
- 5.2.5 - 2018-11-01
    - Bug fix
        - In the accessibility module, when selecting a large number of facilities, around 18'000 facilities, an internal library was failing to process the request. The script produced a silent error – that was successfully reproduced manually outside AccessMod. This error should have been written in a file, but that operation also failed. This last error was reported to the AccessMod user : 'Error in file(con, "r") cannot open the connection'.  As AccessMod can't solve this directly, a workaround has been implemented : instead of subsetting a group of selected facilities, if the unselected facilities group is smaller, AccessMod will simply not select the unselected facilities. Doing this, the process will not fail. See issue #209.
- 5.2.4 - 2018-10-31
    - Improvement
        - Output travel time as an integer to solve huge output files. See issue #207 [ 2018-10-18 - 2018-10-31 ]. If a maximum travel time of 0 is set, the maximum travel time computed will be 32767 minutes ( or 22 days, 18 hours and 7 minutes ). Any value bigger will be coded -1. If the maximum travel time set is bigger than 32767, we use 2147483647 as the ultimate limit, which is about 4085 years. Any value bigger will be coded -1.

- 5.2.3 - 2018-10-26
    - Improvement
        - Solve issue #164 [ 2017-01-27 - 2018-10-26 ] where classes were editable in land cover table.  
        - Solve issue #181 [ 2017-11-02 - 2018-10-26 ], a typo.
- 5.2.2 - 2018-10-06
    - Bug fixes
        - Solve issue #202 [ 2018-10-05 - 2018-10-06 ]. Population coverage estimation in zonal statistics module could have been wrong by a little less than a minute : instead of showing population coverage according to the selected travel time value, the table included statistics for isochrone lower than value plus one, instead of lower than or equal to the value. This was occurring only when the maximum travel time value in the input layer was greater than the selected value in the input field of the module. Example: if the user selected a 120 minutes travel time and launched a zonal statistic on 60 minutes, the population coverage would have included population within an isochronal area up to 60.99 minutes instead of 60 minutes. 
- 5.2.1 - 2018-09-21
    - New feature
        - It's now possible to set speed of 0 Km/h in the scenario table. See #197 [ 2018-09-15 - 2018-09-21 ]. Speed of zero is considered as a barrier and will be acting like so. Selection of facilities located on such 0 Km/h cells are not allowed. A new column "amOnZero" in the facility table allows users to identify those facilities falling on zero speed cells.
- 5.2.0 - 2018-08-24
    - New feature
        - Correct for the population on barrier. This tool will remove population data located on land cover merged barriers and redistribute it within administrative zones. 
- 5.1.18 - 2018-07-09
    - Improvements
        - Estimation of disk space and memory needed to compute a cycle of travel time analysis is now visible in the validation panel of all accessibility based analysis. This is an estimation and not an absolute value. This is a complement to 5.1.16, where the estimation was used just before the analysis to prevent data corruption or memory shortage. 
        - Archive list: changed alphabetical order to date. Issue #192 [ 2018-06-28 - 2018-07-09 ].
    - Bug fixes 
        - Issue #193 [ 2018-06-28 – 2018-07-09 ] The export of a dataset containing infinite travel time caused by faulty DEM produced an error when exporting the file. A new limit in possible travel time set to 2^1024 seconds will prevent the issue, as inf numbers will be ignored, while keeping a large possible output values still possible.
- 5.1.17 - 2018-06-29
    - Improvements
        - In settings panel, added a tool to visualize disk space used and available in the volume where AccessMod stores its data.
    - Bug fixes
        - Some hidden temporary files were not removed properly. Added a function to force removal. Related to issues #183, #140, #175
- 5.1.16 - 2018-06-29
    - Improvements
        - Write logs in isotropic and anisotropic analysis : disk and memory expected values and what is available at the start.
        - Stop analysis before launching a process that would have taken too much resources
    - Bug fixes
        - Solved issue #191 [ 2018-06-27 - 2018-06-29 ], #182 [ 2017-11-06 - 2018-06-29 ] when processes were killed after memory outages. Lower memory attribution to processes.

- 5.1.15 - 2018-06-11
    - Improvements
        - Module data : added a checkbox button to filter datasets from the latest analysis.It will be displayed only after an analysis.
    - Bug fixes 
        - Re-enabled log modules

- 5.1.14 - 2018-06-10
    - Improvements 
        - Added rewritten filters system in the data manager. UI did not change.
        - A new way to select data computed after an analysis. The previous method had some issue: new computed data was sometimes selected unexpectedly after a filtering process.

- 5.1.13 - 2018-06-08
    - Improvements
        - Removed server side filters (replaced by the quick selection bar above each table)
        - Observer isolation : all observers are paused until the corresponding tab is loaded;
        - Added prefix option for archive file name creation 
        - Added a button to delete archives
        - New toolbox tab with "merge land cover" tool and "raster preview"; minor changes; 
    - Bug fixes
        - Solved issue #188 [ 2018-03-10 - 2018-06-08 ]: an error was raised when the same id was present in both "from" and "to" facility selection set, resulting in lost facilities referral evaluation 

- 5.1.12 - 2018-05-02
    - Bug fixes
        - Solved selector list creation issue in handsontable when undefined values / null values found in array.

- 5.1.11 - 2018-04-06
    - Bug fixes
        - Solved selection of multiple data to export 

- 5.1.10 - 2018-02-26
    - Improvements
        - Added basic tool to simplify facilities selection in tables, client side.
