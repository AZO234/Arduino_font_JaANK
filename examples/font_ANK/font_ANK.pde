#include <string.h>
#include <FONTX2.h>

extern FONTX2_Header_ANK_t tNaga10K;
extern FONTX2_Header_ANK_t tILGH16XB;
extern FONTX2_Header_ANK_t tILMH16XB;

void FontImageSerialWrite(const FONTX2_Header_ANK_t* ptANK, const char* strString) {
  int iLen = strlen(strString);
  int iLocate = 0;
  int i, j, k;
  unsigned char aucFontImage[8];
  char strOutput[64];

  while(iLocate < iLen) {
    sprintf(strOutput, "Character : '%c'\n", strString[iLocate]);
    iLocate += FONTX2_ANK_GetFontImage(aucFontImage, ptANK, &strString[iLocate]);
    Serial.write(strOutput);
    for(j = 0; j < ptANK->tCommon.ucFontHeight; j++) {
      for(i = 0; i < ptANK->tCommon.ucFontWidth; i++) {
        if(((aucFontImage[j + k] >> (7 - i)) & 0x1) == 0) {
          Serial.write("  ");
        } else {
          Serial.write("@@");
        }
      }
      Serial.write("\n");
    }
  }
}

void setup() {
  // put your setup code here, to run once:
  char strString[] = "ABC";
  
  Serial.begin(115200);
  delay(10);

  FontImageSerialWrite(&tNaga10K, strString);
  FontImageSerialWrite(&tILGH16XB, strString);
  FontImageSerialWrite(&tILMH16XB, strString);
}

void loop() {
  // put your main code here, to run repeatedly:

}
