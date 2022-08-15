This project has been created for a bachelor thesis. Topic of the thesis: Conceptual project of a car cockpit made in virtual technology 

Main focus of this project was to design digital car dashboard similar to the ones in Tesla, Mercedes or VW. 
This dashboard includes: Speedometer, Tachometer, fuel and temperature gauge and middle panel in which are includeded: information panel, music player, warnings panel and GPS.
To add attractiveness to the dashboard there are 2 different modes: Sport and City.
Whole project has been created in QT using QML.

Dashboard controlls:
- D - "start car", setting fuel and temperature gauges, enabling acceleration and deceleration,
- W - acceleration,
- S - deceleration,
- Q - left turn signal,
- E - right turn signal,
- Space - hand brake,
- M - play music,
- N - stop music,
- L - turn on lights,
- Arrow Up - higher gear,
- Arrow Down - lower gear,
- Right Arrow - changing middle panel to the next,
- Left Arror - changing middle panel to the previous,
- 1 - city mode,
- 2 - sport mode. 

Display modes:
- City - displays all informations,
- Sport - more "aggresive" look, on the dashboard are displayed limited informations.

Speedometer operation:
- between 0 - 220, the speedometer color is blue, which means that the speed is in the correct range
- between 220-250, the color changes to red, which means the speed is too high
- the exact speed is also displayed in the center


Tachometer Operation:
- between 0 - 5000, the color is blue, which means that the revolutions are in the correct range
- between 5000 - 6500 the color changes to yellow, which means that the manure is still acceptable, but you need to shift to a higher gear
- above 6500, the color turns red, which means the RPM is too high
- in the middle, the RPM and the current gear are displayed, where 'P' stands for the parking gear, switched on and off with the 'D' button

Center Panel Operation:
- the first panel displays information about the available distance that can be traveled with the current fuel level and fuel consumption, average fuel consumption and total distance traveled are also displayed
- the second panel displays the music, author and title
- the third screen shows messages regarding non-operating components or problems with them, for example, the ABS system is not working
- the fourth panel displays GPS navigation
  
