
#
# General validation and error message
#

# preventive field validation
# TODO: this validation step was written for one module:
# With almost all modules depending on it, this should be rewritten.


observe({
  amErrorAction(title='Module 2,3,4,6: validation',{
    #
    # init messages
    #

    err = character(0)
    info = character(0)
    dubious = character(0)
    out  = character(0)
    msgList = character(0)

    #
    # store current module
    #

    module2    <- isTRUE(input$moduleSelector == 'module_2')
    module3    <- isTRUE(input$moduleSelector == 'module_3')
    module4    <- isTRUE(input$moduleSelector == 'module_4')
    module5    <- isTRUE(input$moduleSelector == 'module_5')
    module6    <- isTRUE(input$moduleSelector == 'module_6')

    #
    # Clean tags
    #

    tagsClean  <- amGetUniqueTags(input$costTag) 

    #
    # Control maps and values
    #

    # Check if data exist
    merged     <- isTRUE(!is.null(amNameCheck(dataList,input$mergedSelect,'raster')))
    hf         <- isTRUE(!is.null(amNameCheck(dataList,input$hfSelect,'vector')))
    pop        <- isTRUE(!is.null(amNameCheck(dataList,input$popSelect,'raster')))
    popRes     <- isTRUE(!is.null(amNameCheck(dataList,input$popResSelect,'raster')))


    # table validation
    hfOnBarrier<-isTRUE(
      any(tblHfSubset()$amOnBarrier=='yes') ||
      any(tblHfSubsetTo()$amOnBarrier=='yes') 
      )
    # check if there is at least one facility selectected.
    hfNoSelected            <- isTRUE(!any(tblHfSubset()$amSelect))
    hfNoSelectedTo          <- isTRUE(!any(tblHfSubsetTo()$amSelect))
    # check for speed of  0 kmh
    tblModel          <- isTRUE(!any(hot.to.df(input$speedRasterTable)$speed <1))
    # parameter validation
    unlimitedTT       <- isTRUE(input$maxTravelTime == 0)
    # population on barrier
    popBarrierSum     <- popOnBarrierStat()$sum
    popBarrierCells   <- popOnBarrierStat()$cells
    popBarrierPercent <- popOnBarrierStat()$percent

    #
    # Parameters control.
    #

    if(module3){
      # simple character control (user cannot put custom value)
      hfIdx           <- isTRUE(nchar(input$hfIdxField)>0)
      capField        <- isTRUE(nchar(input$hfCapacityField)>0)
      hfBuffer        <- isTRUE(input$hfOrder == 'circBuffer')
      popBuffer       <- isTRUE(input$popBufferRadius > listen$mapMeta$grid$nsres)
      popBarrierFound <- isTRUE(popBarrierSum>0)
      zonalPop        <- isTRUE('zonalPop' %in% input$mod3param)

      if(zonalPop){
        zonalSelect <- isTRUE(!is.null(amNameCheck(dataList,input$zoneSelect,'vector')))
        zoneId      <- isTRUE(length(input$zoneId)>0)
        zoneLabel   <- isTRUE(length(input$zoneLabel)>0)
      }

      hfOrderInconsistency       <- isTRUE(input$hfOrder!='tableOrder' && !'rmPop' %in% input$mod3param)
      zonalCoverageInconsistency <- isTRUE(zonalPop && !'rmPop' %in% input$mod3param)
      # data overwrite warning module 3 : validate each output !
      # TODO: inform user of all provided output. Warning if risk of overwrite.
    }

    if(module6){
      tblCapTypeOk              <- TRUE
      tblCapMissingOk           <- TRUE
      tblCapOverlapOK           <- TRUE
      tblCapInRangeOk           <- TRUE
      tblCapGreaterThanPrevOk   <- TRUE
      tblCapWithoutButHfSelect  <- FALSE
      tblSuitOnlyDynFac         <- FALSE
      tblCapMinMaxOk            <- TRUE
      tblCapLabelOk             <- TRUE
      tblSuitOk                 <- FALSE
      popSelect                 <- TRUE
      maxScUpPopGoalNoLimit     <- FALSE
      maxScUpTimeNoLimit        <- FALSE
      maxScUpHfNoLimit          <- FALSE
      allScUpNoLimit            <- FALSE

      capNewTable <- hot.to.df(input$capacityTable)
      suitTable <- hot.to.df(input$suitabilityTable)
      withoutFacility <- isTRUE(input$useExistingHf == "FALSE")
      popResidualIsResidual <- isTRUE(amGetClass(input$popResidualSelect)=="rPopulationResidual")

      popNotResidualButHfSelect <- FALSE
      popResidualButNoHfSelect <- FALSE
      # options
      # computation limit
      maxScUpHf <- input$maxScUpNewHf
      maxScUpTime <- input$maxScUpTime
      maxScUpPopGoal <- input$maxScUpPopGoal




      # auto correction
      if(isTRUE(maxScUpPopGoal>100)){
        updateNumericInput(session,"maxScUpPopGoal",value=100)
      }

      maxScUpHfNoLimit <- isTRUE(maxScUpHf<1)
      maxScUpTimeNoLimit <- isTRUE(maxScUpTime <1)
      maxScUpPopGoalNoLimit <- isTRUE(maxScUpPopGoal <1)


      allScUpNoLimit <- all(
        c(
          maxScUpPopGoalNoLimit,
          maxScUpHfNoLimit,
          maxScUpTimeNoLimit
          )
        )


      if(withoutFacility) {
        if(!hfNoSelected && hf){
          tblCapWithoutButHfSelect <- TRUE 
        }
        # manually validate hf layer and hf on barrier.
        hfNoSelected <- FALSE
        hfOnBarrier <- FALSE
        hf <- TRUE
      }else{
        # if there is hf select without a population residual
        if(!hfNoSelected && !popResidualIsResidual){
          popNotResidualButHfSelect <- TRUE
        
        }
         if(hfNoSelected && popResidualIsResidual){
          popResidualButNoHfSelect <- TRUE
        }
      }

      # validate suitability table 
      if(!is.null(suitTable)){
        tblSuitOk <- nrow(na.omit(suitTable))>0 
      }
      if(tblSuitOk){
        # if without facility and all layer in suitability are dynamic facility
        tblSuitOnlyDynFac <- withoutFacility && all(suitTable$layer == config$dynamicFacilities) && !hfNoSelected && hf
      }
      #  validate null
      if(!is.null(capNewTable)){
        #  validate missing value
        tblCapMissingOk <-isTRUE(all(
            sapply(capNewTable,function(x){a=all(stringr::str_length(x)>0)})
            ))
        # validate type
        if(tblCapMissingOk)(
          tblCapTypeOk <- all(
            is.numeric(capNewTable$min),
            is.numeric(capNewTable$max),
            is.numeric(capNewTable$capacity), 
            is.character(capNewTable$label)
            )
          )
        # validate overlap min max and capacity in range.
        if(tblCapMissingOk){
          # max greater than min
          tblCapMinMaxOk<-all(capNewTable$min<capNewTable$max)

          # checking previous row values
          nR<-nrow(capNewTable)
          if(nR>1){
            for(i in 2:nR){
              # Capacity is greater than previous capacity 
              tblCapGreaterThanPrevOk <- all(tblCapGreaterThanPrevOk,isTRUE(capNewTable[i,'capacity']>capNewTable[i-1,'capacity'])) 
              # min max+1 overlap
              tblCapOverlapOK<-all(tblCapOverlapOK,isTRUE(capNewTable[i,'min'] > capNewTable[i-1,'max'])) 
            }
          }
          # capacity in min max range
          tblCapInRangeOk <- isTRUE(
            all(capNewTable$capacity <= capNewTable$max & capNewTable$capacity >= capNewTable$min)
            )
          # unique labels
          tblCapLabelOk<-isTRUE(length(unique(capNewTable$label))==length(capNewTable$label))

        }
      }
    }


    #
    # Collect messages in err and info 
    #



    if(!hf) err = c(err,'Health facilities map missing.') 
    if(hfOnBarrier) err = c(err, 'There are facilities located on barrier. Unselect them or correct the original layer to proceed.')
    if(!merged) err = c(err,'Merged land cover missing.')
    if(unlimitedTT) info = c(info,'Unlimited travel time')
    #if(hf)if(!tblHf) err = c(err,'at least one facilities must be selected') ## too slow
    if(merged)if(!tblModel) err = c(err,'Please correct the final scenario table (0 km/h is not allowed as travel speed).')

    if(module2 | module6){
      if(hfNoSelected) err = c(err, 'Please select at least one facility.')
    }
    if(module3 | module6){ 
      if(!pop) err = c(err,'Please select a population layer.')
    }

    if(module3){
      
      if(!hfIdx) err = c(err,'No group/id field set for hf.')
      if(hfNoSelected) err = c(err, 'Select at least one facility.')
      if(!capField) err = c(err,'No capacity field set for hf.')

      if(hfBuffer)if(!popBuffer) err = c(err,'Circular buffer must be higher than project resolution.')
      #if(!popBarrier) info = c(info,'Map of population on barrier will NOT be computed.')
      if(popBarrierFound) info = c(info,paste('Population encoutered on barrier in',popBarrierCells,' cells for a total of ',popBarrierSum,'individuals. (',popBarrierPercent,'% of total population)'))
      if(hfOrderInconsistency) info=c(info,"If covered population is not removed at each iteration, facilities processing order should be set to 'Order from health facilities table.'")
      if(zonalPop){
        if(!zonalSelect) err=c(err,'Please select a zone layer or uncheck the Generate zonal statistics option under settings.')
        if(!zoneId) err =c(err,'Zonal id column missing.')
        if(!zoneLabel) err =c(err,'Zonal label column missing.')
      }
      if(zonalCoverageInconsistency) err = c(err,'If covered population is not removed at each iteration, zonal analysis could not be performed.')
    }
    if(module4){
      if(hfNoSelected) err = c(err, "Select at least one facility in table 'FROM'.")
      if(hfNoSelectedTo) err = c(err,"Select at least one facility in table 'TO'. ")
    }
    if(module6){
      if(allScUpNoLimit){
        info = c(info, "All scaling up goals are set to 0 (or less) and are considered as unlimited. Scaling up analysis will stop when no more candidates are found or if 100% of the population is covered.")
      }else{
        if(maxScUpPopGoalNoLimit) info = c(info, "Population coverage set to zero or less : coverage will be 100% ")
        if(maxScUpTimeNoLimit) info = c(info, "Time limitation set to zero or less : unlimited processing time.")
        if(maxScUpHfNoLimit)  info = c(info, "Number of facilities to create set to zero less : unlimited facilities creation.")
      }

      if(popNotResidualButHfSelect) dubious = c(dubious, "Population residual selected is not of subclass 'residual', but you have selected facilities. Please verify.")
      if(popResidualButNoHfSelect)  dubious = c(dubious, "Population residual is of subclass 'residual', but no facilies has been selected. Please verify.")
      if(!withoutFacility) info = c(info,"Initial facilities requested. Make sure the residual population layer has been processed with those facilities in the 'Geographic coverage analysis'.")
      #if(hfNoSelected && !pop) err = c(err,'Scaling up : if no facility is selected, you must choose a population map.')
      #if(!hfNoSelected && popRes) err = c(err,'Scaling up : if .')
      if(!tblSuitOk) err = c(err, "Table of suitability factors : missing value")
      if(!tblCapMissingOk) err = c(err,'Table of scaling up capacity: missing value')
      if(!tblCapTypeOk) err = c(err,'Table of scaling up capacity: type error.')
      if(!tblCapMinMaxOk) err =c(err,"Table of scaling up capacity:  min greater than or equal to max.")
      if(!tblCapGreaterThanPrevOk) err = c(err,"Table of scaling up capacity: capacity is not incremental")
      if(!tblCapInRangeOk) info =c(info,"Table of scaling up capacity: there is capacity value(s) not in range [min,max].")
      if(!tblCapOverlapOK) err =c(err,"Table of scaling up capacity: min value can't be equal or less than previous max value.")
      if(tblCapWithoutButHfSelect) err = c(err, "Empty initial facility layer requested, but existing facility selected. Please modify those settings.")
      if(tblSuitOnlyDynFac) err = c(err,"Without existing facilities selected, dynamic facilities can't be the only layer in suitability table. Please add at least another non-dynamic layer.")

      if(!tblCapLabelOk) err =c(err,"Table scaling up capacity: duplicate labels.")
      #if(hfNoSelected) err = c(err, "Select at least one facility.") 
    }

    # output name text. 
    if(!isTRUE(length(tagsClean)>0)){
      err <- c(err,'Please enter at least one tag.')
    }

    #
    # create HTML for validation message list.
    #

    if(length(err)>0){
      plur <- ifelse(length(err)>1,"s","")
      err <- HTML(paste("<div>",icon('exclamation-triangle'),err,'</div>',collapse=""))
      msgList <- tagList(tags$b(sprintf('Error%s:',plur)),err)
      disBtn <- TRUE
    }else{
      disBtn <- FALSE

      if(length(info)>0) {
        plur <- ifelse(length(info)>1,"s","")
        info <- HTML(paste("<div>",icon('info-circle'),info,'</div>',collapse=""))
        msgList <- tagList(tags$b(sprintf('Information%s:',plur)),info)
      }

      if(length(dubious)>0) {
        plur <- ifelse(length(dubious)>1,"s","")
        dubious <- HTML(paste("<div>",icon('question-circle'),dubious,'</div>',collapse=""))
        msgList <- tagList(msgList,tags$b(sprintf('Information%s:',plur)),dubious)
      }


    }

   
    #
    # If no errors, naming datasets that will be produced. 
    # 

    if(length(err)==0){

      classMod = character(0)

      switch(input$moduleSelector,
        "module_2"={classMod=c(
          "tScenarioOut",
          "rSpeed",
          "rFriction",
          "rTravelTime"
          )},
        "module_3"={classMod=c(
          "tScenarioOut",
          "rSpeed",
          "rFriction",
          "tCapacityStat",
          "tZonalStat",
          "rPopulationResidual",
          "rPopulationOnBarrier",
          "vCatchment"
          )},
        "module_4"={classMod=c(
          "tScenarioOut",
          "rSpeed",
          "rFriction",
          "tReferral",
          "tReferralDist",
          "tReferralTime"
          )},
        "module_5"={classMod=c(
          )},
        "module_6"={classMod=c(
          "tScenarioOut",
          "rSpeed",
          "rFriction",
          "rPopulationResidual",
          "vFacilityNew",
          "tCapacityOut",
          "tCapacityStatNew",
          "vCatchmentNew",
          "tExclusionOut",
          "tSuitabilityOut"
          )}
          )



      # vNames has 4 group : ui; file; fileMapset and html version
      vNames <- amCreateNames(classMod,tagsClean,dataList)


      # save for launch analysis
      listen$outputNames <- vNames
      
      # display html version
      out <- tagList(
        tags$b('Output dataset:'), 
        HTML(paste("<div>",icon('sign-out'),vNames$html,"<div/>",collapse=""))
        )
      #
      # Set final message 
      #
    }else{
      out = character(0)
    }
    msgList <- tagList(msgList,out)
    amActionButtonToggle(session=session,'btnComputeAccessibility',disable=disBtn)
    output$msgModule3 <-renderUI({msgList})

})
})

