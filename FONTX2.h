#ifndef FONTX2_H
#define FONTX2_H

#include <stdint.h>

/* FONTX2 struct by AZO */

/* FONTX2 Header common */
typedef struct FONTX2_Header_Common {
  uint8_t au8Signature[6];
  uint8_t au8FontName[8];
  uint8_t u8FontWidth;
  uint8_t u8FontHeight;
  uint8_t u8CodeType;
} FONTX2_Header_Common_t;

typedef struct FONTX2_Code {
	uint16_t u16StartCode;
	uint16_t u16EndCode;
} FONTX2_Code_t;

/* FONTX2 Header ANK */
typedef struct FONTX2_Header_ANK {
	FONTX2_Header_Common_t tCommon;
	const uint8_t* pu8FontImage;
} FONTX2_Header_ANK_t;

/* FONTX2 Header FullSize */
typedef struct FONTX2_Header_FullSize {
	FONTX2_Header_Common_t tCommon;
	uint8_t u8BlockCount;
	FONTX2_Code_t* ptCode;
	const uint8_t* pu8FontImage;
} FONTX2_Header_FullSize_t;

#endif	/* FONTX2_H */
