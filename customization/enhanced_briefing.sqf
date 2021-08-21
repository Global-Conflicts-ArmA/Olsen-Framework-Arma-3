//AUTHOR: Based upon Perfks briefing, edited by: Pax'Jarome
//-----------------------------------------------------
//!!!IMPORTANT NOTICE!!!
//Understand the fact, that you, as a mission maker, are writing this OPORD as if you are the mission COs superior.
//Therefore this 'briefing' is chosen to represent the OPORD format usually given to Platoon Leaders, which themselves will prepare METT-TC based briefings for their subordinates.
//I tried to reassemble the real OPORD structures to the best of my abilities while still keeping in mind points the player needs to know which are not provided with real OPORDS.
//This might be drastically witnessed in the 'I.Situation' tab.
//-----------------------------------------------------
//
// To use markers insert the following:
// <marker name='markerObjectName'>OBJ Alpha</marker>
// make sure the equivalent of 'markerObjectName' exists as a marker placed by you.
//
#include "core\briefingCore.sqf"

switch (side player) do {
	case west:
	{

		NEWTAB("Task Organization:")
		//Understand that the "Unit Organization" is not part of the OPORD.
		//The OPORD starts with point "I. Situation".
		//The tab "Unit Organization" explains the unit mentioned in the OPORD in relation to its next vertical and horizontal elements.
		<br/><font color='#FFA500' size='16' face='PuristaBold'>C Company (C/2-330 INF):</font>
		//Make sure to present horizontal and vertical elements to support the player in realizing his own situation within the unit.
		//Even if these adjascent units are only fictional and are unused in the mission itself.
		<br/>Company CO - C´6
		<br/>Company XO - C´7
		<br/>1st Infantry Platoon - C´1
		<br/>2nd Infantry Platoon - C´2 (You)
		<br/>3rd Infantry Platoon - C´3
		<br/>Heavy Weapons Platoon - C´4
		<br/>
		<br/><font color='#FFA500' size='16' face='PuristaBold'>Compositions and Locations:</font>
		//Provide clear information about the location at minimum,
		//any composition differing from the default unit organization should be mentioned here.
		<br/>Charlie Company (as per unit organization) at South Rasman.
		<br/>C´1 at Rasman South blocking west.
		<br/>C´2 at Rasman South blocking east. (YOU)
		<br/>C´3 at Rasman South blocking and fighting Bastam North.
		<br/>C´4 at Rasman South and 2 squads in supporting positions.
		<br/>
		<br/><font color='#FFA500' size='16' face='PuristaBold'>Attached or Organic Forces:</font>
		//Make sure to present attachments with their actual origin, type and callsign.
		<br/>(A/1-26 SUP) Tactical Air Control Party - Topdown
		<br/>(C/4-33 ART) Fire Support Team - Ironhammer
		<br/>(E/2-65 MED) Ambulance Squad - Lima Papa
		<br/>
		<br/><font color='#FFA500' size='16' face='PuristaBold'>Adjacent Units:</font>
		//Explain from mission maker POV which other horizontal units additionally to yours are present in the area.
		<br/>Alpha Company at Nagara.
		<br/>Bravo Company at Zavarak and Sagram
		<br/>
		ENDTAB;

		NEWTAB("I. Situation:")
		//Here you provide a detailed report of recent important events connected to your OPORD (so your Element, not the mission COs element only).
		<br/>Charlie Company (together with Alpha and Bravo Company) has been inserted into North East Takistan as of T+2Days and has established a defensive Parameter around the NE airfield at 114057.
		<br/>There has been few resistance by the local Insurgents over the past 2 days. Today at sunrise this changed drastically. All three companies have been engaged by insurgent forces at sunrise.
		<br/>So far Charlie 3 Platoon supported by C´4´1 was able to stop and return any Fire into their direction. Attacks onto Charlie Company came from Lalezar Plant to the west and Bastam south.
		<br/>
		<br/><font color='#FFA500' size='16' face='PuristaBold'>a. Areas of Interest:</font>
		//If you have any areas of interest defined name them, their locations and what makes them interesting.
		<br/>Currently only Rasman and Rasman Airport are of any importance to this operations. These areas are to be protected at any time.
		<br/>
		<br/><font color='#FFA500' size='16' face='PuristaBold'>b. Area of Operation:</font>
		//Now all preliminary info about the actual AO is collected and given to the mission CO.
		<br/>
		<br/><font color='#d21111' size='15'>1. Terrain:</font>
		//If in line with the equipment, story and era your mission plays in, provide image intel of the AO
		<br/><img image='res\top.jpg' width='350' />
		<br/><img image='res\3Dthermal.jpg' width='350' />
		<br/>
		<br/><font color='#d21111' size='15'>2. Weather:</font>
		//Provide the current weather situation as you have set in the mission editor attribute options in ArmA3 Eden Editor.
		<br/><font size='14'>CURRENT:</font>
		<br/>Wind: None
		<br/>Rain: None
		<br/>Sun: Bright
		<br/>Sky: Clear
		<br/>Fog: None
		<br/>
		<br/><font size='14'>LIGHT:</font>
		//As per mission attributes, set the following 3 intel parts.
		<br/>All times in local
		<br/>First light: 04:41:55
		<br/>Last Light: 18:54:35
		<br/>Time Now: 11:30:00
		<br/>
		<br/><font size='14'>FORECAST:</font>
		//Make sure to inform the CO if the weather is expected to change over the pass of the operation or if no change is expected.
		<br/>No change in the next 24-48 hours.
		<br/>
		<br/><font size='14'>MOONSTATE:</font>
		//Provide information about the state of the moon (half/full/...) and its light intensity based upon state, weather and cloud coverage.
		<br/>Day Light Operation
		<br/>
		<br/><font size='14'>VISIBILITY:</font>
		//Sandstorms, fog or any condition limiting the view range should be given here. Define a value(!), for example: 'Visibility is decreased by fog; view limited to approximately 100m.'
		<br/>Clear visibility with view to the horizon.
		<br/>
		<br/><font color='#FFA500' size='16' face='PuristaBold'>c. Enemy:</font>
		//If possible provide image intel of the enemy factions/elements loadout or how an individual might dress.
		<br/><img image='res\enemy.jpg' width='200' />
		<br/>
		<br/><font color='#d21111' size='15'>1. Disposition, Composition and Strength:</font>
		<br/><font size='14'>a. DISPOSITION:</font>
		//What exactly do you currently know about the enemy in the AO. All known Intel is material for Disposition and is only found here.
		//If you reference new Intel on another point in the OPORD that is not already mentioned in Disposition or Composition, you made a mistake.
		//Explain all Intel in greatest detail. This is of crucial importance.
		<br/>Current Intel assumes the majority of the enemy force in Bastam Center at 0565-0895. Radio reports from local IDAP forces made clear that the insurgents did not occupy the Mosque and that the local Shaich denied insurgents any access to the mosque area. Reports say that insurgents have sofar respected all orders by the local town chiefs, as the population is armed themselves, it is expected that they will not occupy the HQ when engaged.
		<br/>East Bastam and Falar in the south, are reported to be manned by insurgent forces of unknown type and size. Reconnaissance is still under way and not expected in before tomorrow.
		<br/>
		<br/><font size='14'>b. COMPOSITION:</font>
		//What organic assets for support and reinforcement are available to the enemy? This scales down to the level of mentioning single weapon systems individual soldiers will fight.
		<br/>The insurgent unit comprises out of an unknown amount and type of motorized vehicles and a Platoon minus sized infantry element of mediocre skill armed with eastern block weaponry like AK47s, AKMs, RPG-7s, PKMs and RPKs. From previous engagements and reports by Alpha and Bravo Company we expect them to be Pickup-Mounted MGs, Trucks and other improvised combat vehicles with low to no armour.
		<br/>In before all radios have been taken from IDAP forces they were able to transmit that the insurgents brought a truck with what looked like materials to craft IEDs, consider them using explosive ordnance.
		<br/>Reinforcements qould arrive from East Bastam and Falar within the first 2 hours after the engagement started.
		<br/>
		<br/><font size='14'>c. STRENGTH:</font>
		//Describe how the quantity of enemies at and around the AO will effect the mission COs unit upon time of engagement.
		<br/>The current layout of the enemy units at Bastam Center is unlikely to change upon engagement as all so far known enemy units are bound in contact with Alpha and Bravo Company.
		<br/>If reinforcements depart, we expect no forces larger than 2 Squads with the same weaponry and assets for mobility.
		<br/>
		<br/><font color='#d21111' size='15'>2. Capabilities:</font>
		//Explain the enemies possible actions, include significant capabilities even if they seem unlikely. Any significant weapons systems and how they might be employed. Are there specific vulerabilities of the enemy we can exploit?
		<br/><font size='14'>a. MANEUVER:</font>
		<br/>The enemy has no maneuvering assets with him and is focused on defense.
		<br/>
		<br/><font size='14'>b. FIRE SUPPORT:</font>
		<br/>The insurgent forces might use rear stationed man carried mortars which so far have not been sighted.
		<br/>Near hills might be used by enemy heavy MGs to prevent friendlies from pushing further once they entered Bastam.
		<br/>
		<br/><font size='14'>c. INTELLIGENCE:</font>
		<br/>The enemy has superior knowledge about the terrain in the AO.
		<br/>
		<br/><font size='14'>d. MOBILITY:</font>
		<br/>The enemy might rush civilian vehicles from Falar for a hasty break of contact.
		<br/>
		<br/><font size='14'>e. AIR DEFENSE:</font>
		<br/>NONE.
		<br/>
		<br/><font size='14'>f. COMBAT SERVICE SUPPORT:</font>
		<br/>The only support know of is a truck which additionally to IED building material might host additional ammunition for a prolonged defense.
		<br/>
		<br/><font size='14'>g. COMMAND AND CONTROL:</font>
		<br/>No advanced assets for C2 are known to be in the hands of the insurgents.
		<br/>
		<br/><font color='#d21111' size='15'>3. Enemy Courses of Action:</font>
		<br/><font size='14'>a. MOST LIKELY COURSE OF ACTION (MLCOA):</font>
		//What is the enemy most likely going to do once we engage him?
		<br/>Enemy Forces have dug in and heavily fortified Bastam over night.
		<br/>When faced with overwhelming force the insurgents are likely to abandon Bastam, surrender or go for a fighting retreat.
		<br/>Prepare for EPWs (Enemy Prisoners of War).
		<br/>
		<br/><font size='14'>MOST DANGEROUS COURSE OF ACTION (MDCOA)</font>
		//What is the most dangerous thing the enemy could do and why is it so dangerous for us?
		<br/>Enemy forces will go into a fighting retreat and have prepared a counter attack or Enemy forces will not follow the Schaichs Order and occupy the IDAP HQ taking hostiles or using civilians and IDAP units as shield.
		<br/>In second case Charlie Company has orders to surround but not engage into the IDAP HQ and wait for a Special Operations Force attempt to Raid the HQ and free the hostages.
		<br/>
		<br/><font color='#FFA500' size='16' face='PuristaBold'>d. Friendly Forces:</font>
		//Provide image intel of friendly, allied and/or neutral forces likely to be met in the AO.
		<br/><img image='res\friendly.jpg' width='200' />
		<br/>
		<br/><font color='#d21111' size='15'>1. Higher HQ Mission and Intent:</font>
		//This part includes the information the mission maker received from his superior. It sates the Higher HQs mission intent and concept. Keep this short.
		<br/><font size='14'>a. HIGHER HQ MISSION INTENT:</font>
		<br/>Battalion HQ has issued this operation in north Takistan to stabilize its regions after insurgents flooded Takistan following a governmental collapse.
		<br/>
		<br/><font size='14'>b. HIGHER HQ MISSION CONCEPT:</font>
		<br/>Battalion HQs aim is to use Alpha, Bravo and Charlie Company including attachments to secure a 12 Km foothold region around Bastams airport, to support save insertion of additonal forces.
		<br/>
		<br/><font color='#d21111' size='15'>c. Missions of Adjacent units:</font>
		//List all rear, forward or flank units supporting your operation.
		<br/>Alpha Company at Nagara; Their orders are to maintain position and fend of any insurgents attacks following the once this morning.
		<br/>Bravo Company at Zavarak and Sagram; Their orders are to maintain position and fend of any insurgents attacks following the once this morning.
		<br/><font color='#FFA500' size='16' face='PuristaBold'>e. Attachments  and  Detachments:</font>
		//Do not put info here that is available in the Task Organization.
		<br/>See Task Organization.
		ENDTAB;

		NEWTAB("II. Mission:")
		<br/><font color='#FFA500' size='16' face='PuristaBold'>Mission Intent:</font>
		//This now is your (the mission makers) view onto the mission you made. How do you want the mission CO to accomplish the mission, what is he to accomplish and what are the states.
		//!!!IMPORTANT: If the mission is designed to run multiple units below 'you' their missions and objectives belong in here as well. You will have to adjust II.Mission and III.Execution accordingly.
		<br/>Carlie 2nd Platoon and Attached Forces are to establish a blocking position (with its weapons squad and the attached squad from C´4) east and south from Bastam guarding south and east routes NLT (not later than) 1400 local time independed from developments inside the IDAP HQ area.
		<br/>If the IDAP HQ is (against all odds) occupied by insurgent forces, the mosque ist to be surrounded by a safety parameter of minimum 50m all around. No fires into the IDAP HQ are allowed.
		<br/>
		<br/><font color='#FFA500' size='16' face='PuristaBold'>Objectives:</font>
		//Define specific Objectives or positions on which your want the mission CO to execute specific tasks.
		//Do also define the end state of the operation.
		<br/><font color='#d21111' size='15'>ORP C´2</font>
		<br/>- Establish safety parameter and prepare to move into Bastam North.
		<br/>
		<br/><font color='#d21111' size='15'>Bastam North (Phase One)</font>
		<br/>- Establish base of fire as necessary
		<br/>
		<br/><font color='#d21111' size='15'>Objective Rosalind (Phase Two)</font>
		<br/>- Seize the objective of all enemy forces (except when IDAP HQ is occupied by enemies).
		<br/>- Establish east and south route blocking positions using the cities buildings.
		<br/>- Protect the IDAP HQ
		ENDTAB;

		NEWTAB("III. Execution:")
		<br/><font color='#FFA500' size='16' face='PuristaBold'>a. Commanders Intent:</font>
		//In here you tell the mission CO how you will use his and adjacent units to accomplish your mission.
		<br/>- Seize Bastam
		<br/>- Form Blocking Positions
		<br/>- Prevent insurgent attacks onto IDAP HQ
		<br/>- Prevent insurgents from entering Rasman airfield area
		<br/>
		<br/><font color='#FFA500' size='16' face='PuristaBold'>b. Concept of Operations</font>
		//Give overview of the planned tasks in your concept per unit.
		//As said above, if you brief for multiple units, you will have to adjust the briefing accordingly.
		<br/>Charlie Company will accomplish the mission by the following steps:
		<br/>- C´1 will seize Lalazar Plant in a cooperative effort with C´4 NLT 1145 local time and place their weapons squad in support of C´2s efforts at 094-054 defensive structures. As per seperat OPORD.
		<br/>- C´2 will then cross through C´3 seizing Bastam with defined orders as per this OPORD Paragraph II. C´2 will not use the roads leading to Bastam due to threat of IEDs. C´2 will not use indirect fires in the near of IDAP HQ.
		<br/>- Last C´3 will move into blocking position at hill 2178 east of Bastam at 097068 as per separate OPORD.
		<br/>The decisive point of this mission is to take Bastam.
		<br/>This is decisive as it is mandatory to hold this position to accomplish the forming of the security ring around Rasman airfield.
		<br/>Charlie 2 Platoon will be the main effort of this operations. With all other platoons in supporting efforts.
		<br/>Engineers will later disarm all detected IEDs as a separate operation.
		<br/>End state is a security ring consisting out of Alpha Company in Nagara, Bravo in Zavarak and Charlie in Bastam to support further inland operations and reinforcements to Rasman airfield.
		<br/>
		<br/><font color='#d21111' size='15'>1. Maneuver</font>
		<br/>(This point is skipped as it is not representable in ArmA3. Its purpose is to graphically war game the offensive/defensive actions taken of all units in this operation.)
		<br/>(If absolutely necessary the mission CO can use visual tools while his briefing on the map screen.)
		<br/>
		<br/><font color='#d21111' size='15'>2. Fires</font>
		<br/><font size='14'>a. PURPOSE AND TASK:</font>
		//What does the commander want to accomplish with his fires?
		//This includes all fire support systems: artillery, mortars, close air support, and naval gunfire.
		//What is the Task (suppress, neutralize, destroy, delay, disrupt) and
		//Purpose(suppress, neutralize, destroy, harass) of each fire support asset?
		<br/>Fires N/A
		<br/>
		<br/><font size='14'>b. PRIORITY:</font>
		//Who has the priority of fires? When, where, and why? When do they shift? Include all systems.
		//Normally (but not always) the priority of fires goes to the maneuver element
		//which has been designated the main effort or is the most vulnerable to enemy attack.
		<br/>Fires N/A
		<br/>
		<br/><font size='14'>c. ALLOCATION:</font>
		//Where are the FS systems located, who has command over them and who and how is thr FSO to approach via radio.
		<br/>Fires N/A
		<br/>
		<br/><font size='14'>d. RESTRICTIONS/SPECIAL MUNITIONS:</font>
		//Has the FSO or the mission maker set any restrictions on what to use or where to fire?
		<br/>Fires N/A
		<br/>
		<br/><font color='#d21111' size='15'>3. Reconnaissance and Surveillance:</font>
		//Are any R&S forces available to the mission CO and how do you intent them to be used?
		<br/>Currently all available forces and assets are deployed and additional intel might arrive at any moment while in operation.
		<br/>
		<br/><font color='#d21111' size='15'>4. Intelligence:</font>
		//What to do with enemy/neutral intel acquired while operation.
		//Is any of the units to explicitly search for intel?
		<br/>It in not to be expected to come across any meaningful intel; intel discovered is to be secured after the missions main efforts is accomplished.
		<br/>
		<br/><font color='#d21111' size='15'>5. Engineering:</font>
		<br/><font size='14'>a. PURPOSE AND PRIORITY:</font>
		//What is the priority and purpose of the engineering effort?
		//Where are engineering units located? Orders may be given in the next paragraph.
		<br/>Engineers will later on clear the area of Bastam of any remaining explosives.
		<br/>
		<br/><font size='14'>b. ALLOCATION:</font>
		//Where are they located? Who may give orders to them?
		<br/>Engineers are with Alpha Company
		<br/>
		<br/><font size='14'>c. RESTRICTIONS:</font>
		//What restrictions are given to the engineers?
		//Are EOD techs allowed to defuse by detonation?
		<br/>No restrictions at this time.
		<br/>
		<br/><font color='#d21111' size='15'>6. Air Defense:</font>
		//What is the purpose for organic or attached air defense units?
		//Where are they located? Are they to be active of passive?
		<br/>No AA with the Company, no air threat in the area.
		<br/>
		<br/><font color='#FFA500' size='16' face='PuristaBold'>c. Tasks to Maneuver Units:</font>
		//List all included units in the operation and detail their secondary tasks.
		<br/><font color='#d21111' size='15'>1. 2nd Platoon of Charlie Company:</font>
		<br/>1. All units are to precede with caution and have to be covered at all phases.
		<br/>2. Actions at short/long halts: Establish security and maintain spacing. Report to Higher.
		<br/>3. Primary and alternate routes per element. C´2 - south in between the south bound roads towards Bastam, no alternative route available.
		<br/>4. Location of departure and friendly reentry lines. LOD is east of Rasman South, FRL are south of C´2 ORP and north of Bastam North.
		<br/>5. ORP C´2 at 096055. Surrounded by foliage.
		<br/>6. Actions at danger areas: inspect DA and bypass in sufficient distance based on OPORD.
		<br/>7. Actions on enemy contact: Engage, fix and destroy. Try not to be forced into fighting retreat.
		<br/>8. Reorganization and consolidation instructions. If the unit breaks apart, all units reconsolidate at the last Phases CCP in defensive positions.
		<br/>9. Fire distribution: point fires vs area fires for all weapons systems: As per C´2 COs discretion.
		<br/>10. Fire control measures: Detailed order of priority of targets; Sectors of fires including TRPs; Visual/Sound signals.
		<br/>TRPs as per C´2 2IC
		<br/>Limit sectors of fire south and east of Bastam to non civilian areas.
		<br/>11. MOPP levels: All protective gear and gask masks should remain on person at all times during operation.
		<br/>12. Troop safety and operational exposure guidance: None.
		<br/>13. Time schedules (rehearsals, back briefs, inspections, movement) Given are: Who, When, Where and What will be briefed. Actions on objective should at all times be rehearsed for all elements!
		<br/>C´2 internal rehearsal at C´2 ORP in before operation start.
		<br/>14. Priority Intelligence Requirements(PIR): Skip as not applicable to GC
		<br/>15. Debriefing requirements. Skip as mostly not done at GC.
		<br/>16. Report schedule: ACE reports after each engagement. SALUTE reports on enemy sightings.
		<br/>17. Rules of Engagement: When to shoot, What to shoot at.
		<br/>Do not shoot at any local population. Local population will turn against our forces when fired upon. Do not engage any individuals obviously engaging in medical actions.
		<br/>
		<br/><font color='#FFA500' size='16' face='PuristaBold'>d. Tasks to Combat Service Support Units:</font>
		<br/>The CCP has to be established at a position with a minimum of 2 hard cover obstacles towards the enemy, to deny shrapnels or stray round into the CCP.
		<br/>Casualties are evacuated to the CCP by combat lifesavers or their fellow soldiers. If treatment at the CCP does not suffice, MEDEVAC by the ambulance squad will be requested.
		<br/>
		<br/><font color='#FFA500' size='16' face='PuristaBold'>e. Coordinating Instructions:</font>
		<br/>At all times medical evacuation can be requested via the callsign Lima Papa on COY Net (Company radio net), detailed evac execution takes place on the COY Medevac Net.
		<br/>For each Phase of the operation a CCP is to be assigned and maintained by the detached trauma specialist who at all times has to stay in radio contact with the COY Ambulance Squad.
		<br/>Identified IEDs have to me visually marked for follow on troops and ordnance disposal. Equipment is handed out at ORP.
		ENDTAB;

		NEWTAB("IV. Service Support:")
		<br/><font color='#FFA500' size='16' face='PuristaBold'>a. General Concept:</font>
		<br/>Resupply is only available at Rasman South with C´6.
		<br/>Company AXP (Ambulance Exchange Point) is located at 105062
		<br/>C´2 trauma specialist is to request medevac via COY MEDEVAC NET as per 9line medevac SOP.
		<br/>
		<br/><font color='#FFA500' size='16' face='PuristaBold'>b. Material and Services:</font>
		<br/><font color='#d21111' size='15'>1. Supply:</font>
		<br/>
		<br/>b. Class II: Clothing and individual equipment
		<br/>Info N/A
		<br/>c. Class III: POL (fuel)
		<br/>Info N/A
		<br/>d. Class IV: Construction
		<br/>Info N/A
		<br/>e. Class V: Ammunition
		<br/>Only available at COY HQ. No frontline resupply available as of now. Resupply via HMMWV possible.
		<br/>g. Class VII: Major End Items (f.e. special items like claymores and with whom they are)
		<br/>Heavy AT capabilities with C´4 + resupply.
		<br/>h. Class VIII: Medical equipment
		<br/>i. Class IX: Repair
		<br/>k. Method of Supply distribution
		<br/>Supply distribution via C´5 Company First Sergeant with COY HQ
		<br/>
		<br/><font color='#d21111' size='15'>2. Transportation:</font>
		<br/>None.
		<br/>
		<br/><font color='#d21111' size='15'>3. Services:</font>
		<br/>Skip for GC
		<br/>
		<br/><font color='#d21111' size='15'>4. Maintenance:</font>
		<br/>As per COY SOPs
		<br/>
		<br/><font color='#FFA500' size='16' face='PuristaBold'>c. Medical Evacuation:</font>
		<br/>MoE (Method of Evacuation) in field by foot to nearest CCP. If required from CCP via MEDEVAC to COY AXP or BAS.
		<br/>
		<br/><font color='#d21111' size='15'>1. Actions on enemy/civilian wounded:</font>
		<br/>Disarm, secure, provide first aid, evac to CCP.
		<br/>
		<br/><font color='#d21111' size='15'>2. Actions on friendly wounded:</font>
		<br/>Secure area, provide first aid, evac to CCP.
		<br/>
		<br/><font color='#FFA500' size='16' face='PuristaBold'>d. Personnel:</font>
		<br/><font color='#d21111' size='15'>1. Handling of enemy prisoners of war (EPW).</font>
		<br/>EPWs are to be secured and brought to COY Prisoner Collection Point where they will be guarded.
		<br/>
		<br/><font color='#FFA500' size='16' face='PuristaBold'>e. Civil-Military Cooperation:</font>
		<br/><font color='#d21111' size='15'>1. Civilians</font>
		<br/>The local Population is armed and is acting in our favor. Each city is independent and will react differently to diplomatic approaches.
		<br/><font color='#d21111' size='15'>2. Refugees</font>
		<br/>Many areas of the country are poor and where unable to leave the scene of war. Expect refugees at any time.
		<br/>
		ENDTAB;

		NEWTAB("V. Command & Signal:")
		<br/>During all phases of Company operation the COY HQ will remain at 104061 with all C2 control elements. Callsign Topdown will position on their own.
		<br/>
		<br/><font color='#FFA500' size='16' face='PuristaBold'>a. Command:</font>
		<br/><font color='#d21111' size='15'>1. Location of higher units Head Quarter (HQ) and Command and Control Point (C2P).</font>
		<br/>Battalion HQ is located at Rasman airfield.
		<br/><font color='#d21111' size='15'>2. Locations of key personnel during all phases of the operation, during movement, at the ORP and on the objective.</font>
		<br/>Charlie COY HQ maintains position throughout all phases. The attached Ambulance Squad will maintain their position.
		<br/><font color='#d21111' size='15'>3. Succession of Command</font>
		<br/>C´6, C´7, C´4, C´1, C´2, C´3
		//This point 4 will most likely only be of importance for large scale cross community events.
		<br/><font color='#d21111' size='15'>4. (Skip) Adjustments to unit SOPs</font>
		<br/><font color='#FFA500' size='16' face='PuristaBold'>b. Signal:</font>
		<br/><font color='#d21111' size='15'>1. Signal Operating Instructions Index in effect:</font>
		<br/> Callsigns as per Task Organization!
		<br/>
		<br/><font size='14'>Short Range Radio Nets:</font>
		<br/>
		<br/>1st Platoon (C/2-330 INF):
		<br/> SR 6 Block 1 - Plt HQ
		<br/> SR 1 Block 1 - 1st Infantry Squad
		<br/> SR 2 Block 1 - 2nd Infantry Squad
		<br/> SR 3 Block 1 - 3rd Infantry Squad
		<br/> SR 4 Block 1 - Weapons Squad
		<br/>
		<br/>2nd Platoon (C/2-330 INF):
		<br/> SR 6 Block 2 - Plt HQ
		<br/> SR 1 Block 2 - 1st Infantry Squad
		<br/> SR 2 Block 2 - 2nd Infantry Squad
		<br/> SR 3 Block 2 - 3rd Infantry Squad
		<br/> SR 4 Block 2 - Weapons Squad
		<br/>
		<br/>3rd Platoon (C/2-330 INF):
		<br/> SR 6 Block 3 - Plt HQ
		<br/> SR 1 Block 3 - 1st Infantry Squad
		<br/> SR 2 Block 3 - 2nd Infantry Squad
		<br/> SR 3 Block 3 - 3rd Infantry Squad
		<br/> SR 4 Block 3 - Weapons Squad
		<br/>
		<br/>Heavy Weapons Platoon (C/2-330 INF):
		<br/> SR 6 Block 4 - Plt HQ
		<br/> SR 1 Block 4 - 1st Weapons Squad
		<br/> SR 2 Block 4 - 2nd Weapons Squad
		<br/> SR 3 Block 4 - 3rd Weapons Squad
		<br/> SR 4 Block 4 - 4th Weapons Squad
		<br/>
		<br/>Attachments:
		<br/> SR 9 Block 5 - (A/1-26 SUP) Tactical Air Control Party - Topdown
		<br/> SR 3 Block 5 - (C/4-33 ART) Fire Support Team - Ironhammer
		<br/> SR 6 Block 5 - (E/2-65 MED) Ambulance Squad - Lima Papa
		<br/>
		<br/><font size='14'>Long Range Radio Nets:</font>
		<br/>
		<br/>C Company (C/2-330 INF):
		<br/> LR 1 - 1st PLT NET
		<br/> LR 2 - 2nd PLT NET
		<br/> LR 3 - 3rd PLT NET
		<br/> LR 4 - 4th PLT NET
		<br/> LR 5 - EMPTY
		<br/> LR 6 - COY NET
		<br/> LR 7 - CAS NET
		<br/> LR 8 - MEDEVAC NET
		<br/> LR 9 - FIRES NET
		<br/>
		<br/><font color='#d21111' size='15'>2. Method of communication:</font>
		<br/>Radios in general, when scammed, runners.
		<br/>
		<br/><font color='#d21111' size='15'>3. Pyrotechnics and Signals:</font>
		<br/>Colored flares as per unit SOP, gestures and hand signals for tasks
		<br/>
		<br/><font color='#d21111' size='15'>4. Codewords:</font>
		<br/>red angle = enemy occupied IDAP HQ
		<br/>black garden = Location with multiple connected IEDs
		<br/>united panic = mass casualty event
		<br/>broken pipe = immediate retreat of all forces to previous phase
		<br/>
		<br/><font color='#d21111' size='15'>5. Challenge and Password:</font>
		<br/>C: Marco P: Polo
		<br/>
		<br/><font color='#d21111' size='15'>6. Number Combination:</font>
		<br/>1464
		<br/>
		<br/><font color='#d21111' size='15'>7. Running Password:</font>
		<br/>Alberta
		<br/>
		<br/><font color='#d21111' size='15'>8. Recognition Signals:</font>
		<br/>Red/Orange Smoke = enemy position (applied towards enemy units)
		<br/>White Smoke = concealment
		<br/>Green Smoke = friendly position (applied towards friendly units)
		<br/>Yellow Smoke = Urgent Medical (applied towards friendly units)
		<br/>Blue Smoke = Broken Comms/COC (applied towards friendly units)
		<br/>
		<br/><font color='#d21111' size='15'>9. RTO Special Instructions:</font>
		<br/>Company and platoon RTOs are to record all transmitted requests for fire support and medical evacuation.
		ENDTAB;
	}; //End of west case
}; //End of switch

NEWTAB("VI. Mission notes:") //This is shown for everyone
<br/><font color='#FFA500' size='15'>RESPAWN</font>
<br/>
<br/>One Life per Player
<br/>
<br/><font color='#FFA500' size='15'>REVIVE</font>
<br/>
<br/>Disabled
<br/>
<br/><font color='#FFA500' size='15'>JIP</font>
<br/>
<br/><font size='14'>Blufor</font>
<br/>JIP Transport
<br/>
<br/><font color='#FFA500' size='15'>END CONDITION</font>
<br/>
<br/><font size='14'>OPFOR VICTORY:</font>
<br/>- 60% Blufor casualties
<br/>- IDAP Personnel dies due to Blufor actions
<br/>
<br/><font size='14'>BLUFOR VICTORY:</font>
<br/>- 90% Opfor casualties
<br/>
<br/><font color='#FFA500' size='15'>USE OF ENEMY VEHICLE ASSETS</font>
<br/>
<br/>Prohibited. Following exceptions remain when in a survival-style situation: Jeeps and other non-special vehicles can be manned and operated for tactical advantage. This includes the usage of mounted standard weapon systems like M2/miniguns.
<br/>
<br/><font color='#FFA500' size='15'>ACE MEDICAL</font>
<br/>
<br/>- Ace Medical Surgical Kit can only be used by Corpsman.
<br/>- Ace Medical Surgical Kit can only be used near of Medical Vehicles or Facilities, as long as the patient is stable. (no bleeding)
<br/>- Ace Medical Surgical Kit is used up when used.
<br/>- Highest ranking MEDIC is set to be ACE Doctor.
<br/>
<br/><font color='#FFA500' size='15'>TECHNICAL ASPECT</font>
<br/>
<br/>- View Distance:
<br/>-- Player: 2500.
<br/>-- AI: 2500.
<br/>- ACRE Signal loss is turned on.
<br/>- ACRE Occlusion is turned on.
<br/>- ACRE radio interference is turned on.
<br/>- ACRE AI HEAR PLAYERS IS ENABLED.
<br/>
<br/><font color='#FFA500' size='15'>CREDITS</font>
<br/>
<br/>> Olsen Framework.
<br/>
<br/>> Briefing Layout Source: Perfk
<br/>> Altered by Pax and StatusRed
<br/>
<br/>  <font color='#FFA500' size='15'>Mission by:</font>
<br/> -YOUR NAME HERE-
<br/>
ENDTAB;

NEWTAB("Game Mastering") //This is shown for everyone
<br/> This mission is not designed for game mastering and should only be manipulated for technical, administrative or diagnostic purposes.
<br/> Please DO NOT go into zeus, unless you REALLY have to.
ENDTAB;

DISPLAYBRIEFING();
