#ifdef __AVR__
#include "avr/pgmspace.h"
#else
#endif
#include <Arduino.h>
#include "FONTX2.h"

unsigned int FONTX2_ANK_GetFontImage(unsigned char* pucFontImage, const FONTX2_Header_ANK_t* ptANK, const char* strString) {
	unsigned char ucData, ucLineSize;

	if(pucFontImage == NULL || ptANK == NULL || strString == NULL) {
		return 0;
	}

	if(ptANK->tCommon.ucFontWidth % 8 == 0) {
		ucLineSize = ptANK->tCommon.ucFontWidth / 8;
	} else {
		ucLineSize = ptANK->tCommon.ucFontWidth / 8 + 1;
	}

	for(ucData = 0; ucData < ptANK->tCommon.ucFontHeight * ucLineSize; ucData++) {
#ifdef __AVR__
		pucFontImage[ucData] = pgm_read_byte_near(ptANK->pucFontImage + (unsigned int)strString[0] * ptANK->tCommon.ucFontHeight * ucLineSize + ucData);
#else
		pucFontImage[ucData] = ptANK->pucFontImage[(unsigned int)strString[0] * ptANK->tCommon.ucFontHeight * ucLineSize + ucData];
#endif
	}

	return 1;
}
