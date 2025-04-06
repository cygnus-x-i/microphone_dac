# Audio to Electrical Analog Converter
__________________________________________
FPGA:       Arctix 7 Basys 3

Microphone: Pmod MIC3

DAC:        Pmod DA1
__________________________________________
Bitstream is precompiled for Arctix 7 Basys 3 board.

Sources are finished and working, though a few bug fixes are in progress.
If things aren't working, take a look at the constrains file and make sure all the pins for your board match the pins used there. If they do not, change them to match your setup.

Expected waveforms were posted to assist with debug. This code does have a few problems; be sure to check the TO DO list in the information section of the audio_dac_top file for a list of improvements that need to be made to work more smoothly.

Credits:
______________
Dallin Astling  ~  Jens Helquist

Function:
_____________
Convert sound to analog electrical signal

Possible future improvement - record and write to file?
