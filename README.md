# Microphone + Digital to Analog Converter
__________________________________________
FPGA:       Arctix 7 Basys 3

Microphone: Pmod MIC

DAC:        PmodDA1
__________________________________________
Bitstream is precompiled for Arctix 7 Basys 3 board.

Sources are finished and working, though many bug fixes are required.
If things aren't working, take a look at the constrains file and make sure all the pins for your board match the pins I used. If they do not, change them to match your setup.

Expected waveforms were posted to assist with debug.  Remember this code does have a few problems; be sure to check the TO DO list in the top file for a list of improvements that need to be made to work more smoothly.
