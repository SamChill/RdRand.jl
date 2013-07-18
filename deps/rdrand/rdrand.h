#ifndef __RDRND_H__
#define __RDRND_H__

#include <stdint.h>

int cpucheck(void);

uint16_t rdrand16(void);
uint32_t rdrand32(void);
uint64_t rdrand64(void);

#endif
