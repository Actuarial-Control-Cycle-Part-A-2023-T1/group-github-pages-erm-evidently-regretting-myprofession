# __Simulation of Future Economic Costs Methodology__
## __1. Overall Property Damage Cost__
To model and project the economic costs with and without the policy, the overall damage stemming from catastrophic climate related events must first be projected. This was achieved by first transforming the historical hazard data, calculating expected frequencies, projecting them utilising an SSP projection model, utilising a Compound Poisson model to model frequency and a Gamma GLM model to predict damage costs.

### __1.1 Data Transformation__
The Historical Storslysia Hazard Events dataset was utilised for both the frequency and damage cost predictions.  Firstly, all zero cost property damage events were filtered out as our scheme only covers monetary damages. All of the single case hazard events were then summarised into “Heat”, “Wind”, “Water”, “Storm” and “Winter”, similar to (Gissing et al., 2020) and (Psu.edu, 2011). Two events did not fit in these categories hence were discarded from analysis.  Further, the property damage costs were adjusted by the real risk-free rate to give us the values in 2021 Pecunias. Each event’s property damage costs, duration, fatalities, and injuries were then clustered into a “Major”, “Medium" and “Minor” severity category utilising Ward's minimum variance method. Clustering the data between 1991-2020 gave the best results, likely due to technological innovations that occurred around that period resulting in less deaths and fatalities compared to earlier years, complicating the clustering process.  The minor category had 1546 hazard events with the average cost of these events being the lowest of the three while having the second highest duration, lowest deaths and second highest injury averages. The major category had 14 events with the highest cost, highest duration and lowest injuries and deaths. This makes sense as evacuations will tend to occur for these events, preventing major loss of life. Medium events had 19 events with the highest average injuries and deaths and shortest average durations.

### __1.2 Frequency Expectation Projections__
To calculate the expected frequencies of catastrophic disaster events in 2020 that caused property damage, the historical number of major, medium, and minor events between 1991-2020 were counted for each hazard category, region, and quarter, then annualised. These were then multiplied by a risk amplification factor calculated as the change in atmospheric CO2 in 10-year intervals between 2020-2150 in 4 different SSP scenarios to make a future projection. Four SSP scenarios were assessed, SSP-1-2.6 being a low emission scenario, SSP2-3.4 being a medium emission scenario, SSP3-6.0 being a high emission scenario and SSP5-Baseline being a very high emission scenario. These projections were then linearly interpolated for each year under the assumption that expected frequency is a linear, constantly changing process. This ultimately results in the expected frequencies of categorically different hazard events in each year, quarter, and region for three different severity levels between 2020 and 2150 which caused property damage. Further, it was assumed that within each region, there were high risk cities, medium risk cities and low risk cities. Each city type has a different distribution of disasters based on severity level. These proportions were multiplied onto the expected frequency projections to obtain the expected frequencies in each of these city types additionally.

### __1.3 Frequency Simulation__
A compound Poisson process was chosen to model the frequencies of disaster events for Storslysia. It was chosen due to its simplicity in incorporating the expected projections from the SSP model and its effectiveness in modelling event frequencies.

$$ CompPois(λ_Y) = 	{\Sigma Pois(λ_{HYQRCS})} $$

Here the compound process for any given year is the sum of independent Poisson processes with parameters $λ_{HYQRCS}$ which refers to the previously projected expected frequencies for each categorically different hazard event in each year, quarter, region, and city risk type for three different severity levels.

### __1.4 Damage Modelling__
The Historical Storslysia Hazard Events dataset with positive claims from 1991-2020 was utilised to train and test various models with the logarithmic 2021 adjusted property damage figures as the dependent variable. The models tested include a Gamma generalised linear model, zero adjusted Gamma (ZAGA) and zero adjusted Inverse Gaussian (ZAIG) generalised additive models due to their practicality when modelling claim cost data (Resti, 2013). During testing it was found that including the year as an independent variable resulted in major increases to RMSE measures while only slightly reducing AIC and BIC levels, hence it was excluded. Further, injuries, fatalities and duration were already captured during severity categorization; hence they were not included in the model. Ultimately the dependent variables were the hazard category, quarter, region, and severity level. Of all the models, Gamma had the best AIC of 5573.195 and BIC of 5655.442 while maintaining the lowest RMSE of 49844863.149, hence it was chosen. 

### __1.5 Simulating Projected Property Damage from Disasters__
Projected property damage cost from disasters were simulated by first generating random values utilising the individual components of the compound Poisson frequency model. These values would serve as a single simulation of the frequencies of each categorically different hazard event in each year, quarter, region, and city risk type for three different severity levels. The corresponding costs of each of these disasters would then be calculated by the Gamma damage model and multiplied to obtain a simulation of the total projected property damage from disasters.

## __2. Projection of Economic Costs__
When projecting the economic costs of the catastrophic climate related events in the future, only damages to essential property and equipment were considered, in line with the program. This is to ensure a fair comparison between the economic costs without the program and with the program.

### __2.1 Without the Program__
The three main economic costs without the program are the owner-occupied property damage, renter/owner equipment damage and the temporary housing costs that occur during disaster recovery efforts.

$$ EconomicCost = {OwnerOccupiedPropertyDamage + Renter/OwnerEquipmentDamage + TempHousingCost} $$

#### __2.1.1 Owner-occupied Property Damage__
Owner-occupied property damage is calculated per region by multiplying the total projected property damage from disasters by the owner-occupied house percentage which is assumed to be constant without the program. Further for minor severity events, a uniformly distributed value for a labour surge increase between 0-15% is produced. For medium severity events this surge is between 15-30% and for major severity events between 30-50%. This is as (Team, 2019) suggests that the severity and size of an event directly impacts the probability of a labour surge.

$$ OwnerOccupiedPropertyDamage = TotalProjectedPropertyDamage * LabourSurgeIncrease * {OwnerOccupiedHouses\over NumberofHouses} $$

#### __2.1.2 Renter/Owner Equipment Damage__
Renter/Owner Equipment Damage is calculated per region by generating a uniformly distributed value between 45-70% and multiplying this by total projected property damage from disasters. This value is then multiplied by the renter-and-owner-occupied housing percentage to account for its exposure to only renters and owners.

$$ Renter/OwnerOccupiedEquipmentDamage = TotalProjectedPropertyDamage * {(OwnerOccupiedHouses+RenterOccupiedHouses)\over NumberofHouses} $$

$$ {* EquipmentValueProportion} $$

#### __2.1.3 Temporary Housing Costs__
For temporary housing, the amount of affected houses is first calculated by dividing the total projected property damage in each region by its respective median house price. As it was assumed that if 25% of a house is destroyed on average, then temporary housing is required for its inhabitants, we multiply this figure by 4. We then multiply this by the average number of people per household, the average cost of temporary housing per month and by 3 months as we assume it takes approximately three months to recover.

$$ TemporaryHousingCost = {TotalProjectedPropertyDamage\over MedianHousePrice} * 4 * AvgPeoplePerHousehold * AverageTempHousingCost * 3 $$

### __2.2 With the Program__
The three main costs without the program are still present within the program, however the exposure to them is reduced through the buyback and rent subsidy scheme. The owner exposure factors are calculated as the change in the number of owner households from the base case year 2020. Similarly, the renter/owner exposure factors are calculated as the change in the number of owner and renter households from the base case year 2020. These factors multiply the owner-occupied house percentages and owner and renter occupied house percentages respectively to reflect the change in exposure to these risks for individuals who move from a high-risk city to a low-risk city within a region. Additionally, costs are introduced for the buyback and rent subsidy schemes.

$$ {EconomicCost_P} = {OwnerOccupiedPropertyDamage * OwnerExposureFactor + Renter/OwnerEquipmentDamage * Rent/OwnerExposureFactor} $$

$${+ TemporaryHousingCosts + BuybackCost + RentSubsidyCost} $$

#### __2.2.1 Buyback Cost__
The buyback cost is calculated as the number of offers sent in each quarter to high-risk houses in each region multiplied by the median house price in each region.

$$ BuybackCost = {NumberOfBuybackOffers * MedianHousePrice} $$

#### __2.2.2 Rent Subsidy Cost__
The rent subsidy cost is similarly calculated, however as it is a subsidy for 6 months, it is multiplied by 0.3 as only 30% of the rent price is paid and costs occur for the quarter in which the offer was accepted as well as the following quarter

$$ RentSubsidyCost = {NumberOfRentOffers * MedianRentPrice * 0.3} $$
