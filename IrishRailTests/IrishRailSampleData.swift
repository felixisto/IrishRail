//
//  IrishRailSampleData.swift
//  IrishRailTests
//
//  Created by Kristiyan Butev on 23.07.21.
//

import Foundation

class IrishRailSampleData {
    func xmlData(of xmlString: String) -> Data {
        xmlString.data(using: .utf8)!
    }
    
    let allStations =
    """
    <ArrayOfObjStation xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns="http://api.irishrail.ie/realtime/">
    <objStation>
    <StationDesc>Belfast</StationDesc>
    <StationAlias/>
    <StationLatitude>54.6123</StationLatitude>
    <StationLongitude>-5.91744</StationLongitude>
    <StationCode>BFSTC</StationCode>
    <StationId>228</StationId>
    </objStation>
    <objStation>
    <StationDesc>Lisburn</StationDesc>
    <StationAlias/>
    <StationLatitude>54.514</StationLatitude>
    <StationLongitude>-6.04327</StationLongitude>
    <StationCode>LBURN</StationCode>
    <StationId>238</StationId>
    </objStation>
    </ArrayOfObjStation>
    """
    
    // Missing StationDesc in first objStation
    let invalidAllStations =
    """
    <ArrayOfObjStation xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns="http://api.irishrail.ie/realtime/">
    <objStation>
    <StationAlias/>
    <StationLatitude>54.6123</StationLatitude>
    <StationLongitude>-5.91744</StationLongitude>
    <StationCode>BFSTC</StationCode>
    <StationId>228</StationId>
    </objStation>
    <objStation>
    <StationDesc>Lisburn</StationDesc>
    <StationAlias/>
    <StationLatitude>54.514</StationLatitude>
    <StationLongitude>-6.04327</StationLongitude>
    <StationCode>LBURN</StationCode>
    <StationId>238</StationId>
    </objStation>
    </ArrayOfObjStation>
    """
    
    let stationData =
        """
        <ArrayOfObjStationData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns="http://api.irishrail.ie/realtime/">
        <objStationData>
        <Servertime>2021-07-22T14:51:08.75</Servertime>
        <Traincode>E825 </Traincode>
        <Stationfullname>Dublin Connolly</Stationfullname>
        <Stationcode>CNLLY</Stationcode>
        <Querytime>14:51:08</Querytime>
        <Traindate>22 Jul 2021</Traindate>
        <Origin>Bray</Origin>
        <Destination>Malahide</Destination>
        <Origintime>14:05</Origintime>
        <Destinationtime>15:20</Destinationtime>
        <Status>En Route</Status>
        <Lastlocation>Departed Tara Street</Lastlocation>
        <Duein>3</Duein>
        <Late>1</Late>
        <Exparrival>14:52</Exparrival>
        <Expdepart>14:54</Expdepart>
        <Scharrival>14:51</Scharrival>
        <Schdepart>14:53</Schdepart>
        <Direction>Northbound</Direction>
        <Traintype>DART</Traintype>
        <Locationtype>S</Locationtype>
        </objStationData>
        <objStationData>
        <Servertime>2021-07-22T14:51:08.75</Servertime>
        <Traincode>A909 </Traincode>
        <Stationfullname>Dublin Connolly</Stationfullname>
        <Stationcode>CNLLY</Stationcode>
        <Querytime>14:51:08</Querytime>
        <Traindate>22 Jul 2021</Traindate>
        <Origin>Sligo</Origin>
        <Destination>Dublin Connolly</Destination>
        <Origintime>13:05</Origintime>
        <Destinationtime>16:08</Destinationtime>
        <Status>En Route</Status>
        <Lastlocation>Departed Edgeworthstown</Lastlocation>
        <Duein>81</Duein>
        <Late>4</Late>
        <Exparrival>16:12</Exparrival>
        <Expdepart>00:00</Expdepart>
        <Scharrival>16:08</Scharrival>
        <Schdepart>00:00</Schdepart>
        <Direction>Southbound</Direction>
        <Traintype>Train</Traintype>
        <Locationtype>D</Locationtype>
        </objStationData>
        <objStationData>
        <Servertime>2021-07-22T14:51:08.75</Servertime>
        <Traincode>P616 </Traincode>
        <Stationfullname>Dublin Connolly</Stationfullname>
        <Stationcode>CNLLY</Stationcode>
        <Querytime>14:51:08</Querytime>
        <Traindate>22 Jul 2021</Traindate>
        <Origin>Drogheda</Origin>
        <Destination>Dublin Pearse</Destination>
        <Origintime>15:10</Origintime>
        <Destinationtime>16:17</Destinationtime>
        <Status>No Information</Status>
        <Lastlocation/>
        <Duein>81</Duein>
        <Late>0</Late>
        <Exparrival>16:11</Exparrival>
        <Expdepart>16:12</Expdepart>
        <Scharrival>16:11</Scharrival>
        <Schdepart>16:12</Schdepart>
        <Direction>Southbound</Direction>
        <Traintype>Train</Traintype>
        <Locationtype>S</Locationtype>
        </objStationData>
        <objStationData>
        <Servertime>2021-07-22T14:51:08.75</Servertime>
        <Traincode>E241 </Traincode>
        <Stationfullname>Dublin Connolly</Stationfullname>
        <Stationcode>CNLLY</Stationcode>
        <Querytime>14:51:08</Querytime>
        <Traindate>22 Jul 2021</Traindate>
        <Origin>Malahide</Origin>
        <Destination>Bray</Destination>
        <Origintime>15:52</Origintime>
        <Destinationtime>17:05</Destinationtime>
        <Status>No Information</Status>
        <Lastlocation/>
        <Duein>86</Duein>
        <Late>0</Late>
        <Exparrival>16:16</Exparrival>
        <Expdepart>16:17</Expdepart>
        <Scharrival>16:16</Scharrival>
        <Schdepart>16:17</Schdepart>
        <Direction>Southbound</Direction>
        <Traintype>DART</Traintype>
        <Locationtype>S</Locationtype>
        </objStationData>
        <objStationData>
        <Servertime>2021-07-22T14:51:08.75</Servertime>
        <Traincode>A129 </Traincode>
        <Stationfullname>Dublin Connolly</Stationfullname>
        <Stationcode>CNLLY</Stationcode>
        <Querytime>14:51:08</Querytime>
        <Traindate>22 Jul 2021</Traindate>
        <Origin>Belfast</Origin>
        <Destination>Dublin Connolly</Destination>
        <Origintime>14:05</Origintime>
        <Destinationtime>16:20</Destinationtime>
        <Status>No Information</Status>
        <Lastlocation/>
        <Duein>89</Duein>
        <Late>0</Late>
        <Exparrival>16:20</Exparrival>
        <Expdepart>00:00</Expdepart>
        <Scharrival>16:20</Scharrival>
        <Schdepart>00:00</Schdepart>
        <Direction>Southbound</Direction>
        <Traintype>Train</Traintype>
        <Locationtype>D</Locationtype>
        </objStationData>
        <objStationData>
        <Servertime>2021-07-22T14:51:08.75</Servertime>
        <Traincode>P412 </Traincode>
        <Stationfullname>Dublin Connolly</Stationfullname>
        <Stationcode>CNLLY</Stationcode>
        <Querytime>14:51:08</Querytime>
        <Traindate>22 Jul 2021</Traindate>
        <Origin>Newbridge</Origin>
        <Destination>Dublin Pearse</Destination>
        <Origintime>15:08</Origintime>
        <Destinationtime>16:00</Destinationtime>
        <Status>No Information</Status>
        <Lastlocation/>
        <Duein>64</Duein>
        <Late>0</Late>
        <Exparrival>15:54</Exparrival>
        <Expdepart>15:55</Expdepart>
        <Scharrival>15:54</Scharrival>
        <Schdepart>15:55</Schdepart>
        <Direction>To Dublin Pearse</Direction>
        <Traintype>Train</Traintype>
        <Locationtype>S</Locationtype>
        </objStationData>
        </ArrayOfObjStationData>
"""
    
    // Missing Traincode from first objStationData
    let invalidStationData =
        """
        <ArrayOfObjStationData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns="http://api.irishrail.ie/realtime/">
        <objStationData>
        <Servertime>2021-07-22T14:51:08.75</Servertime>
        <Stationfullname>Dublin Connolly</Stationfullname>
        <Stationcode>CNLLY</Stationcode>
        <Querytime>14:51:08</Querytime>
        <Traindate>22 Jul 2021</Traindate>
        <Origin>Bray</Origin>
        <Destination>Malahide</Destination>
        <Origintime>14:05</Origintime>
        <Destinationtime>15:20</Destinationtime>
        <Status>En Route</Status>
        <Lastlocation>Departed Tara Street</Lastlocation>
        <Duein>3</Duein>
        <Late>1</Late>
        <Exparrival>14:52</Exparrival>
        <Expdepart>14:54</Expdepart>
        <Scharrival>14:51</Scharrival>
        <Schdepart>14:53</Schdepart>
        <Direction>Northbound</Direction>
        <Traintype>DART</Traintype>
        <Locationtype>S</Locationtype>
        </objStationData>
        <objStationData>
        <Servertime>2021-07-22T14:51:08.75</Servertime>
        <Traincode>A909 </Traincode>
        <Stationfullname>Dublin Connolly</Stationfullname>
        <Stationcode>CNLLY</Stationcode>
        <Querytime>14:51:08</Querytime>
        <Traindate>22 Jul 2021</Traindate>
        <Origin>Sligo</Origin>
        <Destination>Dublin Connolly</Destination>
        <Origintime>13:05</Origintime>
        <Destinationtime>16:08</Destinationtime>
        <Status>En Route</Status>
        <Lastlocation>Departed Edgeworthstown</Lastlocation>
        <Duein>81</Duein>
        <Late>4</Late>
        <Exparrival>16:12</Exparrival>
        <Expdepart>00:00</Expdepart>
        <Scharrival>16:08</Scharrival>
        <Schdepart>00:00</Schdepart>
        <Direction>Southbound</Direction>
        <Traintype>Train</Traintype>
        <Locationtype>D</Locationtype>
        </objStationData>
        <objStationData>
        <Servertime>2021-07-22T14:51:08.75</Servertime>
        <Traincode>P616 </Traincode>
        <Stationfullname>Dublin Connolly</Stationfullname>
        <Stationcode>CNLLY</Stationcode>
        <Querytime>14:51:08</Querytime>
        <Traindate>22 Jul 2021</Traindate>
        <Origin>Drogheda</Origin>
        <Destination>Dublin Pearse</Destination>
        <Origintime>15:10</Origintime>
        <Destinationtime>16:17</Destinationtime>
        <Status>No Information</Status>
        <Lastlocation/>
        <Duein>81</Duein>
        <Late>0</Late>
        <Exparrival>16:11</Exparrival>
        <Expdepart>16:12</Expdepart>
        <Scharrival>16:11</Scharrival>
        <Schdepart>16:12</Schdepart>
        <Direction>Southbound</Direction>
        <Traintype>Train</Traintype>
        <Locationtype>S</Locationtype>
        </objStationData>
        <objStationData>
        <Servertime>2021-07-22T14:51:08.75</Servertime>
        <Traincode>E241 </Traincode>
        <Stationfullname>Dublin Connolly</Stationfullname>
        <Stationcode>CNLLY</Stationcode>
        <Querytime>14:51:08</Querytime>
        <Traindate>22 Jul 2021</Traindate>
        <Origin>Malahide</Origin>
        <Destination>Bray</Destination>
        <Origintime>15:52</Origintime>
        <Destinationtime>17:05</Destinationtime>
        <Status>No Information</Status>
        <Lastlocation/>
        <Duein>86</Duein>
        <Late>0</Late>
        <Exparrival>16:16</Exparrival>
        <Expdepart>16:17</Expdepart>
        <Scharrival>16:16</Scharrival>
        <Schdepart>16:17</Schdepart>
        <Direction>Southbound</Direction>
        <Traintype>DART</Traintype>
        <Locationtype>S</Locationtype>
        </objStationData>
        <objStationData>
        <Servertime>2021-07-22T14:51:08.75</Servertime>
        <Traincode>A129 </Traincode>
        <Stationfullname>Dublin Connolly</Stationfullname>
        <Stationcode>CNLLY</Stationcode>
        <Querytime>14:51:08</Querytime>
        <Traindate>22 Jul 2021</Traindate>
        <Origin>Belfast</Origin>
        <Destination>Dublin Connolly</Destination>
        <Origintime>14:05</Origintime>
        <Destinationtime>16:20</Destinationtime>
        <Status>No Information</Status>
        <Lastlocation/>
        <Duein>89</Duein>
        <Late>0</Late>
        <Exparrival>16:20</Exparrival>
        <Expdepart>00:00</Expdepart>
        <Scharrival>16:20</Scharrival>
        <Schdepart>00:00</Schdepart>
        <Direction>Southbound</Direction>
        <Traintype>Train</Traintype>
        <Locationtype>D</Locationtype>
        </objStationData>
        <objStationData>
        <Servertime>2021-07-22T14:51:08.75</Servertime>
        <Traincode>P412 </Traincode>
        <Stationfullname>Dublin Connolly</Stationfullname>
        <Stationcode>CNLLY</Stationcode>
        <Querytime>14:51:08</Querytime>
        <Traindate>22 Jul 2021</Traindate>
        <Origin>Newbridge</Origin>
        <Destination>Dublin Pearse</Destination>
        <Origintime>15:08</Origintime>
        <Destinationtime>16:00</Destinationtime>
        <Status>No Information</Status>
        <Lastlocation/>
        <Duein>64</Duein>
        <Late>0</Late>
        <Exparrival>15:54</Exparrival>
        <Expdepart>15:55</Expdepart>
        <Scharrival>15:54</Scharrival>
        <Schdepart>15:55</Schdepart>
        <Direction>To Dublin Pearse</Direction>
        <Traintype>Train</Traintype>
        <Locationtype>S</Locationtype>
        </objStationData>
        </ArrayOfObjStationData>
"""
    
    let trainMovements =
    """
    <ArrayOfObjTrainMovements xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns="http://api.irishrail.ie/realtime/">
    <objTrainMovements>
    <TrainCode>A609 </TrainCode>
    <TrainDate>22 Jul 2021</TrainDate>
    <LocationCode>RLEPT</LocationCode>
    <LocationFullName>Rosslare Europort</LocationFullName>
    <LocationOrder>1</LocationOrder>
    <LocationType>O</LocationType>
    <TrainOrigin>Rosslare Europort</TrainOrigin>
    <TrainDestination>Dublin Connolly</TrainDestination>
    <ScheduledArrival>00:00:00</ScheduledArrival>
    <ScheduledDeparture>12:55:00</ScheduledDeparture>
    <ExpectedArrival>00:00:00</ExpectedArrival>
    <ExpectedDeparture>12:55:00</ExpectedDeparture>
    <Arrival/>
    <Departure/>
    <AutoArrival/>
    <AutoDepart/>
    <StopType>C</StopType>
    </objTrainMovements>
    <objTrainMovements>
    <TrainCode>A609 </TrainCode>
    <TrainDate>22 Jul 2021</TrainDate>
    <LocationCode>RLSTD</LocationCode>
    <LocationFullName>Rosslare Strand</LocationFullName>
    <LocationOrder>2</LocationOrder>
    <LocationType>S</LocationType>
    <TrainOrigin>Rosslare Europort</TrainOrigin>
    <TrainDestination>Dublin Connolly</TrainDestination>
    <ScheduledArrival>13:00:00</ScheduledArrival>
    <ScheduledDeparture>13:01:00</ScheduledDeparture>
    <ExpectedArrival>13:00:00</ExpectedArrival>
    <ExpectedDeparture>13:01:00</ExpectedDeparture>
    <Arrival/>
    <Departure/>
    <AutoArrival/>
    <AutoDepart/>
    <StopType>N</StopType>
    </objTrainMovements>
    <objTrainMovements>
    <TrainCode>A609 </TrainCode>
    <TrainDate>22 Jul 2021</TrainDate>
    <LocationCode>WXFRD</LocationCode>
    <LocationFullName>Wexford</LocationFullName>
    <LocationOrder>3</LocationOrder>
    <LocationType>S</LocationType>
    <TrainOrigin>Rosslare Europort</TrainOrigin>
    <TrainDestination>Dublin Connolly</TrainDestination>
    <ScheduledArrival>13:18:30</ScheduledArrival>
    <ScheduledDeparture>13:20:30</ScheduledDeparture>
    <ExpectedArrival>13:18:30</ExpectedArrival>
    <ExpectedDeparture>13:20:30</ExpectedDeparture>
    <Arrival/>
    <Departure/>
    <AutoArrival/>
    <AutoDepart/>
    <StopType>-</StopType>
    </objTrainMovements>
    <objTrainMovements>
    <TrainCode>A609 </TrainCode>
    <TrainDate>22 Jul 2021</TrainDate>
    <LocationCode>WXLOP</LocationCode>
    <LocationFullName>Wexford Loop</LocationFullName>
    <LocationOrder>4</LocationOrder>
    <LocationType>T</LocationType>
    <TrainOrigin>Rosslare Europort</TrainOrigin>
    <TrainDestination>Dublin Connolly</TrainDestination>
    <ScheduledArrival>13:21:00</ScheduledArrival>
    <ScheduledDeparture>13:21:00</ScheduledDeparture>
    <ExpectedArrival>13:21:00</ExpectedArrival>
    <ExpectedDeparture>13:21:00</ExpectedDeparture>
    <Arrival/>
    <Departure/>
    <AutoArrival/>
    <AutoDepart/>
    <StopType>-</StopType>
    </objTrainMovements>
    <objTrainMovements>
    <TrainCode>A609 </TrainCode>
    <TrainDate>22 Jul 2021</TrainDate>
    <LocationCode>ECRTY</LocationCode>
    <LocationFullName>Enniscorthy</LocationFullName>
    <LocationOrder>5</LocationOrder>
    <LocationType>S</LocationType>
    <TrainOrigin>Rosslare Europort</TrainOrigin>
    <TrainDestination>Dublin Connolly</TrainDestination>
    <ScheduledArrival>13:39:30</ScheduledArrival>
    <ScheduledDeparture>13:40:30</ScheduledDeparture>
    <ExpectedArrival>13:39:30</ExpectedArrival>
    <ExpectedDeparture>13:40:30</ExpectedDeparture>
    <Arrival/>
    <Departure/>
    <AutoArrival/>
    <AutoDepart/>
    <StopType>-</StopType>
    </objTrainMovements>
    <objTrainMovements>
    <TrainCode>A609 </TrainCode>
    <TrainDate>22 Jul 2021</TrainDate>
    <LocationCode>GOREY</LocationCode>
    <LocationFullName>Gorey</LocationFullName>
    <LocationOrder>6</LocationOrder>
    <LocationType>S</LocationType>
    <TrainOrigin>Rosslare Europort</TrainOrigin>
    <TrainDestination>Dublin Connolly</TrainDestination>
    <ScheduledArrival>13:59:30</ScheduledArrival>
    <ScheduledDeparture>14:00:30</ScheduledDeparture>
    <ExpectedArrival>13:59:30</ExpectedArrival>
    <ExpectedDeparture>14:00:30</ExpectedDeparture>
    <Arrival/>
    <Departure/>
    <AutoArrival/>
    <AutoDepart/>
    <StopType>-</StopType>
    </objTrainMovements>
    <objTrainMovements>
    <TrainCode>A609 </TrainCode>
    <TrainDate>22 Jul 2021</TrainDate>
    <LocationCode>ARKLW</LocationCode>
    <LocationFullName>Arklow</LocationFullName>
    <LocationOrder>7</LocationOrder>
    <LocationType>S</LocationType>
    <TrainOrigin>Rosslare Europort</TrainOrigin>
    <TrainDestination>Dublin Connolly</TrainDestination>
    <ScheduledArrival>14:12:30</ScheduledArrival>
    <ScheduledDeparture>14:13:30</ScheduledDeparture>
    <ExpectedArrival>14:12:30</ExpectedArrival>
    <ExpectedDeparture>14:13:30</ExpectedDeparture>
    <Arrival/>
    <Departure/>
    <AutoArrival/>
    <AutoDepart/>
    <StopType>-</StopType>
    </objTrainMovements>
    <objTrainMovements>
    <TrainCode>A609 </TrainCode>
    <TrainDate>22 Jul 2021</TrainDate>
    <LocationCode>RDRUM</LocationCode>
    <LocationFullName>Rathdrum</LocationFullName>
    <LocationOrder>8</LocationOrder>
    <LocationType>S</LocationType>
    <TrainOrigin>Rosslare Europort</TrainOrigin>
    <TrainDestination>Dublin Connolly</TrainDestination>
    <ScheduledArrival>14:28:30</ScheduledArrival>
    <ScheduledDeparture>14:29:30</ScheduledDeparture>
    <ExpectedArrival>14:28:30</ExpectedArrival>
    <ExpectedDeparture>14:29:30</ExpectedDeparture>
    <Arrival/>
    <Departure/>
    <AutoArrival/>
    <AutoDepart/>
    <StopType>-</StopType>
    </objTrainMovements>
    <objTrainMovements>
    <TrainCode>A609 </TrainCode>
    <TrainDate>22 Jul 2021</TrainDate>
    <LocationCode>WLOW</LocationCode>
    <LocationFullName>Wicklow</LocationFullName>
    <LocationOrder>9</LocationOrder>
    <LocationType>S</LocationType>
    <TrainOrigin>Rosslare Europort</TrainOrigin>
    <TrainDestination>Dublin Connolly</TrainDestination>
    <ScheduledArrival>14:39:30</ScheduledArrival>
    <ScheduledDeparture>14:46:00</ScheduledDeparture>
    <ExpectedArrival>14:39:30</ExpectedArrival>
    <ExpectedDeparture>14:46:00</ExpectedDeparture>
    <Arrival/>
    <Departure/>
    <AutoArrival/>
    <AutoDepart/>
    <StopType>-</StopType>
    </objTrainMovements>
    <objTrainMovements>
    <TrainCode>A609 </TrainCode>
    <TrainDate>22 Jul 2021</TrainDate>
    <LocationCode>KCOOL</LocationCode>
    <LocationFullName>Kilcoole</LocationFullName>
    <LocationOrder>10</LocationOrder>
    <LocationType>T</LocationType>
    <TrainOrigin>Rosslare Europort</TrainOrigin>
    <TrainDestination>Dublin Connolly</TrainDestination>
    <ScheduledArrival>14:55:30</ScheduledArrival>
    <ScheduledDeparture>14:55:30</ScheduledDeparture>
    <ExpectedArrival>14:55:30</ExpectedArrival>
    <ExpectedDeparture>14:55:30</ExpectedDeparture>
    <Arrival/>
    <Departure/>
    <AutoArrival/>
    <AutoDepart/>
    <StopType>-</StopType>
    </objTrainMovements>
    <objTrainMovements>
    <TrainCode>A609 </TrainCode>
    <TrainDate>22 Jul 2021</TrainDate>
    <LocationCode>GSTNS</LocationCode>
    <LocationFullName>Greystones</LocationFullName>
    <LocationOrder>11</LocationOrder>
    <LocationType>S</LocationType>
    <TrainOrigin>Rosslare Europort</TrainOrigin>
    <TrainDestination>Dublin Connolly</TrainDestination>
    <ScheduledArrival>14:59:00</ScheduledArrival>
    <ScheduledDeparture>15:00:00</ScheduledDeparture>
    <ExpectedArrival>14:59:00</ExpectedArrival>
    <ExpectedDeparture>15:00:00</ExpectedDeparture>
    <Arrival/>
    <Departure/>
    <AutoArrival/>
    <AutoDepart/>
    <StopType>-</StopType>
    </objTrainMovements>
    <objTrainMovements>
    <TrainCode>A609 </TrainCode>
    <TrainDate>22 Jul 2021</TrainDate>
    <LocationCode>BR49</LocationCode>
    <LocationFullName/>
    <LocationOrder>12</LocationOrder>
    <LocationType>T</LocationType>
    <TrainOrigin>Rosslare Europort</TrainOrigin>
    <TrainDestination>Dublin Connolly</TrainDestination>
    <ScheduledArrival>15:04:00</ScheduledArrival>
    <ScheduledDeparture>15:04:00</ScheduledDeparture>
    <ExpectedArrival>15:04:00</ExpectedArrival>
    <ExpectedDeparture>15:04:00</ExpectedDeparture>
    <Arrival/>
    <Departure/>
    <AutoArrival/>
    <AutoDepart/>
    <StopType>-</StopType>
    </objTrainMovements>
    <objTrainMovements>
    <TrainCode>A609 </TrainCode>
    <TrainDate>22 Jul 2021</TrainDate>
    <LocationCode>BYARD</LocationCode>
    <LocationFullName>Bray Yard</LocationFullName>
    <LocationOrder>13</LocationOrder>
    <LocationType>T</LocationType>
    <TrainOrigin>Rosslare Europort</TrainOrigin>
    <TrainDestination>Dublin Connolly</TrainDestination>
    <ScheduledArrival>15:07:30</ScheduledArrival>
    <ScheduledDeparture>15:07:30</ScheduledDeparture>
    <ExpectedArrival>15:07:30</ExpectedArrival>
    <ExpectedDeparture>15:07:30</ExpectedDeparture>
    <Arrival/>
    <Departure/>
    <AutoArrival/>
    <AutoDepart/>
    <StopType>-</StopType>
    </objTrainMovements>
    <objTrainMovements>
    <TrainCode>A609 </TrainCode>
    <TrainDate>22 Jul 2021</TrainDate>
    <LocationCode>BRAY</LocationCode>
    <LocationFullName>Bray</LocationFullName>
    <LocationOrder>14</LocationOrder>
    <LocationType>S</LocationType>
    <TrainOrigin>Rosslare Europort</TrainOrigin>
    <TrainDestination>Dublin Connolly</TrainDestination>
    <ScheduledArrival>15:09:30</ScheduledArrival>
    <ScheduledDeparture>15:10:30</ScheduledDeparture>
    <ExpectedArrival>15:09:30</ExpectedArrival>
    <ExpectedDeparture>15:10:30</ExpectedDeparture>
    <Arrival/>
    <Departure/>
    <AutoArrival/>
    <AutoDepart/>
    <StopType>-</StopType>
    </objTrainMovements>
    <objTrainMovements>
    <TrainCode>A609 </TrainCode>
    <TrainDate>22 Jul 2021</TrainDate>
    <LocationCode>SKILL</LocationCode>
    <LocationFullName>Shankill</LocationFullName>
    <LocationOrder>15</LocationOrder>
    <LocationType>T</LocationType>
    <TrainOrigin>Rosslare Europort</TrainOrigin>
    <TrainDestination>Dublin Connolly</TrainDestination>
    <ScheduledArrival>15:14:30</ScheduledArrival>
    <ScheduledDeparture>15:14:30</ScheduledDeparture>
    <ExpectedArrival>15:14:30</ExpectedArrival>
    <ExpectedDeparture>15:14:30</ExpectedDeparture>
    <Arrival/>
    <Departure/>
    <AutoArrival/>
    <AutoDepart/>
    <StopType>-</StopType>
    </objTrainMovements>
    <objTrainMovements>
    <TrainCode>A609 </TrainCode>
    <TrainDate>22 Jul 2021</TrainDate>
    <LocationCode>KILNY</LocationCode>
    <LocationFullName>Killiney</LocationFullName>
    <LocationOrder>16</LocationOrder>
    <LocationType>T</LocationType>
    <TrainOrigin>Rosslare Europort</TrainOrigin>
    <TrainDestination>Dublin Connolly</TrainDestination>
    <ScheduledArrival>15:17:30</ScheduledArrival>
    <ScheduledDeparture>15:17:30</ScheduledDeparture>
    <ExpectedArrival>15:17:30</ExpectedArrival>
    <ExpectedDeparture>15:17:30</ExpectedDeparture>
    <Arrival/>
    <Departure/>
    <AutoArrival/>
    <AutoDepart/>
    <StopType>-</StopType>
    </objTrainMovements>
    <objTrainMovements>
    <TrainCode>A609 </TrainCode>
    <TrainDate>22 Jul 2021</TrainDate>
    <LocationCode>DLKEY</LocationCode>
    <LocationFullName>Dalkey</LocationFullName>
    <LocationOrder>17</LocationOrder>
    <LocationType>T</LocationType>
    <TrainOrigin>Rosslare Europort</TrainOrigin>
    <TrainDestination>Dublin Connolly</TrainDestination>
    <ScheduledArrival>15:21:00</ScheduledArrival>
    <ScheduledDeparture>15:21:00</ScheduledDeparture>
    <ExpectedArrival>15:21:00</ExpectedArrival>
    <ExpectedDeparture>15:21:00</ExpectedDeparture>
    <Arrival/>
    <Departure/>
    <AutoArrival/>
    <AutoDepart/>
    <StopType>-</StopType>
    </objTrainMovements>
    <objTrainMovements>
    <TrainCode>A609 </TrainCode>
    <TrainDate>22 Jul 2021</TrainDate>
    <LocationCode>GLGRY</LocationCode>
    <LocationFullName>Glenageary</LocationFullName>
    <LocationOrder>18</LocationOrder>
    <LocationType>T</LocationType>
    <TrainOrigin>Rosslare Europort</TrainOrigin>
    <TrainDestination>Dublin Connolly</TrainDestination>
    <ScheduledArrival>15:24:00</ScheduledArrival>
    <ScheduledDeparture>15:24:00</ScheduledDeparture>
    <ExpectedArrival>15:24:00</ExpectedArrival>
    <ExpectedDeparture>15:24:00</ExpectedDeparture>
    <Arrival/>
    <Departure/>
    <AutoArrival/>
    <AutoDepart/>
    <StopType>-</StopType>
    </objTrainMovements>
    <objTrainMovements>
    <TrainCode>A609 </TrainCode>
    <TrainDate>22 Jul 2021</TrainDate>
    <LocationCode>SCOVE</LocationCode>
    <LocationFullName>Sandycove</LocationFullName>
    <LocationOrder>19</LocationOrder>
    <LocationType>T</LocationType>
    <TrainOrigin>Rosslare Europort</TrainOrigin>
    <TrainDestination>Dublin Connolly</TrainDestination>
    <ScheduledArrival>15:26:00</ScheduledArrival>
    <ScheduledDeparture>15:26:00</ScheduledDeparture>
    <ExpectedArrival>15:26:00</ExpectedArrival>
    <ExpectedDeparture>15:26:00</ExpectedDeparture>
    <Arrival/>
    <Departure/>
    <AutoArrival/>
    <AutoDepart/>
    <StopType>-</StopType>
    </objTrainMovements>
    <objTrainMovements>
    <TrainCode>A609 </TrainCode>
    <TrainDate>22 Jul 2021</TrainDate>
    <LocationCode>DLERY</LocationCode>
    <LocationFullName>Dun Laoghaire</LocationFullName>
    <LocationOrder>20</LocationOrder>
    <LocationType>S</LocationType>
    <TrainOrigin>Rosslare Europort</TrainOrigin>
    <TrainDestination>Dublin Connolly</TrainDestination>
    <ScheduledArrival>15:29:30</ScheduledArrival>
    <ScheduledDeparture>15:30:30</ScheduledDeparture>
    <ExpectedArrival>15:29:30</ExpectedArrival>
    <ExpectedDeparture>15:30:30</ExpectedDeparture>
    <Arrival/>
    <Departure/>
    <AutoArrival/>
    <AutoDepart/>
    <StopType>-</StopType>
    </objTrainMovements>
    <objTrainMovements>
    <TrainCode>A609 </TrainCode>
    <TrainDate>22 Jul 2021</TrainDate>
    <LocationCode>SHILL</LocationCode>
    <LocationFullName>Salthill and Monkstown</LocationFullName>
    <LocationOrder>21</LocationOrder>
    <LocationType>T</LocationType>
    <TrainOrigin>Rosslare Europort</TrainOrigin>
    <TrainDestination>Dublin Connolly</TrainDestination>
    <ScheduledArrival>15:32:30</ScheduledArrival>
    <ScheduledDeparture>15:32:30</ScheduledDeparture>
    <ExpectedArrival>15:32:30</ExpectedArrival>
    <ExpectedDeparture>15:32:30</ExpectedDeparture>
    <Arrival/>
    <Departure/>
    <AutoArrival/>
    <AutoDepart/>
    <StopType>-</StopType>
    </objTrainMovements>
    <objTrainMovements>
    <TrainCode>A609 </TrainCode>
    <TrainDate>22 Jul 2021</TrainDate>
    <LocationCode>SEAPT</LocationCode>
    <LocationFullName>Seapoint</LocationFullName>
    <LocationOrder>22</LocationOrder>
    <LocationType>T</LocationType>
    <TrainOrigin>Rosslare Europort</TrainOrigin>
    <TrainDestination>Dublin Connolly</TrainDestination>
    <ScheduledArrival>15:34:00</ScheduledArrival>
    <ScheduledDeparture>15:34:00</ScheduledDeparture>
    <ExpectedArrival>15:34:00</ExpectedArrival>
    <ExpectedDeparture>15:34:00</ExpectedDeparture>
    <Arrival/>
    <Departure/>
    <AutoArrival/>
    <AutoDepart/>
    <StopType>-</StopType>
    </objTrainMovements>
    <objTrainMovements>
    <TrainCode>A609 </TrainCode>
    <TrainDate>22 Jul 2021</TrainDate>
    <LocationCode>BROCK</LocationCode>
    <LocationFullName>Blackrock</LocationFullName>
    <LocationOrder>23</LocationOrder>
    <LocationType>T</LocationType>
    <TrainOrigin>Rosslare Europort</TrainOrigin>
    <TrainDestination>Dublin Connolly</TrainDestination>
    <ScheduledArrival>15:36:00</ScheduledArrival>
    <ScheduledDeparture>15:36:00</ScheduledDeparture>
    <ExpectedArrival>15:36:00</ExpectedArrival>
    <ExpectedDeparture>15:36:00</ExpectedDeparture>
    <Arrival/>
    <Departure/>
    <AutoArrival/>
    <AutoDepart/>
    <StopType>-</StopType>
    </objTrainMovements>
    <objTrainMovements>
    <TrainCode>A609 </TrainCode>
    <TrainDate>22 Jul 2021</TrainDate>
    <LocationCode>BTSTN</LocationCode>
    <LocationFullName>Booterstown</LocationFullName>
    <LocationOrder>24</LocationOrder>
    <LocationType>T</LocationType>
    <TrainOrigin>Rosslare Europort</TrainOrigin>
    <TrainDestination>Dublin Connolly</TrainDestination>
    <ScheduledArrival>15:38:30</ScheduledArrival>
    <ScheduledDeparture>15:38:30</ScheduledDeparture>
    <ExpectedArrival>15:38:30</ExpectedArrival>
    <ExpectedDeparture>15:38:30</ExpectedDeparture>
    <Arrival/>
    <Departure/>
    <AutoArrival/>
    <AutoDepart/>
    <StopType>-</StopType>
    </objTrainMovements>
    <objTrainMovements>
    <TrainCode>A609 </TrainCode>
    <TrainDate>22 Jul 2021</TrainDate>
    <LocationCode>SIDNY</LocationCode>
    <LocationFullName>Sydney Parade</LocationFullName>
    <LocationOrder>25</LocationOrder>
    <LocationType>T</LocationType>
    <TrainOrigin>Rosslare Europort</TrainOrigin>
    <TrainDestination>Dublin Connolly</TrainDestination>
    <ScheduledArrival>15:41:00</ScheduledArrival>
    <ScheduledDeparture>15:41:00</ScheduledDeparture>
    <ExpectedArrival>15:41:00</ExpectedArrival>
    <ExpectedDeparture>15:41:00</ExpectedDeparture>
    <Arrival/>
    <Departure/>
    <AutoArrival/>
    <AutoDepart/>
    <StopType>-</StopType>
    </objTrainMovements>
    <objTrainMovements>
    <TrainCode>A609 </TrainCode>
    <TrainDate>22 Jul 2021</TrainDate>
    <LocationCode>SMONT</LocationCode>
    <LocationFullName>Sandymount</LocationFullName>
    <LocationOrder>26</LocationOrder>
    <LocationType>T</LocationType>
    <TrainOrigin>Rosslare Europort</TrainOrigin>
    <TrainDestination>Dublin Connolly</TrainDestination>
    <ScheduledArrival>15:43:00</ScheduledArrival>
    <ScheduledDeparture>15:43:00</ScheduledDeparture>
    <ExpectedArrival>15:43:00</ExpectedArrival>
    <ExpectedDeparture>15:43:00</ExpectedDeparture>
    <Arrival/>
    <Departure/>
    <AutoArrival/>
    <AutoDepart/>
    <StopType>-</StopType>
    </objTrainMovements>
    <objTrainMovements>
    <TrainCode>A609 </TrainCode>
    <TrainDate>22 Jul 2021</TrainDate>
    <LocationCode>LDWNE</LocationCode>
    <LocationFullName>Lansdowne Road</LocationFullName>
    <LocationOrder>27</LocationOrder>
    <LocationType>T</LocationType>
    <TrainOrigin>Rosslare Europort</TrainOrigin>
    <TrainDestination>Dublin Connolly</TrainDestination>
    <ScheduledArrival>15:45:30</ScheduledArrival>
    <ScheduledDeparture>15:45:30</ScheduledDeparture>
    <ExpectedArrival>15:45:30</ExpectedArrival>
    <ExpectedDeparture>15:45:30</ExpectedDeparture>
    <Arrival/>
    <Departure/>
    <AutoArrival/>
    <AutoDepart/>
    <StopType>-</StopType>
    </objTrainMovements>
    <objTrainMovements>
    <TrainCode>A609 </TrainCode>
    <TrainDate>22 Jul 2021</TrainDate>
    <LocationCode>GCDK</LocationCode>
    <LocationFullName>Grand Canal Dock</LocationFullName>
    <LocationOrder>28</LocationOrder>
    <LocationType>T</LocationType>
    <TrainOrigin>Rosslare Europort</TrainOrigin>
    <TrainDestination>Dublin Connolly</TrainDestination>
    <ScheduledArrival>15:48:30</ScheduledArrival>
    <ScheduledDeparture>15:48:30</ScheduledDeparture>
    <ExpectedArrival>15:48:30</ExpectedArrival>
    <ExpectedDeparture>15:48:30</ExpectedDeparture>
    <Arrival/>
    <Departure/>
    <AutoArrival/>
    <AutoDepart/>
    <StopType>-</StopType>
    </objTrainMovements>
    <objTrainMovements>
    <TrainCode>A609 </TrainCode>
    <TrainDate>22 Jul 2021</TrainDate>
    <LocationCode>DC427</LocationCode>
    <LocationFullName/>
    <LocationOrder>29</LocationOrder>
    <LocationType>T</LocationType>
    <TrainOrigin>Rosslare Europort</TrainOrigin>
    <TrainDestination>Dublin Connolly</TrainDestination>
    <ScheduledArrival>15:49:00</ScheduledArrival>
    <ScheduledDeparture>15:49:00</ScheduledDeparture>
    <ExpectedArrival>15:49:00</ExpectedArrival>
    <ExpectedDeparture>15:49:00</ExpectedDeparture>
    <Arrival/>
    <Departure/>
    <AutoArrival/>
    <AutoDepart/>
    <StopType>-</StopType>
    </objTrainMovements>
    <objTrainMovements>
    <TrainCode>A609 </TrainCode>
    <TrainDate>22 Jul 2021</TrainDate>
    <LocationCode>PERSE</LocationCode>
    <LocationFullName>Dublin Pearse</LocationFullName>
    <LocationOrder>30</LocationOrder>
    <LocationType>S</LocationType>
    <TrainOrigin>Rosslare Europort</TrainOrigin>
    <TrainDestination>Dublin Connolly</TrainDestination>
    <ScheduledArrival>15:50:00</ScheduledArrival>
    <ScheduledDeparture>15:51:00</ScheduledDeparture>
    <ExpectedArrival>15:50:00</ExpectedArrival>
    <ExpectedDeparture>15:51:00</ExpectedDeparture>
    <Arrival/>
    <Departure/>
    <AutoArrival/>
    <AutoDepart/>
    <StopType>-</StopType>
    </objTrainMovements>
    <objTrainMovements>
    <TrainCode>A609 </TrainCode>
    <TrainDate>22 Jul 2021</TrainDate>
    <LocationCode>TARA</LocationCode>
    <LocationFullName>Tara Street</LocationFullName>
    <LocationOrder>31</LocationOrder>
    <LocationType>S</LocationType>
    <TrainOrigin>Rosslare Europort</TrainOrigin>
    <TrainDestination>Dublin Connolly</TrainDestination>
    <ScheduledArrival>15:52:00</ScheduledArrival>
    <ScheduledDeparture>15:53:00</ScheduledDeparture>
    <ExpectedArrival>15:52:00</ExpectedArrival>
    <ExpectedDeparture>15:53:00</ExpectedDeparture>
    <Arrival/>
    <Departure/>
    <AutoArrival/>
    <AutoDepart/>
    <StopType>-</StopType>
    </objTrainMovements>
    <objTrainMovements>
    <TrainCode>A609 </TrainCode>
    <TrainDate>22 Jul 2021</TrainDate>
    <LocationCode>CNLLY</LocationCode>
    <LocationFullName>Dublin Connolly</LocationFullName>
    <LocationOrder>32</LocationOrder>
    <LocationType>D</LocationType>
    <TrainOrigin>Rosslare Europort</TrainOrigin>
    <TrainDestination>Dublin Connolly</TrainDestination>
    <ScheduledArrival>15:56:00</ScheduledArrival>
    <ScheduledDeparture>00:00:00</ScheduledDeparture>
    <ExpectedArrival>15:56:00</ExpectedArrival>
    <ExpectedDeparture>00:00:00</ExpectedDeparture>
    <Arrival/>
    <Departure/>
    <AutoArrival/>
    <AutoDepart/>
    <StopType>-</StopType>
    </objTrainMovements>
    </ArrayOfObjTrainMovements>
    """
    
    // Missing traincode from first objTrainMovements
    let invalidTrainMovements =
        """
        <ArrayOfObjTrainMovements xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns="http://api.irishrail.ie/realtime/">
        <objTrainMovements>
        <TrainDate>22 Jul 2021</TrainDate>
        <LocationCode>TARA</LocationCode>
        <LocationFullName>Tara Street</LocationFullName>
        <LocationOrder>1</LocationOrder>
        <LocationType>S</LocationType>
        <TrainOrigin>Rosslare Europort</TrainOrigin>
        <TrainDestination>Dublin Connolly</TrainDestination>
        <ScheduledArrival>15:52:00</ScheduledArrival>
        <ScheduledDeparture>15:53:00</ScheduledDeparture>
        <ExpectedArrival>15:52:00</ExpectedArrival>
        <ExpectedDeparture>15:53:00</ExpectedDeparture>
        <Arrival/>
        <Departure/>
        <AutoArrival/>
        <AutoDepart/>
        <StopType>-</StopType>
        </objTrainMovements>
        <objTrainMovements>
        <TrainCode>A609 </TrainCode>
        <TrainDate>22 Jul 2021</TrainDate>
        <LocationCode>CNLLY</LocationCode>
        <LocationFullName>Dublin Connolly</LocationFullName>
        <LocationOrder>2</LocationOrder>
        <LocationType>D</LocationType>
        <TrainOrigin>Rosslare Europort</TrainOrigin>
        <TrainDestination>Dublin Connolly</TrainDestination>
        <ScheduledArrival>15:56:00</ScheduledArrival>
        <ScheduledDeparture>00:00:00</ScheduledDeparture>
        <ExpectedArrival>15:56:00</ExpectedArrival>
        <ExpectedDeparture>00:00:00</ExpectedDeparture>
        <Arrival/>
        <Departure/>
        <AutoArrival/>
        <AutoDepart/>
        <StopType>-</StopType>
        </objTrainMovements>
        </ArrayOfObjTrainMovements>
        """
}
