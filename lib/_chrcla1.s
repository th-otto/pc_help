	.include "ctype.i"

	.globl _ChrCla1

	.text

_ChrCla1:
	.dc.b _IScntrl
	.dc.b _IScntrl
	.dc.b _IScntrl
	.dc.b _IScntrl
	.dc.b _IScntrl
	.dc.b _IScntrl
	.dc.b _IScntrl
	.dc.b _IScntrl
	.dc.b _IScntrl
	.dc.b _IScntrl+_ISspace
	.dc.b _IScntrl+_ISspace
	.dc.b _IScntrl+_ISspace
	.dc.b _IScntrl+_ISspace
	.dc.b _IScntrl+_ISspace
	.dc.b _IScntrl
	.dc.b _IScntrl
	.dc.b _IScntrl
	.dc.b _IScntrl
	.dc.b _IScntrl
	.dc.b _IScntrl
	.dc.b _IScntrl
	.dc.b _IScntrl
	.dc.b _IScntrl
	.dc.b _IScntrl
	.dc.b _IScntrl
	.dc.b _IScntrl
	.dc.b _IScntrl
	.dc.b _IScntrl
	.dc.b _IScntrl
	.dc.b _IScntrl
	.dc.b _IScntrl
	.dc.b _IScntrl
	.dc.b _ISspace
	.dc.b _ISpunct
	.dc.b _ISpunct
	.dc.b _ISpunct
	.dc.b _ISpunct
	.dc.b _ISpunct
	.dc.b _ISpunct
	.dc.b _ISpunct
	.dc.b _ISpunct
	.dc.b _ISpunct
	.dc.b _ISpunct
	.dc.b _ISpunct
	.dc.b _ISpunct
	.dc.b _ISpunct
	.dc.b _ISpunct
	.dc.b _ISpunct
	.dc.b _ISalnum+_ISxdigit
	.dc.b _ISalnum+_ISxdigit
	.dc.b _ISalnum+_ISxdigit
	.dc.b _ISalnum+_ISxdigit
	.dc.b _ISalnum+_ISxdigit
	.dc.b _ISalnum+_ISxdigit
	.dc.b _ISalnum+_ISxdigit
	.dc.b _ISalnum+_ISxdigit
	.dc.b _ISalnum+_ISxdigit
	.dc.b _ISalnum+_ISxdigit
	.dc.b _ISpunct
	.dc.b _ISpunct
	.dc.b _ISpunct
	.dc.b _ISpunct
	.dc.b _ISpunct
	.dc.b _ISpunct
	.dc.b 0
	.dc.b _ISalnum+_ISalpha+_ISupper+_ISxdigit
	.dc.b _ISalnum+_ISalpha+_ISupper+_ISxdigit
	.dc.b _ISalnum+_ISalpha+_ISupper+_ISxdigit
	.dc.b _ISalnum+_ISalpha+_ISupper+_ISxdigit
	.dc.b _ISalnum+_ISalpha+_ISupper+_ISxdigit
	.dc.b _ISalnum+_ISalpha+_ISupper+_ISxdigit
	.dc.b _ISalnum+_ISalpha+_ISupper
	.dc.b _ISalnum+_ISalpha+_ISupper
	.dc.b _ISalnum+_ISalpha+_ISupper
	.dc.b _ISalnum+_ISalpha+_ISupper
	.dc.b _ISalnum+_ISalpha+_ISupper
	.dc.b _ISalnum+_ISalpha+_ISupper
	.dc.b _ISalnum+_ISalpha+_ISupper
	.dc.b _ISalnum+_ISalpha+_ISupper
	.dc.b _ISalnum+_ISalpha+_ISupper
	.dc.b _ISalnum+_ISalpha+_ISupper
	.dc.b _ISalnum+_ISalpha+_ISupper
	.dc.b _ISalnum+_ISalpha+_ISupper
	.dc.b _ISalnum+_ISalpha+_ISupper
	.dc.b _ISalnum+_ISalpha+_ISupper
	.dc.b _ISalnum+_ISalpha+_ISupper
	.dc.b _ISalnum+_ISalpha+_ISupper
	.dc.b _ISalnum+_ISalpha+_ISupper
	.dc.b _ISalnum+_ISalpha+_ISupper
	.dc.b _ISalnum+_ISalpha+_ISupper
	.dc.b _ISalnum+_ISalpha+_ISupper
	.dc.b _ISpunct
	.dc.b _ISpunct
	.dc.b _ISpunct
	.dc.b _ISpunct
	.dc.b _ISpunct
	.dc.b _ISpunct
	.dc.b _ISalnum+_ISalpha+_ISlower+_ISxdigit
	.dc.b _ISalnum+_ISalpha+_ISlower+_ISxdigit
	.dc.b _ISalnum+_ISalpha+_ISlower+_ISxdigit
	.dc.b _ISalnum+_ISalpha+_ISlower+_ISxdigit
	.dc.b _ISalnum+_ISalpha+_ISlower+_ISxdigit
	.dc.b _ISalnum+_ISalpha+_ISlower+_ISxdigit
	.dc.b _ISalnum+_ISalpha+_ISlower
	.dc.b _ISalnum+_ISalpha+_ISlower
	.dc.b _ISalnum+_ISalpha+_ISlower
	.dc.b _ISalnum+_ISalpha+_ISlower
	.dc.b _ISalnum+_ISalpha+_ISlower
	.dc.b _ISalnum+_ISalpha+_ISlower
	.dc.b _ISalnum+_ISalpha+_ISlower
	.dc.b _ISalnum+_ISalpha+_ISlower
	.dc.b _ISalnum+_ISalpha+_ISlower
	.dc.b _ISalnum+_ISalpha+_ISlower
	.dc.b _ISalnum+_ISalpha+_ISlower
	.dc.b _ISalnum+_ISalpha+_ISlower
	.dc.b _ISalnum+_ISalpha+_ISlower
	.dc.b _ISalnum+_ISalpha+_ISlower
	.dc.b _ISalnum+_ISalpha+_ISlower
	.dc.b _ISalnum+_ISalpha+_ISlower
	.dc.b _ISalnum+_ISalpha+_ISlower
	.dc.b _ISalnum+_ISalpha+_ISlower
	.dc.b _ISalnum+_ISalpha+_ISlower
	.dc.b _ISalnum+_ISalpha+_ISlower
	.dc.b _ISpunct
	.dc.b _ISpunct
	.dc.b _ISpunct
	.dc.b _ISpunct
	.dc.b _IScntrl

	.dc.b _ISupper /* 0x80	0x00C7	LATIN CAPITAL LETTER C WITH CEDILLA       	*/
	.dc.b _ISlower /* 0x81	0x00FC	LATIN SMALL LETTER U WITH DIAERESIS       	*/
	.dc.b _ISlower /* 0x82	0x00E9	LATIN SMALL LETTER E WITH ACUTE           	*/
	.dc.b _ISlower /* 0x83	0x00E2	LATIN SMALL LETTER A WITH CIRCUMFLEX      	*/
	.dc.b _ISlower /* 0x84	0x00E4	LATIN SMALL LETTER A WITH DIAERESIS       	*/
	.dc.b _ISlower /* 0x85	0x00E0	LATIN SMALL LETTER A WITH GRAVE           	*/
	.dc.b _ISlower /* 0x86	0x00E5	LATIN SMALL LETTER A WITH RING ABOVE      	*/
	.dc.b _ISlower /* 0x87	0x00E7	LATIN SMALL LETTER C WITH CEDILLA         	*/
	.dc.b _ISlower /* 0x88	0x00EA	LATIN SMALL LETTER E WITH CIRCUMFLEX      	*/
	.dc.b _ISlower /* 0x89	0x00EB	LATIN SMALL LETTER E WITH DIAERESIS       	*/
	.dc.b _ISlower /* 0x8A	0x00E8	LATIN SMALL LETTER E WITH GRAVE           	*/
	.dc.b _ISlower /* 0x8B	0x00EF	LATIN SMALL LETTER I WITH DIAERESIS       	*/
	.dc.b _ISlower /* 0x8C	0x00EE	LATIN SMALL LETTER I WITH CIRCUMFLEX      	*/
	.dc.b _ISlower /* 0x8D	0x00EC	LATIN SMALL LETTER I WITH GRAVE           	*/
	.dc.b _ISupper /* 0x8E	0x00C4	LATIN CAPITAL LETTER A WITH DIAERESIS     	*/
	.dc.b _ISupper /* 0x8F	0x00C5	LATIN CAPITAL LETTER A WITH RING ABOVE    	*/
	.dc.b _ISupper /* 0x90	0x00C9	LATIN CAPITAL LETTER E WITH ACUTE         	*/
	.dc.b _ISlower /* 0x91	0x00E6	LATIN SMALL LETTER AE                     	*/
	.dc.b _ISupper /* 0x92	0x00C6	LATIN CAPITAL LETTER AE                   	*/
	.dc.b _ISlower /* 0x93	0x00F4	LATIN SMALL LETTER O WITH CIRCUMFLEX      	*/
	.dc.b _ISlower /* 0x94	0x00F6	LATIN SMALL LETTER O WITH DIAERESIS       	*/
	.dc.b _ISlower /* 0x95	0x00F2	LATIN SMALL LETTER O WITH GRAVE           	*/
	.dc.b _ISlower /* 0x96	0x00FB	LATIN SMALL LETTER U WITH CIRCUMFLEX      	*/
	.dc.b _ISlower /* 0x97	0x00F9	LATIN SMALL LETTER U WITH GRAVE           	*/
	.dc.b _ISlower /* 0x98	0x00FF	LATIN SMALL LETTER Y WITH DIAERESIS       	*/
	.dc.b _ISlower /* 0x99	0x00D6	LATIN CAPITAL LETTER O WITH DIAERESIS     	*/
	.dc.b _ISlower /* 0x9A	0x00DC	LATIN CAPITAL LETTER U WITH DIAERESIS     	*/
	.dc.b _ISlower /* 0x9B	0x00A2	CENT SIGN                                 	*/
	.dc.b _ISupper /* 0x9C	0x00A3	POUND SIGN                                	*/
	.dc.b _ISlower /* 0x9D	0x00A5	YEN SIGN                                  	*/
	.dc.b _ISlower /* 0x9E	0x00DF	LATIN SMALL LETTER SHARP S                	*/
	.dc.b _ISlower /* 0x9F	0x0192	LATIN SMALL LETTER F WITH HOOK            	*/
	.dc.b _ISlower /* 0xA0	0x00E1	LATIN SMALL LETTER A WITH ACUTE           	*/
	.dc.b _ISlower /* 0xA1	0x00ED	LATIN SMALL LETTER I WITH ACUTE           	*/
	.dc.b _ISlower /* 0xA2	0x00F3	LATIN SMALL LETTER O WITH ACUTE           	*/
	.dc.b _ISlower /* 0xA3	0x00FA	LATIN SMALL LETTER U WITH ACUTE           	*/
	.dc.b _ISlower /* 0xA4	0x00F1	LATIN SMALL LETTER N WITH TILDE           	*/
	.dc.b _ISupper /* 0xA5	0x00D1	LATIN CAPITAL LETTER N WITH TILDE         	*/
	.dc.b _ISlower /* 0xA6	0x00AA	FEMININE ORDINAL INDICATOR                	*/
	.dc.b 0 /* 0xA7	0x00BA	MASCULINE ORDINAL INDICATOR               	*/
	.dc.b 0                          /* 0xA8	0x00BF	INVERTED QUESTION MARK                    	*/
	.dc.b 0                          /* 0xA9	0x2310	REVERSED NOT SIGN                         	*/
	.dc.b 0                          /* 0xAA	0x00AC	NOT SIGN                                  	*/
	.dc.b 0                          /* 0xAB	0x00BD	VULGAR FRACTION ONE HALF                  	*/
	.dc.b 0                          /* 0xAC	0x00BC	VULGAR FRACTION ONE QUARTER               	*/
	.dc.b 0                          /* 0xAD	0x00A1	INVERTED EXCLAMATION MARK                 	*/
	.dc.b 0                          /* 0xAE	0x00AB	LEFT-POINTING DOUBLE ANGLE QUOTATION MARK 	*/
	.dc.b 0                          /* 0xAF	0x00BB	RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK	*/
	.dc.b _ISlower /* 0xB0	0x00E3	LATIN SMALL LETTER A WITH TILDE           	*/
	.dc.b _ISlower /* 0xB1	0x00F5	LATIN SMALL LETTER O WITH TILDE           	*/
	.dc.b _ISupper /* 0xB2	0x00D8	LATIN CAPITAL LETTER O WITH STROKE        	*/
	.dc.b _ISlower /* 0xB3	0x00F8	LATIN SMALL LETTER O WITH STROKE          	*/
	.dc.b _ISlower /* 0xB4	0x0153	LATIN SMALL LIGATURE OE                   	*/
	.dc.b _ISupper /* 0xB5	0x0152	LATIN CAPITAL LIGATURE OE                 	*/
	.dc.b _ISupper /* 0xB6	0x00C0	LATIN CAPITAL LETTER A WITH GRAVE         	*/
	.dc.b _ISupper /* 0xB7	0x00C3	LATIN CAPITAL LETTER A WITH TILDE         	*/
	.dc.b _ISupper /* 0xB8	0x00D5	LATIN CAPITAL LETTER O WITH TILDE         	*/
	.dc.b 0                          /* 0xB9	0x00A8	DIAERESIS                                 	*/
	.dc.b 0                          /* 0xBA	0x00B4	ACUTE ACCENT                              	*/
	.dc.b 0                          /* 0xBB	0x2020	DAGGER                                    	*/
	.dc.b 0                          /* 0xBC	0x00B6	PILCROW SIGN                              	*/
	.dc.b 0                          /* 0xBD	0x00A9	COPYRIGHT SIGN                            	*/
	.dc.b 0                          /* 0xBE	0x00AE	REGISTERED SIGN                           	*/
	.dc.b 0                          /* 0xBF	0x2122	TRADE MARK SIGN                           	*/
	.dc.b 0 /* 0xC0	0x0133	LATIN SMALL LIGATURE IJ                   	*/
	.dc.b _ISupper /* 0xC1	0x0132	LATIN CAPITAL LIGATURE IJ                 	*/
	.dc.b 0                          /* 0xC2	0x05D0	HEBREW LETTER ALEF                        	*/
	.dc.b 0                          /* 0xC3	0x05D1	HEBREW LETTER BET                         	*/
	.dc.b 0                          /* 0xC4	0x05D2	HEBREW LETTER GIMEL                       	*/
	.dc.b 0                          /* 0xC5	0x05D3	HEBREW LETTER DALET                       	*/
	.dc.b 0                          /* 0xC6	0x05D4	HEBREW LETTER HE                          	*/
	.dc.b 0                          /* 0xC7	0x05D5	HEBREW LETTER VAV                         	*/
	.dc.b 0                          /* 0xC8	0x05D6	HEBREW LETTER ZAYIN                       	*/
	.dc.b 0                          /* 0xC9	0x05D7	HEBREW LETTER HET                         	*/
	.dc.b 0                          /* 0xCA	0x05D8	HEBREW LETTER TET                         	*/
	.dc.b 0                          /* 0xCB	0x05D9	HEBREW LETTER YOD                         	*/
	.dc.b 0                          /* 0xCC	0x05DB	HEBREW LETTER KAF                         	*/
	.dc.b 0                          /* 0xCD	0x05DC	HEBREW LETTER LAMED                       	*/
	.dc.b 0                          /* 0xCE	0x05DE	HEBREW LETTER MEM                         	*/
	.dc.b 0                          /* 0xCF	0x05E0	HEBREW LETTER NUN                         	*/
	.dc.b 0                          /* 0xD0	0x05E1	HEBREW LETTER SAMEKH                      	*/
	.dc.b 0                          /* 0xD1	0x05E2	HEBREW LETTER AYIN                        	*/
	.dc.b 0                          /* 0xD2	0x05E4	HEBREW LETTER PE                          	*/
	.dc.b 0                          /* 0xD3	0x05E6	HEBREW LETTER TSADI                       	*/
	.dc.b 0                          /* 0xD4	0x05E7	HEBREW LETTER QOF                         	*/
	.dc.b 0                          /* 0xD5	0x05E8	HEBREW LETTER RESH                        	*/
	.dc.b 0                          /* 0xD6	0x05E9	HEBREW LETTER SHIN                        	*/
	.dc.b 0                          /* 0xD7	0x05EA	HEBREW LETTER TAV                         	*/
	.dc.b 0                          /* 0xD8	0x05DF	HEBREW LETTER FINAL NUN                   	*/
	.dc.b 0                          /* 0xD9	0x05DA	HEBREW LETTER FINAL KAF                   	*/
	.dc.b 0                          /* 0xDA	0x05DD	HEBREW LETTER FINAL MEM                   	*/
	.dc.b 0                          /* 0xDB	0x05E3	HEBREW LETTER FINAL PE                    	*/
	.dc.b 0                          /* 0xDC	0x05E5	HEBREW LETTER FINAL TSADI                 	*/
	.dc.b 0                          /* 0xDD	0x00A7	SECTION SIGN                              	*/
	.dc.b 0                          /* 0xDE	0x2227	LOGICAL AND                               	*/
	.dc.b 0                          /* 0xDF	0x221E	INFINITY                                  	*/
	.dc.b 0                          /* 0xE0	0x03B1	GREEK SMALL LETTER ALPHA                  	*/
	.dc.b 0                          /* 0xE1	0x03B2	GREEK SMALL LETTER BETA                   	*/
	.dc.b 0                          /* 0xE2	0x0393	GREEK CAPITAL LETTER GAMMA                	*/
	.dc.b 0                          /* 0xE3	0x03C0	GREEK SMALL LETTER PI                     	*/
	.dc.b 0                          /* 0xE4	0x03A3	GREEK CAPITAL LETTER SIGMA                	*/
	.dc.b 0                          /* 0xE5	0x03C3	GREEK SMALL LETTER SIGMA                  	*/
	.dc.b 0                          /* 0xE6	0x00B5	MICRO SIGN                                	*/
	.dc.b 0                          /* 0xE7	0x03C4	GREEK SMALL LETTER TAU                    	*/
	.dc.b 0                          /* 0xE8	0x03A6	GREEK CAPITAL LETTER PHI                  	*/
	.dc.b 0                          /* 0xE9	0x0398	GREEK CAPITAL LETTER THETA                	*/
	.dc.b 0                          /* 0xEA	0x03A9	GREEK CAPITAL LETTER OMEGA                	*/
	.dc.b 0                          /* 0xEB	0x03B4	GREEK SMALL LETTER DELTA                  	*/
	.dc.b 0                          /* 0xEC	0x222E	CONTOUR INTEGRAL                          	*/
	.dc.b 0                          /* 0xED	0x03C6	GREEK SMALL LETTER PHI                    	*/
	.dc.b 0                          /* 0xEE	0x2208	ELEMENT OF                                  */
	.dc.b 0                          /* 0xEF	0x2229	INTERSECTION                              	*/
	.dc.b 0                          /* 0xF0	0x2261	IDENTICAL TO                              	*/
	.dc.b 0                          /* 0xF1	0x00B1	PLUS-MINUS SIGN                           	*/
	.dc.b 0                          /* 0xF2	0x2265	GREATER-THAN OR EQUAL TO                  	*/
	.dc.b 0                          /* 0xF3	0x2264	LESS-THAN OR EQUAL TO                     	*/
	.dc.b 0                          /* 0xF4	0x2320	TOP HALF INTEGRAL                         	*/
	.dc.b 0                          /* 0xF5	0x2321	BOTTOM HALF INTEGRAL                      	*/
	.dc.b 0                          /* 0xF6	0x00F7	DIVISION SIGN                             	*/
	.dc.b 0                          /* 0xF7	0x2248	ALMOST EQUAL TO                           	*/
	.dc.b 0                          /* 0xF8	0x00B0	DEGREE SIGN                               	*/
	.dc.b 0                          /* 0xF9	0x2219	BULLET OPERATOR                           	*/
	.dc.b 0                          /* 0xFA	0x00B7	MIDDLE DOT                                	*/
	.dc.b 0                          /* 0xFB	0x221A	SQUARE ROOT                               	*/
	.dc.b 0                          /* 0xFC	0x207F	SUPERSCRIPT LATIN SMALL LETTER N          	*/
	.dc.b 0                          /* 0xFD	0x00B2	SUPERSCRIPT TWO                           	*/
	.dc.b 0                          /* 0xFE	0x00B3	SUPERSCRIPT THREE                         	*/
	.dc.b 0                          /* 0xFF	0x00AF	MACRON                                    	*/
