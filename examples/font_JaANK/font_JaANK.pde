#include <stdint.h>
#include <stdbool.h>

#include <string.h>
#if defined(__AVR__)
#include <avr/pgmspace.h>
#elif defined(ESP8266)
#include <pgmspace.h>
#else
#endif
#include <FONTX2.h>

extern FONTX2_Header_ANK_t tNaga10K;
extern FONTX2_Header_ANK_t tILGH16XB;
extern FONTX2_Header_ANK_t tILMH16XB;
extern FONTX2_Header_ANK_t tHD44780_A00;
extern FONTX2_Header_ANK_t tHD44780_A02;

unsigned int FONTX2_ANK_GetFontImage(uint8_t* pu8FontImage, const FONTX2_Header_ANK_t* ptANK, const uint8_t u8Code) {
  uint8_t u8Data, u8LineSize;

  if(pu8FontImage == NULL || ptANK == NULL) {
    return 0;
  }

  if(ptANK->tCommon.u8FontWidth % 8 == 0) {
    u8LineSize = ptANK->tCommon.u8FontWidth / 8;
  } else {
    u8LineSize = ptANK->tCommon.u8FontWidth / 8 + 1;
  }

#if defined(__AVR__)
  for(u8Data = 0; u8Data < ptANK->tCommon.u8FontHeight * u8LineSize; u8Data++) {
    pu8FontImage[u8Data] = pgm_read_byte_near(ptANK->pu8FontImage + (uint32_t)u8Code * ptANK->tCommon.u8FontHeight * u8LineSize + u8Data);
  }
#elif defined(ESP8266)
  memcpy_P(pu8FontImage, &ptANK->pu8FontImage[(uint32_t)u8Code * ptANK->tCommon.u8FontHeight * u8LineSize], ptANK->tCommon.u8FontHeight * u8LineSize);
#else
  for(u8Data = 0; u8Data < ptANK->tCommon.u8FontHeight * u8LineSize; u8Data++) {
    pu8FontImage[u8Data] = ptANK->pu8FontImage[(uint32_t)u8Code * ptANK->tCommon.u8FontHeight * u8LineSize + u8Data];
  }
#endif

  return 1;
}

void FontImageSerialWrite(const FONTX2_Header_ANK_t* ptANK, const uint8_t* strString) {
  uint32_t k = 0;
  uint8_t i, j;
  uint8_t au8FontImage[64];
  uint8_t strOutput[64];

  while(strString[k]) {
    sprintf(strOutput, "Character : '%c'\n", strString[k]);
    FONTX2_ANK_GetFontImage(au8FontImage, ptANK, strString[k]);
    Serial.write((char*)strOutput);
    for(j = 0; j < ptANK->tCommon.u8FontHeight; j++) {
      for(i = 0; i < ptANK->tCommon.u8FontWidth; i++) {
        if(((au8FontImage[j] >> (7 - i)) & 0x1) == 0) {
          Serial.write("  ");
        } else {
          Serial.write("@@");
        }
      }
      Serial.write("\n");
    }
    k++;
  }
}

void setup() {
  // put your setup code here, to run once:
  uint8_t strString[] = "ABC";

  Serial.begin(9600);

  FontImageSerialWrite(&tNaga10K, strString);
  FontImageSerialWrite(&tILGH16XB, strString);
  FontImageSerialWrite(&tILMH16XB, strString);
  FontImageSerialWrite(&tHD44780_A00, strString);
  FontImageSerialWrite(&tHD44780_A02, strString);
}

void loop() {
  // put your main code here, to run repeatedly:

}
