# Storslysia Relocation Social Insurance Proposal
![SOA cover image](https://user-images.githubusercontent.com/129591024/229493306-285e26b7-dcef-4211-9977-6217410a720c.jpg)
### By ERM Consulting

* TOC
{:toc}

# 1. Executive Summary
## __Objectives__  
The objective of this report is to explore a proposed social insurance program for Storslysia that:
*  Covers the entire population of Storslysia;
*  Covers both voluntary (proactive) and involuntary displacement arising from catastrophic climate-related events;
*  Reduces costs from catastrophic climate-related events with a high degree of certainty; and
*  Prevents costs arising from voluntary and involuntary displacement exceeding 10% of Storslysia’s GDP with a high degree of certainty.

## __Recommendations__  
Climate change is a material emerging risk; one where the impact on everyday life is becoming apparent. The social insurance program defined in this report aims to provide a realistic approach to tackling the catastrophe risk that ensues. Modelling indicates that the maximum average cost of natural perils under SSP climate scenarios can total up to 7,937,354,707,611Ꝕ
in a quarter. Global climate reports from (IPCC, 2023a) indicate that global warming impacts are trending closer to high and very high scenarios, hence the impact of such a cost is very real and imminent. In this context, the following recommendations are made:
*  Attempt to plan and implement the program to some extent;
*  Adopt other risk mitigation techniques where relocation is too costly, such as:
   *  Emergency service and evacuation action plans;
   *  Retrofitting infrastructure;
   *  Policy-based approach to incentivising less development in high-risk cities/regions;
   *  Policy-based building standards across high-risk regions/cities, with relevant enforcement and regulation; and
   *  Education programs to alert high-risk residents of the threat arising from natural perils.
*   Conduct community consultation on the relocation program; and
*   Monitor and support insurance companies to provide affordable premiums, which can reduce under-insurance and subsequently the need for government support and services in the event of a natural disaster.

# 2. Program Design

## __2.1 Claim Requirements__  
To file a claim in relation to property damage from a climate-related catastrophe:
*  The damaged property must be the primary residence of the claimant
*  The claimant/claimants must be the owner/owners of the property
*  The property must not be utilised for business purposes

To file a claim in relation to equipment damage and temporary housing costs from a climate-related catastrophe:
*  The damaged property must be the primary residence of the claimant
*  The claimant/claimants must either own or rent the property
*  The property must not be utilised for business purposes

To file a claim in relation to temporary housing costs from a climate-related catastrophe:
*  The damaged property must be the primary residence of the claimant
*  The claimant/claimants must either own or rent the property
*  The property must not be utilised for business purposes
*  The property must be assessed as uninhabitable prior to repairs

For all claims, the claimant must be unable to create a claim with a commercial insurance company (Channels, 2022).

## __2.2 Coverage__  
The program covers all repair costs associated with property damage claims for owner occupied primary residences, all essential equipment repair/replacement costs (luxury goods not included) for both renters and owners of a primary residence and 3-month temporary relocation costs for renters or owners of a primary residence that has been impacted by a disaster substantially.

## __2.3 Voluntary Relocation Incentives__  
Our program incentivises voluntary relocation through a home buyback scheme and rent subsidy scheme for residents in high risk cities of a region (PLANNED RELOCATION, DISASTERS AND CLIMATE CHANGE, 2014).

### __2.3.1 Home Buyback Scheme__
The home buyback scheme produces a predefined number of offers each quarter to a percentage of owner-occupied households to each region's high-risk cities to purchase their house at market price. The bulk of offers occur within the first 10 years of the program to save in disaster displacement related costs long term. Eligibility requirements are the same as the property damage claim requirements and offers are made at the start of each quarter. By accepting the offer, the offeree agrees to moving out of the high risk city into a low risk city within the same region. If an offer is denied, the offer is transferred to another household in the high-risk city.

### __2.3.2 Rent Subsidy Scheme__
The rent subsidy scheme works similarly to the home buyback scheme, however to be eligible, you must be a renter, rather than an owner of your primary residence. Further, much more offers are made as it is more cost effective than buybacks and the bulk of the offers are made over the first 5 years. The subsidy covers 30% of rent costs over 6 months for eligible households that move from a high risk city in their region to a low risk city in their region.

## __2.4 Quantitative/Qualitative Justification__  
By incurring costs from the home buyback and rent subsidy scheme in the short term, we reduce our exposure to disaster displacement costs in the long term. By 2030 it is expected that roughly 70% of individuals living in high risk cities will relocate to low risk cities, resulting in a 70% reduction in exposure to 90% of major disasters, 85% of medium disasters and 75% of minor disasters.

## __2.5 Short Term and Long Term Evaulation__  
As the majority of costs from the buyback and renter scheme occur in the first 5-10 years, a 10 year timeframe was chosen for the short term. In the long term, a 150 year timeframe was chosen to capture the effects of climate change on disaster frequencies.

## __2.6 Key Metrics__  
Key metrics expected to be reported to ensure the objectives of the program are being met are:
*  	In the short term on a _quarterly basis_, monitoring that costs arising from involuntary displacement are decreasing at a sustainable rate.
*  	In the long term on a _quarterly basis_, monitoring whether costs arising from catastrophic climate-related events are substantially less than the costs that would have been expected without the program.
*  	Reporting on a _yearly basis_ over the long term to ensure the costs under the program are less than 10% of Storslysia’s GDP
*  	Monitoring on a _yearly basis_ over the long term which Shared Socioeconomic Pathway (SSP) the world is trending towards.

# __3. Modelling Procedure__
## __3.1 Overall Property Damage Cost__
To model and project the economic costs with and without the policy, the overall damage stemming from catastrophic climate related events must first be projected. This was achieved by first transforming the historical hazard data, calculating expected frequencies, projecting them utilising an SSP projection model, utilising a Compound Poisson model to model frequency and a Gamma GLM model to predict damage costs.

### __3.1.1 Data Transformation__
The Historical Storslysia Hazard Events dataset was utilised for both the frequency and damage cost predictions.  Firstly, all zero cost property damage events were filtered out as our scheme only covers monetary damages. All of the single case hazard events were then summarised into “Heat”, “Wind”, “Water”, “Storm” and “Winter”, similar to (Gissing et al., 2020) and (Psu.edu, 2011). Two events did not fit in these categories hence were discarded from analysis. Refer to the HazardBucketAnalysis sheet in [EDA.xslx](https://github.com/Actuarial-Control-Cycle-Part-A-2023-T1/group-github-pages-erm-evidently-regretting-myprofession/blob/656c2f2bbac5de8d41aec0b371021d8ad34ba5a5/EDA_10032023.xlsx) to view the categories that were assigned to the hazard events.
Further, the property damage costs were adjusted by the real risk-free rate to give us the values in 2021 Pecunias. This can be found under the HazardData sheet in [EDA.xslx](https://github.com/Actuarial-Control-Cycle-Part-A-2023-T1/group-github-pages-erm-evidently-regretting-myprofession/blob/656c2f2bbac5de8d41aec0b371021d8ad34ba5a5/EDA_10032023.xlsx) under the "Ꝕ at 2021 year end" column. Each event’s property damage costs, duration, fatalities, and injuries were then clustered into a “Major”, “Medium" and “Minor” severity category utilising Ward's minimum variance method. Clustering the data between 1991-2020 gave the best results, likely due to technological innovations that occurred around that period resulting in less deaths and fatalities compared to earlier years, complicating the clustering process.  The minor category had 1546 hazard events with the average cost of these events being the lowest of the three while having the second highest duration, lowest deaths and second highest injury averages. The major category had 14 events with the highest cost, highest duration and lowest injuries and deaths. This makes sense as evacuations will tend to occur for these events, preventing major loss of life. Medium events had 19 events with the highest average injuries and deaths and shortest average durations. The various categorisations and analysis for all of the data and for data between 1991-2020 can be found in [Cluster Analysis Pos.xslx](https://github.com/Actuarial-Control-Cycle-Part-A-2023-T1/group-github-pages-erm-evidently-regretting-myprofession/blob/80598ffeec4427994775b0f0c9ac1c45f491ccfd/Cluster%20Analysis%20Pos.xlsx).

### __3.1.2 Frequency Expectation Projections__
To calculate the expected frequencies of catastrophic disaster events in 2020 that caused property damage, the historical number of major, medium, and minor events between 1991-2020 were counted for each hazard category, region, and quarter, then annualised. These were then multiplied by a risk amplification factor calculated as the change in atmospheric CO2 in 10-year intervals between 2020-2150 in 4 different SSP scenarios to make a future projection. Four SSP scenarios were assessed, SSP-1-2.6 being a low emission scenario, SSP2-3.4 being a medium emission scenario, SSP3-6.0 being a high emission scenario and SSP5-Baseline being a very high emission scenario. These projections were then linearly interpolated for each year under the assumption that expected frequency is a linear, constantly changing process. This ultimately results in the expected frequencies of categorically different hazard events in each year, quarter, and region for three different severity levels between 2020 and 2150 which caused property damage. The linearly interpolated data can be found in [InterpolatedExpectations.csv](https://github.com/Actuarial-Control-Cycle-Part-A-2023-T1/group-github-pages-erm-evidently-regretting-myprofession/blob/bcdee11238cdd7684b49bf17ba9b6b092e491214/InterpolatedExpectations.csv)
Further, it was assumed that within each region, there were high risk cities, medium risk cities and low risk cities. Each city type has a different distribution of disasters based on severity level. These proportions were multiplied onto the expected frequency projections to obtain the expected frequencies in each of these city types additionally.

### __3.1.3 Frequency Simulation__
A compound Poisson process was chosen to model the frequencies of disaster events for Storslysia. It was chosen due to its simplicity in incorporating the expected projections from the SSP model and its effectiveness in modelling event frequencies.

$$ CompPois(λ_Y) = 	{\Sigma Pois(λ_{HYQRCS})} $$

Here the compound process for any given year is the sum of independent Poisson processes with parameters $$ λ_{HYQRCS} $$ which refers to the previously projected expected frequencies for each categorically different hazard event in each year, quarter, region, and city risk type for three different severity levels.

### __3.1.4 Damage Modelling__
The Historical Storslysia Hazard Events dataset with positive claims from 1991-2020 was utilised to train and test various models with the logarithmic 2021 adjusted property damage figures as the dependent variable. The models tested include a Gamma generalised linear model, zero adjusted Gamma (ZAGA) and zero adjusted Inverse Gaussian (ZAIG) generalised additive models due to their practicality when modelling claim cost data (Resti, 2013). During testing it was found that including the year as an independent variable resulted in major increases to RMSE measures while only slightly reducing AIC and BIC levels, hence it was excluded. Further, injuries, fatalities and duration were already captured during severity categorization; hence they were not included in the model. Ultimately the dependent variables were the hazard category, quarter, region, and severity level. Of all the models, Gamma had the best AIC of 5573.195 and BIC of 5655.442 while maintaining the lowest RMSE of 49844863.149, hence it was chosen. The associated R code can be found in [SeverityModelling.R](https://github.com/Actuarial-Control-Cycle-Part-A-2023-T1/group-github-pages-erm-evidently-regretting-myprofession/blob/9890334a424a6c383255e519684dbe880b532ac9/SeverityModelling.R)

### __3.1.5 Simulating Projected Property Damage from Disasters__
Projected property damage cost from disasters were simulated by first generating random values utilising the individual components of the compound Poisson frequency model. These values would serve as a single simulation of the frequencies of each categorically different hazard event in each year, quarter, region, and city risk type for three different severity levels. The corresponding costs of each of these disasters would then be calculated by the Gamma damage model and multiplied to obtain a simulation of the total projected property damage from disasters.

## __3.2 Projection of Economic Costs__
When projecting the economic costs of the catastrophic climate related events in the future, only damages to essential property and equipment were considered, in line with the program. This is to ensure a fair comparison between the economic costs without the program and with the program.

### __3.2.1 Without the Program__
The three main economic costs without the program are the owner-occupied property damage, renter/owner equipment damage and the temporary housing costs that occur during disaster recovery efforts.

$$ EconomicCost = {OwnerOccupiedPropertyDamage + Renter/OwnerEquipmentDamage} $$

$$ {+ TempHousingCost} $$

#### __3.2.1.1 Owner-occupied Property Damage__
Owner-occupied property damage is calculated per region by multiplying the total projected property damage from disasters by the owner-occupied house percentage which is assumed to be constant without the program. Further for minor severity events, a uniformly distributed value for a labour surge increase between 0-15% is produced. For medium severity events this surge is between 15-30% and for major severity events between 30-50%. This is as (Team, 2019) suggests that the severity and size of an event directly impacts the probability of a labour surge.

$$ OwnerOccupiedPropertyDamage = TotalProjectedPropertyDamage * LabourSurgeIncrease $$

$$ * {OwnerOccupiedHouses\over NumberofHouses} $$

#### __3.2.1.2 Renter/Owner Equipment Damage__
Renter/Owner Equipment Damage is calculated per region by generating a uniformly distributed value between 45-70% and multiplying this by total projected property damage from disasters. This value is then multiplied by the renter-and-owner-occupied housing percentage to account for its exposure to only renters and owners.

$$ Renter/OwnerOccupiedEquipmentDamage = TotalProjectedPropertyDamage  $$

$$ {*{(OwnerOccupiedHouses+RenterOccupiedHouses)\over NumberofHouses} * EquipmentValueProportion} $$

#### __3.2.1.3 Temporary Housing Costs__
For temporary housing, the amount of affected houses is first calculated by dividing the total projected property damage in each region by its respective median house price. As it was assumed that if 25% of a house is destroyed on average, then temporary housing is required for its inhabitants, we multiply this figure by 4. We then multiply this by the average number of people per household, the average cost of temporary housing per month and by 3 months as we assume it takes approximately three months to recover.

$$ TemporaryHousingCost = {TotalProjectedPropertyDamage\over MedianHousePrice} * 4 * AvgPeoplePerHousehold $$

$$  * AverageTempHousingCost * 3 $$

### __3.2.2 With the Program__
The three main costs without the program are still present within the program, however the exposure to them is reduced through the buyback and rent subsidy scheme. The owner exposure factors are calculated as the change in the number of owner households from the base case year 2020. They can be found in [Migration Model.xslx](https://github.com/Actuarial-Control-Cycle-Part-A-2023-T1/group-github-pages-erm-evidently-regretting-myprofession/blob/ab9c99a7e679b6035c5924956b99b1cf755b3c69/Migration%20Model.xlsx) under the "OwnerExposure" sheet. Similarly, the renter/owner exposure factors are calculated as the change in the number of owner and renter households from the base case year 2020 and can be found under the [Migration Model.xslx](https://github.com/Actuarial-Control-Cycle-Part-A-2023-T1/group-github-pages-erm-evidently-regretting-myprofession/blob/ab9c99a7e679b6035c5924956b99b1cf755b3c69/Migration%20Model.xlsx) "Exposure Factors" sheet. These factors multiply the owner-occupied house percentages and owner and renter occupied house percentages respectively to reflect the change in exposure to these risks for individuals who move from a high-risk city to a low-risk city within a region. Additionally, costs are introduced for the buyback and rent subsidy schemes.

$$ {EconomicCost_P} = {OwnerOccupiedPropertyDamage * OwnerExposureFactor} $$

$$  + Renter/OwnerEquipmentDamage * Rent/OwnerExposureFactor $$

$${+ TemporaryHousingCosts + BuybackCost + RentSubsidyCost} $$

#### __3.2.2.1 Buyback Cost__
The buyback cost is calculated as the number of offers sent in each quarter to high-risk houses in each region multiplied by the median house price in each region.

$$ BuybackCost = {NumberOfBuybackOffers * MedianHousePrice} $$

The calculated costs can be found under the [Migration Model.xslx](https://github.com/Actuarial-Control-Cycle-Part-A-2023-T1/group-github-pages-erm-evidently-regretting-myprofession/blob/ab9c99a7e679b6035c5924956b99b1cf755b3c69/Migration%20Model.xlsx) "Buyback Cost" sheet.

#### __3.2.2.2 Rent Subsidy Cost__
The rent subsidy cost is similarly calculated, however as it is a subsidy for 6 months, it is multiplied by 0.3 as only 30% of the rent price is paid and costs occur for the quarter in which the offer was accepted as well as the following quarter

$$ RentSubsidyCost = {NumberOfRentOffers * MedianRentPrice * 0.3} $$

The calculated costs can be found under the [Migration Model.xslx](https://github.com/Actuarial-Control-Cycle-Part-A-2023-T1/group-github-pages-erm-evidently-regretting-myprofession/blob/ab9c99a7e679b6035c5924956b99b1cf755b3c69/Migration%20Model.xlsx) "Rent Subsidy" sheet.

# __4. Pricing and Costs__
Assessing the pricing and economic costs associated with the scheme is integral to ensuring its success. To achieve this, Storslysias’ economics costs were modelled and projected from the years 2020-2150 for all quarters 1000 times. Refer to [1000sim.r](https://github.com/Actuarial-Control-Cycle-Part-A-2023-T1/group-github-pages-erm-evidently-regretting-myprofession/blob/657d83efa813cc427f38425929139fb83fd37d92/1000sim.R) for the R code generating the simulations. The averages of these costs were then taken and the following results were produced. Refer to [NoPolicyAverageCosts.csv](https://github.com/Actuarial-Control-Cycle-Part-A-2023-T1/group-github-pages-erm-evidently-regretting-myprofession/blob/a2b451223d5d465e60e5458a9afef0997923521f/No%20Policy%20Average%20Costs.csv) and [PolicyAverageCosts.csv](https://github.com/Actuarial-Control-Cycle-Part-A-2023-T1/group-github-pages-erm-evidently-regretting-myprofession/blob/a2b451223d5d465e60e5458a9afef0997923521f/Policy%20Average%20Costs.csv) to view the generated average costs with and without the policy after 1000 simulations.  All costs are in 2021 figures.


## __4.1 Short Term with Program Economic Costs vs Without Program__  
In the short term, the costs across all SSP scenarios associated with the program are much higher than without the program. This can be attributed to the large buyback and rent costs which occur in the short term. A clear downtrend in costs with the program is observed as less buyback and rent offers are made and costs from emergency relocation are reduced. The non-program costs do not experience any clear trends in the short term. Both experience seasonality with costs spiking in the third quarter of each year. This is visualized in the following figure.

![ShortTermCostComparison](https://raw.githubusercontent.com/Actuarial-Control-Cycle-Part-A-2023-T1/group-github-pages-erm-evidently-regretting-myprofession/9442ce1b9854f755e03fd8cf0584db69275d9377/ShortTermCostComparison.png)

## __4.2 Long term with Program Economic Costs vs Without Program__  
Over the long term, it is clear that the with policy SSP scenarios experience far less costs between the years 2030 to 2150 than their without policy counterparts. This is especially prevalent in the very high emissions SSP scenario which reaches costs nearing 8 billion Ꝕ by 2150 whilst with the policy it reaches about 2 billion Ꝕ. The very high and high emissions scenarios experience an uptrend after 2030, while the low and medium emissions scenarios experience an uptrend until around 2080 before down trending after that. This impacts the effectiveness of the program for the low and medium scenario as in the long term, the economic costs without the program decrease, making the initial investment into the buyback scheme less effective as the cost reduction becomes smaller. This is visualized in the following figure.

![LongTermCostComparison](https://raw.githubusercontent.com/Actuarial-Control-Cycle-Part-A-2023-T1/group-github-pages-erm-evidently-regretting-myprofession/9442ce1b9854f755e03fd8cf0584db69275d9377/LongTermCostComparison.png)

## __4.3 Capital Requirements for Solvency__  
The average simulated cost was summarised in aggregate, where positive cash flows stem from initial capital and regular capital injections, negative cash flows are the simulated costs. The methodology adopted to determine capital requirements was the set of reasonable values such that at least 995 of the 1000 simulations produced a net positive cash flow under all climate change scenarios. This provides a 99.5% confidence in the solvency of the scheme. In order to reduce the solution space of capital the regular injection was fixed. The initial capital was then set as below (Ꝕ 1,000’s):

----- | WithScheme | Without Scheme
-----|-----|------
Initial Capital | 15,000,000 | 15,000,000 |
Yearly Capital | 1,384,190 | 3,858,250 |

The calculations of average per year costs were performed here [RuinModelWithPolicy.xlsx](https://github.com/Actuarial-Control-Cycle-Part-A-2023-T1/group-github-pages-erm-evidently-regretting-myprofession/blob/7cf192a3cdcafe2e12e48627d05ecdc9cf12e9f0/RuinModel_Policy_22032023.xlsx) and [RuinModelWithoutPolicy.xlsx](https://github.com/Actuarial-Control-Cycle-Part-A-2023-T1/group-github-pages-erm-evidently-regretting-myprofession/blob/7cf192a3cdcafe2e12e48627d05ecdc9cf12e9f0/RuinModel_NoPolicy_22032023.xlsx).

## __4.4 Contrasting Voluntary vs Emergency Displacement Costs with Program__  
Clearly, voluntary costs are much higher in the short term due to the buyback and renting schemes, however, they quickly decrease and by 2030 are near zero. This results in the initial downtrend in short-term emergency displacement costs. After 2030, emergency displacement costs begin to rise for the very high and high emissions scenarios, while the medium scenario remains relatively stable, and the low emissions scenario remains stable up until about 2080 where a slight downtrend is observed. Emergency displacement costs with the program experience similar trends as without the program, however at a far reduced economic cost level; following the bulk of the relocation under the program. This is visualized in the following figure.

![DisplacementCostComparison](https://raw.githubusercontent.com/Actuarial-Control-Cycle-Part-A-2023-T1/group-github-pages-erm-evidently-regretting-myprofession/9442ce1b9854f755e03fd8cf0584db69275d9377/DisplacementCostComparison.png)

# 5. Assumptions
## __5.1 Key Assumptions__ 
  1.  Economic conditions are stable for 2021 onwards. This includes GDP, costs for temporary relocation and inflation in the labour, house and private rental markets. This is to avoid the uncertainty brought by performing economic forecasts and to reduce the complexity of models.
  2.	It is assumed that each region is split into city risk areas of: high, medium and low with areas being evenly distributed across the region based on the FEMA risk index map (hazards.fema.gov, n.d.). Refer to the following figure.
 
![Figure 4 1](https://user-images.githubusercontent.com/107458550/229771640-095c7cc7-788e-427c-ba47-2f2ac3caf4aa.png)


  3.	The frequency of hazard event estimates is based on post 1991 historical data to reduce model instability. It is assumed that technological advancements within this time frame have led to reduced fatalities, injuries and increased resistance and resilience to disasters. These innovations lead us to consider data prior to 1991 to not be an adequate representation of future trends.
  4.	It is assumed that the hazard event frequency in each year, quarter, risk level area, region and with different hazard categories is independently Poisson distributed.
  5.	Labour cost surge is assumed to be uniformly distributed.  For a major event, the increase is between 35% to 50%, for a medium event, 15% to 30% and for a minor event, the increase is between 0 to 15%.  Similarly, the equipment damage cost increase is assumed to be uniformly distributed between 40% to 70%.

## __5.2 Other assumptions__ 
*  Proportions of owner-occupied properties and renter-occupied properties will be constant in the absence of the policy
*  Houses that are damaged by a natural hazard will be repaired or rebuilt in the same location
*  The expected frequency of disasters is a linear, constantly changing process within the 10-year intervals provided by the SSP model. 
*  The severity of events will be more highly distributed in riskier areas
*  All buyback and rent offers that are extended to Storlysian residents are accepted


# 6. Risk and Risk Mitigation Considerations
![Risk Assessment Chart](https://user-images.githubusercontent.com/129591024/229504622-ee4688a0-3013-4579-a6e7-c919d0c57c4a.png)
Refer to [Risk Register.pdf](https://github.com/Actuarial-Control-Cycle-Part-A-2023-T1/group-github-pages-erm-evidently-regretting-myprofession/files/11138147/Risk.Register.pdf) for comprehensive risk categorization.  
## __6.1 Key risks__  
###  __6.1.1 Model Risk__  
The model parameters are built on historical trends. A deviation in the assumed relocation acceptance rate will affect the short and long-term costs of the policy.  
* __6.1.1.1 Analysis__  
The sensitivity of the model to a change in assumptions was performed by adjusting the relocation acceptance rates and performing 100 simulations under the Very High Emissions scenario. The associated R code can be found in [Risk Table Plot.R](https://github.com/Actuarial-Control-Cycle-Part-A-2023-T1/group-github-pages-erm-evidently-regretting-myprofession/blob/c26ace1be3a65ed1f86e1d237c41800f6ae3a7f6/Risk%20table%20plot.R) .  
The migration scenarios can be found in [Migration Model Up.xslx](https://github.com/Actuarial-Control-Cycle-Part-A-2023-T1/group-github-pages-erm-evidently-regretting-myprofession/blob/7d49c0f3b11ad53f65c8ea17a3d3be8f9aaf32ba/Migration%20Model%20Up.xlsx) and [Migration Model Down.xslx](https://github.com/Actuarial-Control-Cycle-Part-A-2023-T1/group-github-pages-erm-evidently-regretting-myprofession/blob/7d49c0f3b11ad53f65c8ea17a3d3be8f9aaf32ba/Migration%20Model%20Down.xlsx) under the "Migration Model (2)" and "Renter Migration Model 2" sheets.

Sensitivity Scenario | Impact
-----|------
-1% initial relocation acceptance rate | Short term costs: -10 billion dollars<br/>Long term costs: +30 billion dollars |
+1% initial relocation acceptance rate | Short term costs: +10 billion dollars<br/>Long term costs: -30 billion dollars | 

![Sensitivity Analysis on Projected Costs under VH Scenario](https://user-images.githubusercontent.com/129591024/229513802-5e0bcde6-f5b2-4a92-ac1f-374219b01c68.png)  

* __6.1.1.2 Mitigation__  
Careful monitoring of the actual vs expected costs year on year will allow the team to adjust the model parameters to better reflect the relocation appetite of Storslysian residents.  

###  __6.1.2 Public Backlash__  
Residents living in high-risk areas can view the policy as a forceful method to evict homeowners. Additionally, residents and politicians may lobby against the policy as they may advocate against taxpayer-funded social insurance programs. This can cause the implementation of the scheme to be negatively impacted if it faces resistance from the population of Storslysia.  
* __6.1.2.1 Analysis__  
Public backlash can lead to lower relocation acceptance rates and funding difficulties. We deemed the likelihood of this risk to be relatively high with the impact to be middling. 
* __6.1.2.2 Mitigation__  
Public education on the policy and its key benefits and risks to better inform the public of the benefits of relocation. Consistent promotion of the policy through multiple mediums of communication will increase exposure and awareness of the scheme.  


###  __6.1.3 Extreme Climate Change__  
The frequency and severity of natural disasters are greatly impacted by climate change. This, in turn, can exacerbate the damages and costs incurred by the government.  
In the event of extreme climate change, the sustained costs can be extremely high and possibly un-operable.  
* __6.1.3.1 Analysis__  
The model looks at cost projections for four emission scenarios. The Very High emission scenario emphasises uncontrolled climate change growth which would greatly increase the frequency and severity of catastrophic events. (Refer to Figure 5.4). This scenario would result in extreme projected losses year on year for Storslysia from 2050 onwards. The associated R code can be found in [Risk Table Plot.R](https://github.com/Actuarial-Control-Cycle-Part-A-2023-T1/group-github-pages-erm-evidently-regretting-myprofession/blob/c26ace1be3a65ed1f86e1d237c41800f6ae3a7f6/Risk%20table%20plot.R)  .
![Projected costs under different emissions scenarios](https://user-images.githubusercontent.com/129591024/229518402-5b975e91-4821-4c15-8bd8-bb91538fe9b3.png)  

* __6.1.3.2 Mitigation__  
Increased coverage of the buyback scheme can further mitigate some costs if we foresee uncontrolled progression into a Very High emissions scenario. This risk can be periodically monitored to allow proactive updates to the scheme.  


## 6.2 Economic Cost Reduction Certainty  
After running 1000 simulations, it has been identified that in the short term, the economic costs under the policy are more than the economic costs without the policy. This is due to the large costs incurred by the relocation incentive programs. In the long term however, the low emissions scenario has costs under the program less 75.2% of the time, the medium emissions scenario 96.3% of the time and the high and very high scenarios 100% of the time. This indicates that running the program in the low emissions scenario is quite risky hence it is not recommended to undertake the plan in its current state in this scenario. On the other hand, the medium, high and very high emissions scenarios pose very little to no risk. In the medium scenario where loss cases do occasionally occur, the difference in losses is on average -1,169,681.57Ꝕ  while the difference where cost reductions occur is on average 6,569,105.61Ꝕ . In conjunction with global climate reports from (IPCC, 2023a) it is recommended that the program be adopted and adapted in line with actuarial monitoring and judgement. Alternatively, the Storslysian government may want to consider implementing a voluntary retrofitting scheme rather than a voluntary relocation scheme if they deem the risk too high or a mixture of both (NSW, 2022). This scheme would consist of upgrading houses in areas of high risk to reduce the impact of natural disasters, in turn reducing costs.  

## 6.3 Program GDP Constraint Certainty  
After running 1000 simulations, program costs in all scenarios short and long term do not exceed the 10% GDP constraint 100% of the time.  

# 7. Data and Data Limitations
## 7.1 Truncation of Historical Data
Historical events aren’t necessarily an accurate indicator of future events. As such, events prior to 1991 introduced instability in the frequency and severity models. We reason that technological advancements between 1991-2020 led to reduced fatalities, injuries and increased resistance and resilience to disasters. As such data prior to 1991 was truncated for the sake of analysis.  

## 7.2 Property Damage Definition
Property damage was assumed to entirely consist of damage to residential properties as there was insufficient data to differentiate the cost source. As a result, damage to belongings and other property had to be considered separately.  

## 7.3 Hazard Type Data
Multiple hazard categorisations being assigned to the same event caused uncertainty in the cluster analysis. As a result, the more severe hazard type took priority when analyzing the historical data.  

## 7.4 Inter-regional risk profiles
The supplied data only contained information pertaining to 6 regions in Storslysia and not granular data such as cities. As a result, it was assumed that each region consisted of 5% high-risk cities, 10% medium-risk cities and 85% low-risk cities as based on the US FEMA national risk index map (hazards.fema.gov, n.d.). Further, it was assumed that high-risk cities experience 90% of the major disasters, 85% of the medium disasters and 75% of the minor disasters, medium-risk cities experience 9.5% of the major disasters, 12.5% of the medium disasters and 20% of the minor disasters while the low-risk cities experience 0.5% of the major disasters, 2.5% of the medium disasters and 0.5% of the major disasters.  


# 8. Bibliography  
Bureau, U.C. (n.d.). In 2020, 9.7% of Housing Was Vacant, Down From 11.4% in 2010. [online] Census.gov. Available at: https://www.census.gov/library/stories/2021/08/united-states-housing-vacancy-rate-declined-in-past-decade.html.

Channels, N.G.D. (2022). Emergency financial support for people affected by floods. [online] NSW Government. Available at: https://www.nsw.gov.au/floods/financial-support/people.

hazards.fema.gov. (n.d.). National Risk Index . FEMA.gov. [online] Available at: https://hazards.fema.gov/nri/.

Insurance Council Australia (n.d.). Flood insurance explained. [online] Insurance Council of Australia. Available at: https://insurancecouncil.com.au/resource/flood-insurance-explained/.

IPCC (2023a). Sixth Assessment Report Synthesis Report. [online] Available at: https://report.ipcc.ch/ar6syr/pdf/IPCC_AR6_SYR_SlideDeck.pdf.

IPCC (2023b). [online] Ipcc.ch. Available at: https://www.ipcc.ch/report/ar6/syr/downloads/figures/summary-for-policymakers/IPCC_AR6_SYR_SPM_Figure5.png
[Accessed 23 Mar. 2023].

Kwan, A. (2021). Demand surge and storm surge: the waves wiping out your supply chains . Swiss Re. [online] corporatesolutions.swissre.com. Available at: https://corporatesolutions.swissre.com/insights/knowledge/climate-change-supply-chains-risk-intersection.html 
[Accessed 28 Feb. 2023]. Risk Mitigation (reducing demand surge after CAT events).

Macrotrends (2020). U.S. GDP 1947-2020. [online] Macrotrends.net. Available at: https://www.macrotrends.net/countries/USA/united-states/gdp-gross-domestic-product 
[Accessed 19 Mar. 2023].

Macrotrends (2023). U.S. Trade Balance 1970-2020. [online] www.macrotrends.net. Available at: https://www.macrotrends.net/countries/USA/united-states/trade-balance-deficit 
[Accessed 19 Mar. 2023].

NSW, D. of R. (2022). Resilient Homes Program. [online] NSW Government. Available at: https://www.nsw.gov.au/regional-nsw/northern-rivers-reconstruction-corporation/resilient-homes-fund/resilient-homes-program 
[Accessed 23 Mar. 2023].

OECD (2011). Forecasting methods and analytical tools - OECD. [online] www.oecd.org. Available at: https://www.oecd.org/economy/outlook/forecastingmethodsandanalyticaltools.htm
[Accessed 19 Mar. 2023].

Paddam, S., Liu, C. and Philip, S. (2022). Home insurance affordability and socioeconomic equity in a changing climate. [online] Available at: https://actuaries.asn.au/Library/Opinion/2022/HIAGreenPaper.pdf.


PLANNED RELOCATION, DISASTERS AND CLIMATE CHANGE: CONSOLIDATING GOOD PRACTICES AND PREPARING FOR THE FUTURE REPORT DISASTERS CLIMATE CHANGE AND DISPLACEMENT EVIDENCE FOR ACTION NRC NORWEGIAN REFUGEE COUNCIL. (2014). Available at: https://www.unhcr.org/54082cc69.pdf.

Psu.edu. (2011). What is a Natural Hazard? . GEOG 30N: Environment and Society in a Changing World. [online] Available at: https://www.e-education.psu.edu/geog30/node/378
[Accessed 6 Mar. 2023].

Resti (2013). ESTIMATION OF CLAIM COST DATA USING ZERO ADJUSTED GAMMA AND INVERSE GAUSSIAN REGRESSION MODELS. Journal of Mathematics and Statistics, [online] 9(3), pp.186–192. Available at: https://thescipub.com/pdf/jmssp.2013.186.192.pdf
[Accessed 23 Mar. 2023].

Schuster, S., Palutikof, J., Boulter, S., Ash, A., Smith, S. and Parry, M. (2013). Natural hazards and insurance. [online] John Wiley & Sons, pp.133–140. Available at: https://www.aph.gov.au/DocumentStore.ashx?id=c768fac3-993a-402b-9bbb-ebc669ad3764 
[Accessed 27 Feb. 2023].

Team, I. (2019). How Demand Surge After Natural Disasters Impacts the Cost and Timing of Recovery. [online] CoreLogic®. Available at: https://www.corelogic.com/intelligence/how-demand-surge-after-natural-disasters-impacts-the-cost-and-timing-of-recovery/ 
[Accessed 28 Feb. 2023]. (Demand surge assumptions/parameters).

UCAR (2019). How Tornadoes Form . UCAR Center for Science Education. [online] Ucar.edu. Available at: https://scied.ucar.edu/learning-zone/storms/how-tornadoes-form.

www.fema.gov. (n.d.). National Flood Insurance Program Community Rating System . FEMA.gov. [online] Available at: https://www.fema.gov/floodplain-management/community-rating-system.
 
